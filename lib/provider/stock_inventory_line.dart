import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stockscanner/provider/models/responseApi.dart';
import 'package:stockscanner/provider/models/stock_inventory_line_model.dart';

import 'dart:convert';

class StockInventoryLineProvider extends ChangeNotifier {
  /// Estado privado del carrito.
  List<StockInventoryLine> _items = [];

  List<StockInventoryLine> get stockInventoryLine => _items;

  void set stockInventoryLine(List<StockInventoryLine> stockInvLine) {
    this._items = stockInvLine;
  }

  /// Añadir [item] al carro. Esta es la única manera de modificar el carrito desde fuera.
  void getStockInventoryLine(int inventoryId) async {
    print(inventoryId);
    final response = await http.get(
        'http://192.168.56.1:3000/stock-inventory/stock-details?inventory_id=$inventoryId');

    final responseApi = ResponseApi.fromJson(json.decode(response.body));

    final data = responseApi.data
        .map((model) => StockInventoryLine.fromJson(model))
        .toList();
    this.stockInventoryLine = data;
    // List<StockInventory> posts =
    // l.map((Map model) => StockInventory.fromJson(model)).toList();

    // Esta llamada dice a los widgets que están escuchando este modelo que se reconstruyan.
    notifyListeners();
  }
}
