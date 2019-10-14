import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stockscanner/provider/models/responseApi.dart';
import 'package:stockscanner/provider/models/stock_inventory_model.dart';
import 'dart:convert';

class StockInventoryProvider extends ChangeNotifier {
  // Estado privado del carrito.
  ResponseApi responseApi;
  List<StockInventory> _items = [];

  List<StockInventory> get stockInventory => _items;

  void set stockInventory(List<StockInventory> stockInv) {
    this._items = stockInv;
  }

  /// Añadir [item] al carro. Esta es la única manera de modificar el carrito desde fuera.
  void getStockInventory() async {
    final response =
        await http.get('http://192.168.56.1:3000/stock-inventory?limit=0&offset=0');
    final responseJson = json.decode(response.body);
    final responseApi = ResponseApi.fromJson(responseJson);
    print(responseApi);
    this._items = responseApi.data
        .map((model) => StockInventory.fromJson(model))
        .toList();

    // print(StockInventory);

    // final data = responseApi.data
    //     .map((model) => StockInventory.fromJson(model))
    //     .toList() as List<StockInventory>;
    // ;
    // this.stockInventory = data;
    // List<StockInventory> posts =
    // l.map((Map model) => StockInventory.fromJson(model)).toList();

    // Esta llamada dice a los widgets que están escuchando este modelo que se reconstruyan.
    notifyListeners();
  }
}
