import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockscanner/pages/add_product.dart';
import 'package:stockscanner/pages/login.dart';
import 'package:stockscanner/pages/stock_inventory_line_screen.dart';
import 'package:stockscanner/pages/stock_inventory_screen.dart';
import 'package:stockscanner/provider/server_provider.dart';
import 'package:flutter_flipperkit/flutter_flipperkit.dart';



void main() {
    FlipperClient flipperClient = FlipperClient.getDefault();

  flipperClient.addPlugin(new FlipperNetworkPlugin(
    // If you use http library, you must set it to false and use https://pub.dev/packages/flipperkit_http_interceptor
    // useHttpOverrides: false,
    // Optional, for filtering request
    filter: (HttpClientRequest request) {
      String url = '${request.uri}';
      if (url.startsWith('https://via.placeholder.com') || url.startsWith('https://gravatar.com')) {
        return false;
      }
      return true;
    }
  ));
  flipperClient.addPlugin(new FlipperReduxInspectorPlugin());
  flipperClient.addPlugin(new FlipperSharedPreferencesPlugin());
  flipperClient.start();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
        value: ServerProvider(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          '/stockInventoryLine': (context) => StockInventoryLineScreen(),
          // '/': (context) => StockInventoryScreen(),
          '/': (context) => LoginScreen(),
          '/stockInventory': (context) => StockInventoryScreen(),
          '/addProduct': (context) => AddProductScreen(),
        },
        theme: ThemeData(primarySwatch: Colors.indigo));
  }
}
