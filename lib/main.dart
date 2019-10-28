import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockscanner/pages/home_page.dart';
import 'package:stockscanner/pages/login.dart';
import 'package:stockscanner/pages/stock_inventory_line_screen.dart';
import 'package:stockscanner/pages/stock_inventory_screen.dart';
import 'package:stockscanner/provider/server_provider.dart';


void main() {
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
          '/stockInventory': (context) => StockInventoryScreen()
        },
        theme: ThemeData(primarySwatch: Colors.indigo));
  }
}
