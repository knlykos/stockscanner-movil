import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:odoo_api/odoo_api_connector.dart';
import 'package:odoo_api/odoo_user_response.dart';
import 'package:odoo_api/odoo_version.dart';
import 'package:provider/provider.dart';
import 'package:stockscanner/pages/home_page.dart';
import 'package:stockscanner/pages/stock_inventory_line_screen.dart';
import 'package:stockscanner/provider/models/stock_inventory_model.dart';
import 'package:stockscanner/provider/stock_inventory.dart';
import 'package:odoo_api/odoo_api.dart';
import 'package:stockscanner/provider/login_provider.dart';

class StockInventoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajuste de Inventario'),
      ),
      body: StockInventoryListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // print('asdasd');
        },
      ),
    );
  }
}

class ScannerInputKeys extends StatefulWidget {
  @override
  _ScannerInputKeysState createState() => _ScannerInputKeysState();
}

class _ScannerInputKeysState extends State<ScannerInputKeys> {
  FocusNode _focusNode;
  bool _focused = false;
  FocusAttachment _nodeAttachment;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    _nodeAttachment = _focusNode.attach(context, onKey: _handleKeyPress);
    // TODO: implement initState
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus != _focused) {
      setState(() {
        _focused = _focusNode.hasFocus;
      });
    }
  }

  bool _handleKeyPress(FocusNode node, RawKeyEvent event) {
    // print(event.logicalKey);
    return true;
  }

  @override
  void dispose() {
    _focusNode.removeListener(this._handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _nodeAttachment.reparent();
    _focusNode.requestFocus();
    return StockInventoryListView();
  }
}

class StockInventoryListView extends StatelessWidget {
  // OdooClient client;
  List<dynamic> data;

  @override
  Widget build(BuildContext context) {
    // final loginProvider = Provider.of<LoginProvider>(context);
    void getStockInventory() {
      // final domain = [
      //   ['state', '=', 'confirm']
      // ];
      // final fields = null;
      // Provider.of<LoginProvider>(context)
      //     .searchRead('stock.inventory', domain, fields);
      // print(Provider.of<LoginProvider>(context).response);
      // loginProvider.odooClient
      //     .searchRead('stock.inventory', domain, fields)
      //     .then((OdooResponse result) {
      //   if (!result.hasError()) {
      //     final dataOdoo = result.getResult();
      //     // print(dataOdoo['length']);

      //     print(this.data[0]['id']);

      //     // Map mapData = jsonDecode(this.data);
      //     // print(mapData);
      //   } else {
      //     print(result.getError());
      //   }
      // });
    }

    // return Container();
    return Consumer<LoginProvider>(
      builder: (context, server, child) {
        final domain = [
          ['state', '=', 'confirm']
        ];
        final fields = null;
        server.searchRead('stock.inventory', domain, fields);
        // response.notifyListeners();
        // final dynamic odooResponse = response.response.getResult();
        // print(response.response.getResult());
        // this.data = odooResponse['records'];
        return Container();
        //   return ListView.builder(
        //     itemCount: data.length,
        //     itemBuilder: (context, index) {
        //       return ListTile(
        //         trailing: Icon(Icons.chevron_right),
        //         title: Text(this.data[index]['name']),
        //         subtitle: Text(new DateFormat.MMMMEEEEd()
        //             .format(DateTime.parse(data[index]['date']))),
        //         onTap: () {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => StockInventoryLineScreen(
        //                         inventoryId: data[index]['id'],
        //                       )));
        //         },
        //       );
        //     },
        //   );
      },
    );
  }
}
