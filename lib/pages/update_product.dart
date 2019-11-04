import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:odoo_api/odoo_api.dart';
import 'package:odoo_api/odoo_api_connector.dart';
import 'package:provider/provider.dart';
import 'package:stockscanner/provider/server_provider.dart';

class UpdateProductScreen extends StatelessWidget {
  String title = '';
  int productId;

  UpdateProductScreen({this.productId, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: UpdateProduct(),
    );
  }
}

class UpdateProduct extends StatefulWidget {
  int productId;

  UpdateProduct({this.productId});

  @override
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  ServerProvider serverProvider;
  OdooClient client;
  TextEditingController productTextController;

  Future<OdooResponse> productList;
  @override
  void initState() {
    productTextController = new TextEditingController(text: '');
    super.initState();
  }

  Future<OdooResponse> getOdooProductsProducts(pattern) async {
    OdooResponse response;
    client = new OdooClient('https://odoo.nkodexsoft.com');

    final auth = await client.authenticate(serverProvider.userDB,
        serverProvider.passwordDB, serverProvider.selectedDB);
    print(auth.isSuccess);
    if (auth.isSuccess) {
      // print(auth.getUser());
      final domain = [
        ['display_name', 'ilike', pattern]
      ];
      // print(domain);
      final fields = null;
      final res = await client.searchRead(
        "product.product",
        domain,
        fields,
      );
      if (!res.hasError()) {
        String data;

        return res;
      } else {
        return res;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    serverProvider = Provider.of<ServerProvider>(context);
    // productList ??= getOdooProductsProducts(pattern);
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                        autofocus: true,
                        controller: productTextController,
                        decoration: InputDecoration(
                            hasFloatingPlaceholder: true,
                            labelText: 'Producto')),
                    suggestionsCallback: (pattern) async {
                      final data = await getOdooProductsProducts(pattern);

                      return data.getResult()['records'];
                    },
                    itemBuilder: (context, product) {
                      print(product);
                      return ListTile(
                        leading: Icon(Icons.shopping_cart),
                        title: Text(product['display_name']),
                        // subtitle: Text('\$${product['lst_price']}'),
                      );
                    },
                    onSuggestionSelected: (product) {
                      productTextController.text = product['display_name'];
                    },
                  ),
                  // TextField(
                  //   decoration: InputDecoration(
                  //       hasFloatingPlaceholder: true, labelText: 'Producto'),
                  // ),
                  TextField(
                    decoration: InputDecoration(
                        hasFloatingPlaceholder: true,
                        labelText: 'Cantidad Teorica'),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hasFloatingPlaceholder: true,
                        labelText: 'Cantidad Real'),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              RawMaterialButton(
                fillColor: Colors.white,
                constraints: BoxConstraints.tight(
                  Size(MediaQuery.of(context).size.width / 2, 60),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('DESCARTAR',
                        style: TextStyle(fontWeight: FontWeight.w800))
                  ],
                ),
                // shape: new CircleBorder(),
                elevation: 5,
              ),
              RawMaterialButton(
                fillColor: Colors.orange,
                constraints: BoxConstraints.tight(
                  Size(MediaQuery.of(context).size.width / 2, 60),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('CONFIRMAR',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, color: Colors.white))
                  ],
                ),
                // shape: new CircleBorder(),
                elevation: 5,
              ),
            ],
          )
        ],
      ),
    );
  }
}
