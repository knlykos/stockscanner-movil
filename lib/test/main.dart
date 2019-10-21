import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:stockscanner/provider/models/stock_inventory_model.dart';

void main() async {
    final response =
        await http.get('http://localhost:3000/stock-inventory?limit=0&offset=0');

    Iterable l = json.decode(response.body);
    var lete = l.map((dynamic model) => StockInventory.fromJson(model)).toList();
    // print(lete[1].moveIds);
}
