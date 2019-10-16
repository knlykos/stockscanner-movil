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

class StockInventoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajuste de Inventario'),
      ),
      body: ScannerInputKeys(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print('asdasd');
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
    print(event.logicalKey);
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

class StockInventoryListView extends StatefulWidget {
  @override
  _StockInventoryListViewState createState() => _StockInventoryListViewState();
}

class _StockInventoryListViewState extends State<StockInventoryListView> {
  OdooClient client;
  List<dynamic> data;
  @override
  void initState() {
    this.data = [];
    client = new OdooClient('http://10.10.201.124:8069');
    client.connect().then((OdooVersion version) {
      // print(version);
    });
    client
        .authenticate('administrador', '123456', 'demo')
        .then((AuthenticateCallback auth) {
      if (auth.isSuccess) {
        // print(auth.getUser());
        final domain = [
          ['state', '=', 'confirm']
        ];
        final fields = null;
        client
            .searchRead(
          "stock.inventory",
          domain,
          fields,
        )
            .then((OdooResponse result) {
          if (!result.hasError()) {
            final dataOdoo = result.getResult();
            // print(dataOdoo['length']);
            setState(() {
              this.data = dataOdoo['records'];
            });
            print(this.data[0]['id']);

            // Map mapData = jsonDecode(this.data);
            // print(mapData);
          } else {
            print(result.getError());
          }
        });
      } else {
        print('nel');
      }
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
    return ListView.builder(
      itemCount: this.data.length,
      itemBuilder: (context, index) {
        return ListTile(
          trailing: Icon(Icons.chevron_right),
          title: Text(this.data[index]['name']),
          subtitle: Text(new DateFormat.MMMMEEEEd()
              .format(DateTime.parse(data[index]['date']))),
          onTap: () {
            print(data[index]['id']);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StockInventoryLineScreen(
                          inventoryId: data[index]['id'],
                        )));
          },
        );
      },
    );
  }
}
