import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:odoo_api/odoo_api.dart';
import 'package:odoo_api/odoo_api_connector.dart';
import 'package:odoo_api/odoo_user_response.dart';
import 'package:odoo_api/odoo_version.dart';
import 'package:provider/provider.dart';
import 'package:stockscanner/provider/server_provider.dart';

class StockInventoryLineScreen extends StatelessWidget {
  int inventoryId;

  StockInventoryLineScreen({this.inventoryId});

  @override
  Widget build(BuildContext context) {
    // Provider.of<StockInventoryLineProvider>(context, listen: false)
    //     .getStockInventoryLine(this.inventoryId);
    // var data = Provider.of<StockInventoryLineProvider>(context, listen: false)
    //     .stockInventoryLine;
    // print(data);

    // Image imageFromBase64String(String base64String) {
    //   return Image.memory(base64Decode(base64String));
    // }

    // Widget ListProducts = ListView.builder(
    //   itemCount: data.length,
    //   itemBuilder: (context, index) {
    //     return ListTile(
    //       leading: CircleAvatar(
    //         child: imageFromBase64String(data[index].products[0].image),
    //         radius: 30.0,
    //         backgroundColor: Colors.transparent,
    //       ),
    //       title: Text(data[index].products[0].name),
    //       subtitle: Text('\$' + data[index].products[0].listPrice.toString()),
    //       isThreeLine: false,
    //       trailing: Icon(Icons.chevron_right),
    //       onTap: () {
    //         Navigator.push(
    //             context, MaterialPageRoute(builder: (context) => HomePage()));
    //       },
    //     );
    //   },
    // );

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle ajuste de inventario'),
      ),
      body: StockInventoryLineListView(
        inventoryId: inventoryId,
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     print('hola');
      //   },
      // ),
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

  Image imageFromBase64String(String base64String) {
    if (base64String != null) {
      return Image.memory(base64Decode(base64String));
    }
  }

  @override
  void initState() {
    this.data = [];
    products = [];
    length = 0;
    // TODO: implement initState
    searchController = new TextEditingController();

    super.initState();
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
        // if (!res.hasError()) {
        // final dataOdoo = response.getResult();
        // // print(dataOdoo['length']);
        // this.data = dataOdoo['records'];
        // print(this.data);
        // this.data.map((f) => {print(f)});
        // print({'ENTRIES', response.getResult()['records'].asMap().entries});
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
          // print(product.getResult());
          res.getResult()['records'][0]['product'] =
              product.getResult()['records'];
          //   response.getResult()['records'][i]['product'] =
          //       product.getResult()['records'];
          //   print(response.getResult()['records'][i]['product']);
          // });

          // client.searchRead('product.product', [['id', '=', this.data[]]], fields)
        }
        // response.getResult()['records'].asMap().forEach((i, v) async {
        //   // products.add(v);
        //   // response.getResult()['records'][i]['product'] = v;
        //   // this.data[i]['product'] = v;

        // } else {
        //   // print(result.getError());
        // }
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
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StockInventoryLineScreen(
                                  inventoryId: records[index]['product'][0]
                                      ['id'],
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
            decoration: InputDecoration(border: InputBorder.none),
            textAlign: TextAlign.center,
            controller: searchController,
            keyboardType: TextInputType.number,
          ),
        ),
        Flexible(
          child: futureBuilder,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 30,
          color: Colors.red,
        ),
      ],
    ));

    // return Container();
  }
}
