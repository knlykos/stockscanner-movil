import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockscanner/provider/login_provider.dart';

class StockInventoryLineScreen extends StatelessWidget {
  int inventoryId;

  StockInventoryLineScreen({this.inventoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calimax'),
      ),
      body: StockInventoryLineListView(
        inventoryId: inventoryId,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // print('hola');
        },
      ),
    );
  }
}

// class StockInventoryLineListView extends StatefulWidget {
//   final int inventoryId;

//   StockInventoryLineListView({Key key, this.inventoryId}) : super(key: key);
// }

class StockInventoryLineListView extends StatelessWidget {
  final int inventoryId;
  StockInventoryLineListView({Key key, this.inventoryId}) : super(key: key);
  // Image imageFromBase64String(String base64String) {
  //   if (base64String != null) {
  //     return Image.memory(base64Decode(base64String));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // return Container();

    return Consumer<LoginProvider>(builder: (context, server, child) {
      // final domain = [
      //   ['inventory_id', '=', inventoryId]
      // ];
      // print(domain);
      // final fields = null;

      // server.searchRead('stock.inventory.line', domain, fields);

      // print(server.response);
      // server.response.asMap().forEach((i, v) async {
      //   server.product.add();
      // });

      // server.response.

      return Container(
        child: Text('hola'),
      );
      // return ListView.builder(
      //   itemCount: server.response.length,
      //   itemBuilder: (context, index) {
      //     return ListTile(
      //       leading: CircleAvatar(
      //         // child: imageFromBase64String(
      //         //     data[index]['product'][0]['image_small']),
      //         radius: 30.0,
      //         backgroundColor: Colors.transparent,
      //       ),
      //       // title: Text(server.response[index]['product'][0]['name']),
      //       // subtitle: Text('\$' + data[index].products[0].listPrice.toString()),
      //       isThreeLine: false,
      //       trailing: Icon(Icons.chevron_right),
      //       onTap: () {
      //         // Navigator.push(
      //         //     context, MaterialPageRoute(builder: (context) => HomePage()));
      //       },
      //     );
      //   },
      // );
    });
  }
}
