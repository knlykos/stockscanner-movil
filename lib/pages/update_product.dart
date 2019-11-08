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
  TextEditingController teoricalTextController;
  TextEditingController realTextController;

  Future<OdooResponse> productList;
  @override
  void initState() {
    productTextController = new TextEditingController(text: '');
    teoricalTextController = new TextEditingController(text: '');
    realTextController = new TextEditingController(text: '');
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
        ['default_code', 'ilike', pattern]
      ];
      // print(domain);
      final fields = null;
      final res = await client.searchRead(
        "product.product",
        domain,
        fields,
      );

      final domainName = [
        ['name', 'ilike', pattern]
      ];
      // print(domain);
      final fieldsName = null;
      final resName = await client.searchRead(
        "product.product",
        domainName,
        fieldsName,
      );

      final domainBarcode = [
        ['barcode', 'ilike', pattern]
      ];
      // print(domain);
      final fieldsBarcode = null;
      final resBarcode = await client.searchRead(
        "product.product",
        domainBarcode,
        fieldsBarcode,
      );

      if (!res.hasError()) {
        res.getResult()['records'].addAll(resName.getResult()['records']);
        res.getResult()['records'].addAll(resBarcode.getResult()['records']);

        return res;
      } else {
        return res;
      }
    }
  }

  Future<OdooResponse> getStockInventoryLine(pattern) async {
    OdooResponse response;
    client = new OdooClient('https://odoo.nkodexsoft.com');

    final auth = await client.authenticate(serverProvider.userDB,
        serverProvider.passwordDB, serverProvider.selectedDB);
    print(auth.isSuccess);
    if (auth.isSuccess) {
      // print(auth.getUser());
      final domain = [
        ['product_id', '=', pattern]
      ];
      // print(domain);
      final fields = null;
      final res = await client.searchRead(
        "stock.inventory.line",
        domain,
        fields,
      );

      if (!res.hasError()) {
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
                        subtitle: Text('\$${product['lst_price']}'),
                      );
                    },
                    onSuggestionSelected: (product) async {
                      // final data = await getStockInventoryLine(product['id']);
                      // print({'getStockInventoryLine',data.getResult()['records']});
                      // TODO: Si es vacio debe de generar un dialogo mostrando el error, "Ha sucedido un error, vuelve a intentarlo"

                      print(product['display_name']);
                      // productTextController.text =
                      //     product['records']['display_name'];
                      
                      realTextController.text = product['qty_available'].toString();
                      teoricalTextController.text = product['virtual_available'].toString();

                      // productTextController.text[]
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
                    controller: teoricalTextController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hasFloatingPlaceholder: true,
                        labelText: 'Cantidad Real'),
                    controller: realTextController,
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
