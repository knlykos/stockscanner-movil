import 'package:stockscanner/api/server_conn.dart';

getSetBarcodeViewState({int stockInventoryId}) async {
  List<Map<String, dynamic>> response = [];
  List<dynamic> stockInventory;
  List<int> lineIds;
  dynamic barcodeProducts;
  final serverConn = ServerConn();
  final stockInventoryRes =
      await serverConn.client.searchRead('stock.inventory', [
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
  // final resConfigSettingsRes =
  //     await serverConn.client.searchRead('res.config.settings', null, [
  //   'group_uom',
  //   'group_stock_tracking_owner',
  //   'group_stock_multi_locations',
  //   'group_stock_tracking_lot'
  // ]);
  // print({'error', resConfigSettingsRes.getResult()});
  stockInventory = stockInventoryRes.getResult()['records'];
  final lineIdsRes =
      await serverConn.client.searchRead('stock.inventory.line', [
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
  print(productProductVals);
  final productProductRes =
      await serverConn.client.searchRead('product.product', [
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
      ;
    }
  }
  stockInventory[0]['line_ids'] = stockInventoryLine;
  // print(json.encode(stockInventory));
  return stockInventory;
}

GetAllBarcodes() async {
  List<Map<String, dynamic>> response = [];
  dynamic barcodeProducts;
  final serverConn = ServerConn();
  final barcodeProductsRes =
      await serverConn.client.searchRead('product.product', [
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
    return response;
  }
}

GetAllLocationByBarcode() async {
  List<Map<String, dynamic>> response = [];
  dynamic barcodeLocations;
  final serverConn = ServerConn();
  final barcodeLocationsRes =
      await serverConn.client.searchRead('stock.location', [
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

getBarcodeNomenclatures() async {
  List<Map<String, dynamic>> response = [];
  String path = '/web/dataset/call_kw/barcode.rule/search_read';
  final serverConn = ServerConn();
  serverConn.client.connect();
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
  Map payload = serverConn.client.createPayload(params);
  String url = serverConn.client.createPath(path);
  final barcodeNomRes = await serverConn.client.callRequest(url, payload);
  if (!barcodeNomRes.hasError()) {
    response = barcodeNomRes.getResult()['records'];
  }
  ;
}
