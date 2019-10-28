import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:odoo_api/odoo_api_connector.dart';
import 'package:odoo_api/odoo_user_response.dart';
import 'package:odoo_api/odoo_version.dart';
import 'package:provider/provider.dart';
import 'package:stockscanner/api/server_api.dart';
import 'package:stockscanner/pages/home_page.dart';
import 'package:stockscanner/pages/stock_inventory_line_screen.dart';
import 'package:stockscanner/provider/models/stock_inventory_model.dart';
import 'package:stockscanner/provider/server_provider.dart';
import 'package:stockscanner/provider/stock_inventory.dart';
import 'package:odoo_api/odoo_api.dart';

class StockInventoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ordenes'),
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

class StockInventoryListView extends StatefulWidget {
  // OdooClient client;
  StockInventoryListView();

  @override
  _StockInventoryListViewState createState() => _StockInventoryListViewState();
}

class _StockInventoryListViewState extends State<StockInventoryListView> {
  @override
  Widget build(BuildContext context) {
    final serverProvider = Provider.of<ServerProvider>(context);
    Future<OdooResponse> serverStart() async {
      final serverApi = new ServerApi(serverProvider.serverUrl);
      // print(serverProvider.userDB);
      // print(serverProvider.passwordDB);
      // print(serverProvider.selectedDB);
      final authRes = await serverApi.auth(serverProvider.userDB,
          serverProvider.passwordDB, serverProvider.selectedDB);
      String model = 'stock.inventory';
      List<dynamic> domain = [
        ['state', '=', 'confirm']
      ];
      final filter = null;
      // print({'authRes', authRes.isSuccess});
      if (authRes.isSuccess) {
        return await serverApi.searchRead(model, domain, filter);
      }
    }

    return FutureBuilder(
      future: serverStart(),
      builder: (context, AsyncSnapshot<OdooResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // print(snapshot.data.getResult()['records']);
          final records = snapshot.data.getResult()['records'];
          final length = snapshot.data.getResult()['length'];
          // print(length);
          return ListView.builder(
            itemCount: length,
            itemBuilder: (context, index) {
              // print(records);
              return ListTile(
                title: Text(records[index]['display_name']),
                subtitle: Text(records[index]['create_date']),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StockInventoryLineScreen(
                                inventoryId: records[index]['id'],
                              )));
                },
              );
            },
          );
        } else {
          return Container(child: Text('Cargando'));
        }
      },
    );

    return Consumer<ServerProvider>(
      builder: (context, server, child) {
        final domain = [
          ['state', '=', 'confirm']
        ];
        final fields = null;
        // server.searchRead('stock.inventory', domain, fields).then((onValue) {
        //   server.response = onValue.getResult()['records'];
        //   print(server.response);
        //   server.notifyListeners();
        // });
        // return server.response.length == null || server.response.length == 0
        //     ? Container(
        //         child: Text('Cargando'),
        //       )
        //     : ListView.builder(
        //         itemCount: server.response.length,
        //         itemBuilder: (context, index) {
        //           return ListTile(
        //             trailing: Icon(Icons.chevron_right),
        //             title: Text(server.response[index]['name']),
        //             subtitle: Text(new DateFormat.MMMMEEEEd().format(
        //                 DateTime.parse(server.response[index]['date']))),
        //             onTap: () {
        //               Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                       builder: (context) => StockInventoryLineScreen(
        //                             inventoryId: server.response[index]['id'],
        //                           )));
        //             },
        //           );
        //         },
        //       );
      },
    );
  }
}
