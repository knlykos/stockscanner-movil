import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:odoo_api/odoo_api.dart';
import 'package:odoo_api/odoo_api_connector.dart';
import 'package:provider/provider.dart';
import 'package:stockscanner/provider/server_provider.dart';

class UpdateProductScreen extends StatelessWidget {
  int stockInventoryId;
  dynamic stockInventoryLine;

  UpdateProductScreen({
    this.stockInventoryId,
    this.stockInventoryLine,
  });

  @override
  Widget build(BuildContext context) {
    final serverProvider = Provider.of<ServerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text((serverProvider.stockInventoryLine == null
            ? ''
            : serverProvider.stockInventoryLine[0]['product_id'][1])),
      ),
      body: UpdateProduct(
          stockInventoryId: this.stockInventoryId,
          stockInventoryLine: this.stockInventoryLine),
    );
  }
}

class UpdateProduct extends StatefulWidget {
  int stockInventoryId;
  dynamic stockInventoryLine;

  UpdateProduct({
    this.stockInventoryId,
    this.stockInventoryLine,
  });

  @override
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  bool productEnable;
  ServerProvider serverProvider;
  OdooClient client;
  TextEditingController productTextController;
  TextEditingController teoricalTextController;
  TextEditingController realTextController;
  dynamic product;

  Future<OdooResponse> stockInventoryLineRes;
  @override
  void initState() {
    print({'stockInventoryLine', widget});
    productTextController = new TextEditingController(text: '');
    teoricalTextController = new TextEditingController(text: '');
    realTextController = new TextEditingController(text: '');
    productEnable = false;
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
        ['default_code', 'ilike', pattern],
        ["active", "=", true],
        ["type", "=", "product"]
      ];
      // print(domain);
      final fields = null;
      final res = await client.searchRead(
        "product.product",
        domain,
        fields,
      );

      final domainName = [
        ['name', 'ilike', pattern],
        ["active", "=", true],
        ["type", "=", "product"]
      ];
      // print(domain);
      final fieldsName = null;
      final resName = await client.searchRead(
        "product.product",
        domainName,
        fieldsName,
      );

      final domainBarcode = [
        ['barcode', 'ilike', pattern],
        ["active", "=", true],
        ["type", "=", "product"]
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

  Future<OdooResponse> getStockInventoryLineById(int id) async {
    OdooResponse response;
    client = new OdooClient('https://odoo.nkodexsoft.com');

    final auth = await client.authenticate(serverProvider.userDB,
        serverProvider.passwordDB, serverProvider.selectedDB);
    print(auth.isSuccess);
    if (auth.isSuccess) {
      // print(auth.getUser());
      final domain = [
        ['id', '=', id]
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
    stockInventoryLineRes ??=
        getStockInventoryLineById(widget.stockInventoryLine["id"]);
    var container = Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  TypeAheadField(
                    debounceDuration: Duration(milliseconds: 50),
                    textFieldConfiguration: TextFieldConfiguration(
                      enabled: this.productEnable,
                      autofocus: true,
                      controller: productTextController,
                      decoration: InputDecoration(
                          // suffix: IconButton(
                          //   icon: Icon(Icons.clear),
                          //   onPressed: () {
                          //     productTextController.clear();
                          //   },
                          // ),
                          hasFloatingPlaceholder: true,
                          labelText: 'Producto'),
                    ),
                    suggestionsCallback: (pattern) async {
                      final data = await getOdooProductsProducts(pattern);
                      return data.getResult()['records'];
                    },
                    itemBuilder: (context, product) {
                      this.product = product;
                      return ListTile(
                        leading: Icon(Icons.shopping_cart),
                        title: Text(product['display_name']),
                        subtitle: Text('\$${product['lst_price']}'),
                      );
                    },
                    onSuggestionSelected: (product) async {
                      this.serverProvider.productProduct = product;
                      final data = await getStockInventoryLine(product['id']);
                      // print({'getStockInventoryLine',data.getResult()['records']});
                      // TODO: Si es vacio debe de generar un dialogo mostrando el error, "Ha sucedido un error, vuelve a intentarlo"
                      // this.serverProvider.stockInventoryLine =
                      //     data.getResult()['records'];

                      // print(product['display_name']);
                      productTextController.text = product['name'];

                      teoricalTextController.text = widget
                          .stockInventoryLine['theoretical_qty']
                          .toString();
                      realTextController.text =
                          widget.stockInventoryLine['product_qty'].toString();

                      // productTextController.text[]
                    },
                  ),
                  TextField(
                    enabled: false,
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
                  RaisedButton(
                    color: Colors.red,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        Text(
                          'Borrar',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        this.productEnable = true;
                        this.productTextController.clear();
                        this.teoricalTextController.clear();
                        this.realTextController.clear();
                      });
                    },
                  )
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
                onPressed: () async {
                  OdooResponse response;
                  client = new OdooClient('https://odoo.nkodexsoft.com');

                  final auth = await client.authenticate(serverProvider.userDB,
                      serverProvider.passwordDB, serverProvider.selectedDB);
                  print(auth.isSuccess);
                  if (auth.isSuccess) {
                    // print(auth.getUser());
                    final res = await client.write("stock.inventory.line", [
                      this.serverProvider.stockInventoryLine[0]['id']
                    ], {
                      "product_id": this.serverProvider.productProduct["id"],
                      "location_id": 15,
                      "product_uom_id": this.product["uom_id"][0]
                    });
                    print({'hasError', res.getError()});
                    print({'getResult', res.getResult()});
                    if (!res.hasError()) {
                      print(res.getResult());
                      return res;
                    } else {
                      return res;
                    }
                  }
                },
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
    return FutureBuilder(
        future: stockInventoryLineRes,
        builder: (context, AsyncSnapshot<OdooResponse> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            this.serverProvider.stockInventoryLine =
                snapshot.data.getResult()['records'];
            this.serverProvider.stockInventoryLine;

            // print(product['display_name']);
            productTextController.text =
                this.serverProvider.stockInventoryLine[0]['product_id'][1];

            teoricalTextController.text = this
                .serverProvider
                .stockInventoryLine[0]['theoretical_qty']
                .toString();
            realTextController.text = this
                .serverProvider
                .stockInventoryLine[0]['product_qty']
                .toString();
            final records = snapshot.data.getResult()['records'];
            final length = snapshot.data.getResult()['length'];
            return container;
          } else {
            return Container(
              child: Text('Cargando...'),
            );
          }
        });
  }
}
