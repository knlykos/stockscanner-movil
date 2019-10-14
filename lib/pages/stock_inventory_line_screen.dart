import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:odoo_api/odoo_api.dart';
import 'package:odoo_api/odoo_api_connector.dart';
import 'package:odoo_api/odoo_user_response.dart';
import 'package:odoo_api/odoo_version.dart';

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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print('hola');
        },
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

  Image imageFromBase64String(String base64String) {
    if (base64String != null) {
      return Image.memory(base64Decode(base64String));
    }
  }

  @override
  void initState() {
    this.data = [];
    products = [];

    this.getOdooStockInventoryLine();
    // TODO: implement initState
    super.initState();
  }

  getOdooStockInventoryLine() async {
    client = new OdooClient('http://192.168.56.1:8069');
    await client.connect().then((OdooVersion version) {
      // print(version);
    });
    await client
        .authenticate('administrador', '123456', 'demo')
        .then((AuthenticateCallback auth) async {
      if (auth.isSuccess) {
        // print(auth.getUser());
        final domain = [
          ['inventory_id', '=', widget.inventoryId]
        ];
        print(domain);
        final fields = null;
        await client
            .searchRead(
          "stock.inventory.line",
          domain,
          fields,
        )
            .then((OdooResponse result) {
          if (!result.hasError()) {
            final dataOdoo = result.getResult();
            // print(dataOdoo['length']);
            this.data = dataOdoo['records'];
            // print(this.data);
            // this.data.map((f) => {print(f)});
            this.data.asMap().forEach((i, v) async {
              products.add(v);
              // this.data[i]['product'] = v;

              final domain = [
                ['id', '=', v['product_id'][0]]
              ];
              const fields = null;
              await client
                  .searchRead('product.product', domain, fields)
                  .then((OdooResponse result) {
                if (!result.hasError()) {
                  final productOdoo = result.getResult();
                  // print(productOdoo['records']);
                  setState(() {
                    this.products.add(productOdoo['records']);
                    this.data[i]['product'] = productOdoo['records'];
                  });
                  // print(this.data[i]['product']);
                  // print(productOdoo);
                  // print({'product', this.data[i]["product"]});
                } else {
                  print(result.getError());
                }
                // print(result);
              });
            });

            // client.searchRead('product.product', [['id', '=', this.data[]]], fields)
          } else {
            print(result.getError());
          }
        });
      } else {
        print('nel');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
    if (data.isEmpty && products.isEmpty) {
      return Text('Cargando...');
    } else {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              // child: imageFromBase64String(
              //     data[index]['product'][0]['image_small']),
              radius: 30.0,
              backgroundColor: Colors.transparent,
            ),
            title: Text(data[index]['product'][0]['name']),
            // subtitle: Text('\$' + data[index].products[0].listPrice.toString()),
            isThreeLine: false,
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          );
        },
      );
    }
  }
}
