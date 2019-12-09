import 'package:stockscanner/api/server_conn.dart';
import 'package:stockscanner/provider/server_provider.dart';
import 'dart:convert';

Future<List<dynamic>> getSetBarcodeViewState(
    {ServerProvider serverProvider, int stockInventoryId}) async {
  print(stockInventoryId);
  List<dynamic> stockInventory;

  final stockInventoryRes =
      await serverProvider.client.searchRead('stock.inventory', [
    ['id', '=', stockInventoryId]
  ], [
    'id',
    'company_id',
    'line_ids',
    'location_ids',
    'product_ids',
    'name',
    'state'
  ]);
  stockInventory = stockInventoryRes.getResult()['records'];
  final lineIdsRes =
      await serverProvider.client.searchRead('stock.inventory.line', [
    ['id', 'in', stockInventory[0]['line_ids']]
  ], [
    'id',
    'location_id',
    'package_id',
    'product_id',
    'product_qty',
    'product_uom_id',
    'theoretical_qty'
  ]);
  List<int> productProductVals = [];
  for (var lineId in lineIdsRes.getResult()['records']) {
    productProductVals.add(lineId['product_id'][0]);
  }
  final stockInventoryLine = lineIdsRes.getResult()['records'];
  final productProductRes =
      await serverProvider.client.searchRead('product.product', [
    ['id', 'in', productProductVals]
  ], [
    'barcode',
    'id',
    'display_name',
    'tracking'
  ]);
  final productProduct = productProductRes.getResult()['records'];

  for (var stockLine in stockInventoryLine) {
    for (var product in productProduct) {
      if (stockLine['product_id'][0] == product['id']) {
        stockLine['product_id'] = product;
      }
    }
  }
  stockInventory[0]['line_ids'] = stockInventoryLine;
  // print({'stockInventory', json.encode(stockInventory)});
  return stockInventory;
}

Future<List<dynamic>> getAllBarcodes(ServerProvider serverProvider) async {
  List<dynamic> response = [];
  dynamic barcodeProducts;

  final barcodeProductsRes =
      await serverProvider.client.searchRead('product.product', [
    ['barcode', '!=', false]
  ], [
    'id',
    'display_name',
    'barcode',
    'name',
    'tracking',
    'uom_id'
  ]);

  if (!barcodeProductsRes.hasError()) {
    barcodeProducts = barcodeProductsRes.getResult()['records'];
    print(barcodeProducts.length);
    for (var item in barcodeProducts) {
      // print(item);
      response.add({item['barcode']: item});
    }
  }
  return response;
}

getAllLocationByBarcode(ServerProvider serverProvider) async {
  List<Map<String, dynamic>> response = [];
  dynamic barcodeLocations;
  final barcodeLocationsRes =
      await serverProvider.client.searchRead('stock.location', [
    ['barcode', '!=', false]
  ], [
    'id',
    'display_name',
    'barcode',
    'parent_path',
  ]);

  if (!barcodeLocationsRes.hasError()) {
    barcodeLocations = barcodeLocationsRes.getResult()['records'];
    print(barcodeLocations.length);
    for (var item in barcodeLocations) {
      response.add({item['barcode']: item});
    }
    print(response);
    return response;
  }
}

getBarcodeNomenclatures(ServerProvider serverProvider) async {
  List<Map<String, dynamic>> response = [];
  String path = '/web/dataset/call_kw/barcode.rule/search_read';
  serverProvider.client.connect();
  Map<String, dynamic> params = {
    "args": [
      [
        ["barcode_nomenclature_id", "=", 1]
      ],
      ["name", "sequence", "type", "encoding", "pattern", "alias"]
    ],
    "model": "barcode.rule",
    "method": "search_read",
    "kwargs": {}
  };
  Map payload = serverProvider.client.createPayload(params);
  String url = serverProvider.client.createPath(path);
  final barcodeNomRes = await serverProvider.client.callRequest(url, payload);
  if (!barcodeNomRes.hasError()) {
    response = barcodeNomRes.getResult()['records'];
  }
  return response;
}
