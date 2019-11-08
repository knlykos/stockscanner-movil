import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:odoo_api/odoo_api.dart';
import 'package:odoo_api/odoo_api_connector.dart';
import 'package:odoo_api/odoo_user_response.dart';
import 'package:odoo_api/odoo_version.dart';
import 'package:provider/provider.dart';
import 'package:stockscanner/pages/add_product.dart';
import 'package:stockscanner/pages/update_product.dart';
import 'package:stockscanner/provider/server_provider.dart';

class StockInventoryLineScreen extends StatelessWidget {
  int inventoryId;

  StockInventoryLineScreen({this.inventoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventario'),
      ),
      body: StockInventoryLineListView(
        inventoryId: inventoryId,
      ),
    );
  }
}

class StockInventoryLineListView extends StatefulWidget {
  final int inventoryId;

  StockInventoryLineListView({Key key, this.inventoryId}) : super(key: key);
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
  Future<OdooResponse> productList;
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

  Future<OdooResponse> getOdooStockInventoryLine() async {
    OdooResponse response;
    client = new OdooClient('https://odoo.nkodexsoft.com');

    final auth = await client.authenticate(serverProvider.userDB,
        serverProvider.passwordDB, serverProvider.selectedDB);
    print(auth.isSuccess);
    if (auth.isSuccess) {
      // print(auth.getUser());
      final domain = [
        ['inventory_id', '=', widget.inventoryId]
      ];
      // print(domain);
      final fields = null;
      final res = await client.searchRead(
        "stock.inventory.line",
        domain,
        fields,
      );
      if (!res.hasError()) {
        print(res.getResult());
        for (var entry in res.getResult()['records'].asMap().entries) {
          // print({'entry', entry.value['inventory_id'][0]});
          final domain = [
            ['id', '=', entry.value['product_id'][0]]
          ];
          print(domain);
          const fields = null;
          OdooResponse product =
              await client.searchRead('product.product', domain, fields);
          res.getResult()['records'][0]['product'] =
              product.getResult()['records'];
        }
        return res;
      } else {
        return res;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // getOdooStockInventoryLine();
    serverProvider = Provider.of<ServerProvider>(context);
    productList ??= getOdooStockInventoryLine();
    var futureBuilder = FutureBuilder(
        future: productList,
        builder: (context, AsyncSnapshot<OdooResponse> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final records = snapshot.data.getResult()['records'];
            final length = snapshot.data.getResult()['length'];
            return ListView.builder(
              itemCount: length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(records[index]['product'][0]['display_name']),
                  subtitle: Text(records[index]['product'][0]['create_date']),
                  trailing: Icon(Icons.edit),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateProductScreen(
                                  productId: records[index]['product'][0]['id'],
                                  title: records[index]['product'][0]
                                      ['display_name'],
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
