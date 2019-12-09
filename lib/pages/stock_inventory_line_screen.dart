import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:odoo_api/odoo_api.dart';
import 'package:odoo_api/odoo_api_connector.dart';
import 'package:odoo_api/odoo_user_response.dart';
import 'package:odoo_api/odoo_version.dart';
import 'package:provider/provider.dart';
import 'package:stockscanner/api/stock_inventory_line.dart';
import 'package:stockscanner/pages/add_product.dart';
import 'package:stockscanner/pages/update_product.dart';
import 'package:stockscanner/provider/server_provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class StockInventoryLineScreen extends StatelessWidget {
  int stockInventoryId;
  int inventoryId;

  StockInventoryLineScreen({this.stockInventoryId, this.inventoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventario'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_to_photos),
            onPressed: () async {
              final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                  "#ff6666", "Cancel", true, ScanMode.BARCODE);
              print(barcodeScanRes);
            },
          )
        ],
      ),
      body: StockInventoryLineListView(
        inventoryId: inventoryId,
      ),
    );
  }
}

class StockInventoryLineListView extends StatefulWidget {
  final int stockInventoryId;
  final int inventoryId;

  StockInventoryLineListView({Key key, this.stockInventoryId, this.inventoryId})
      : super(key: key);
  @override
  _StockInventoryLineListViewState createState() =>
      _StockInventoryLineListViewState();
}

class _StockInventoryLineListViewState
    extends State<StockInventoryLineListView> {
  OdooClient client;
  List<dynamic> data;
  List<dynamic> products;
  int length;
  TextEditingController searchController;
  ServerProvider serverProvider;
  Future<List<dynamic>> productList;
  FocusNode myFocusNode;

  Image imageFromBase64String(String base64String) {
    if (base64String != null) {
      return Image.memory(base64Decode(base64String));
    }
  }

  @override
  void initState() {
    myFocusNode = FocusNode();
    this.data = [];
    products = [];
    length = 0;
    // TODO: implement initState
    searchController = new TextEditingController();

    super.initState();
  }

  void dispose() {
    // Limpia el nodo focus cuando se haga dispose al formulario
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final serverProvider = Provider.of<ServerProvider>(context);
    getStockInventoryLineState() async {
      final result = await getSetBarcodeViewState(
          serverProvider: serverProvider, stockInventoryId: widget.inventoryId);
      final barcodes = await getAllBarcodes(serverProvider);
      print({'barcodes', barcodes});
      return result;
    }

    getStockInventoryLineState();
    // return Container();

    productList ??= getStockInventoryLineState();
    var futureBuilder = FutureBuilder(
        future: productList,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final records = snapshot.data[0]['line_ids'];
            final length = snapshot.data[0]['line_ids'].length;
            print(snapshot.data[0]['line_ids']);
            print(json.encode(snapshot.data));
            print(length);
            return ListView.builder(
              itemCount: length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(records[index]['product_id']['display_name']),
                  subtitle: Text(
                      'Cantidad ${records[index]['product_qty'].toString()}'),
                  trailing: Icon(Icons.edit),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateProductScreen(
                                  stockInventoryId: widget.stockInventoryId,
                                  stockInventoryLine: records[index],
                                  // title: records[index]['product'][0]
                                  //     ['display_name'],
                                )));
                  },
                );
              },
            );
          } else {
            return Container(child: Text('Cargando'));
          }
        });
    return Container(
        child: Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 30,
          color: Colors.grey,
          child: TextField(
            textAlign: TextAlign.center,
            controller: searchController,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 15, height: 1),
            focusNode: myFocusNode,
            autofocus: true,
            onChanged: (e) {
              print(e);
            },
            onSubmitted: (e) {},
          ),
        ),
        Flexible(
          child: futureBuilder,
        ),

        // Container(
        //   decoration: BoxDecoration(boxShadow: [
        //     BoxShadow(
        //         blurRadius: 5,
        //         spreadRadius: 5,
        //         offset: Offset.zero,
        //         color: Colors.grey)
        //   ]),
        //   width: MediaQuery.of(context).size.width,
        //   height: 60,
        //   child: Row(
        //     children: <Widget>[Icon(Icons.add), Text('Agregar Producto')],
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //   ),
        //   alignment: Alignment.center,
        // ),
        // ButtonTheme(
        //   height: 60,
        //   minWidth: MediaQuery.of(context).size.width,
        //   child: RaisedButton(
        //     color: Colors.white,
        //     onPressed: () {},
        //     elevation: 7,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: <Widget>[
        //         Icon(Icons.add),
        //         Text('Agregar Producto'),
        //       ],
        //     ),
        //   ),
        // ),
        RawMaterialButton(
            constraints: BoxConstraints.tight(
              Size(MediaQuery.of(context).size.width, 60),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddProductScreen()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.add),
                Text('AGREGAR PRODUCTO',
                    style: TextStyle(fontWeight: FontWeight.w800))
              ],
            ),
            elevation: 8,
            fillColor: Colors.white),
        RawMaterialButton(
          fillColor: Colors.green,
          constraints: BoxConstraints.tight(
            Size(MediaQuery.of(context).size.width, 60),
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check,
                color: Colors.white,
              ),
              Text('VALIDAR',
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.white))
            ],
          ),
          // shape: new CircleBorder(),
          elevation: 5,
        ),
      ],
    ));

    // return Container();
  }
}
