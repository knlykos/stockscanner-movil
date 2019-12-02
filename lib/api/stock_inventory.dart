import 'package:stockscanner/api/server_conn.dart';

Future<List<dynamic>> getStockInventory() async {
  List<dynamic> response = [];
  final serverConn = ServerConn();


  final stockInventory =
      await serverConn.client.searchRead('stock.inventory', ["state", "=", "confirm"], ["name","date","location_ids","product_ids","company_id","state"]);

  if (!stockInventory.hasError()) {
    response = stockInventory.getResult()['records'];
  }
  return response;
}
