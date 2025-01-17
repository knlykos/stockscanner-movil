import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:localstorage/localstorage.dart';
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
      appBar: AppBar(title: Text('UpdateProduct')),
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
  double initRealQty;
  bool productEnable = false;
  bool theresChange = false;
  ServerProvider serverProvider;
  OdooClient client;
  TextEditingController productTextController = new TextEditingController();
  TextEditingController teoricalTextController = new TextEditingController();
  TextEditingController realTextController = new TextEditingController();
  Future<OdooResponse> stockInventoryLineRes;
  LocalStorage storage;
  String user;
  String password;
  String db;
  bool loading = false;
  dynamic product;
  dynamic stockInventoryLine;

  // focus
  FocusNode productFocus;
  FocusNode realQtyFocus;

  @override
  void initState() {
    super.initState();
    productFocus = new FocusNode();
    realQtyFocus = new FocusNode();

    storage = new LocalStorage('auth');
    user = storage.getItem('user');
    password = storage.getItem('password');
    db = storage.getItem('db');
    stockInventoryLineRes =
        getStockInventoryLineById(widget.stockInventoryLine["id"]);
    stockInventoryLineRes.then((res) {
      this.stockInventoryLine = res;
      setState(() {
        this.loading = true;
      });

      this.productTextController.text =
          this.stockInventoryLine.getResult()['records'][0]['product_id'][1];
      this.teoricalTextController.text = this
          .stockInventoryLine
          .getResult()['records'][0]['theoretical_qty']
          .toString();
      this.realTextController.text = this
          .stockInventoryLine
          .getResult()['records'][0]['product_qty']
          .toString();
      if (this.initRealQty == null) {
        this.initRealQty =
            this.stockInventoryLine.getResult()['records'][0]['product_qty'];
      }
// this.teoricalTextController.text = stockInventoryLine.getResult()['records'][0]['']
      // print(stockInventoryLine.getResult()['records'][0]['product_id'][1]);
      // this.productTextController.text =
      //     stockInventoryLine.getResult()['records']['product_id'][1];
    });
  }

  @override
  void dispose() {
    productTextController.dispose();
    teoricalTextController.dispose();
    realTextController.dispose();
    productFocus.dispose();
    realQtyFocus.dispose();
    super.dispose();
  }

  Future<OdooResponse> getOdooProductsProducts(pattern) async {
    OdooResponse response;
    client = new OdooClient('https://odoo.nkodexsoft.com');

    final auth = await client.authenticate(user, password, db);

    if (auth.isSuccess) {
      final domain = [
        ['default_code', 'ilike', pattern],
        ["active", "=", true],
        ["type", "=", "product"]
      ];

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
    client = new OdooClient('https://odoo.nkodexsoft.com');

    final auth = await client.authenticate(user, password, db);
    print(auth.isSuccess);
    if (auth.isSuccess) {
      final domain = [
        ['id', '=', id]
      ];

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

    final auth = await client.authenticate(user, password, db);

    if (auth.isSuccess) {
      final domain = [
        ['product_id', '=', pattern]
      ];

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

  void setTextFieldValues(stockInventoryLine) {
    productTextController.text = stockInventoryLine[0]['product_id'][1];

    teoricalTextController.text =
        stockInventoryLine[0]['theoretical_qty'].toString();
    realTextController.text = stockInventoryLine[0]['product_qty'].toString();
  }

  @override
  Widget build(BuildContext context) {
    void _showDialogConfirmSuccessful(String product, String code) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Actualización exitosa"),
            content: new Text(product),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Aceptar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void _showDialogConfirmUnsuccessful() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Registro no actualizado"),
            content: new Text("Actualice la cantidad a confirmar"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Aceptar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    confirmarBtn() async {
      OdooResponse res;
      if (this.theresChange == true) {
        client = new OdooClient('https://odoo.nkodexsoft.com');
        final auth =
            await client.authenticate(this.user, this.password, this.db);

        if (auth.isSuccess) {
          print({
            'stockInventoryLine',
            this.stockInventoryLine.getResult()['records']
          });
          if (this.product == null) {
            res = await client.write("stock.inventory.line", [
              this.stockInventoryLine.getResult()['records'][0]['id']
            ], {
              "product_id": this.stockInventoryLine.getResult()['records'][0]
                  ["product_id"][0],
              "location_id": this.stockInventoryLine.getResult()['records'][0]
                  ["location_id"][0],
              "product_uom_id": this.stockInventoryLine.getResult()['records']
                  [0]["product_uom_id"][0],
              "product_qty": double.parse(this.realTextController.text)
            });
            print({
              "product_id": this.stockInventoryLine.getResult()['records'][0]
                  ["inventory_id"][0],
              "location_id": this.stockInventoryLine.getResult()['records'][0]
                  ["location_id"][0],
              "product_uom_id": this.stockInventoryLine.getResult()['records']
                  [0]["product_uom_id"][0],
              "product_qty": double.parse(this.realTextController.text)
            });
          } else {
            print({
              "product_id": this.product["id"],
              "location_id": this.stockInventoryLine.getResult()['records'][0]
                  ["location_id"][0],
              "product_uom_id": this.product["uom_id"][0],
              "product_qty": double.parse(this.realTextController.text)
            });
            res = await client.write("stock.inventory.line", [
              this.stockInventoryLine.getResult()['records'][0]['id']
            ], {
              "product_id": this.product["id"],
              "location_id": this.stockInventoryLine.getResult()['records'][0]
                  ["product_uom_id"][0],
              "product_uom_id": this.product["uom_id"][0],
              "product_qty": double.parse(this.realTextController.text)
            });
          }
          print({'res.getResult()1', res.getError()});
          if (!res.hasError()) {
            if (res.getResult()) {
              // _showDialogConfirmSuccessful(
              //     this.product['display_name'], this.product['barcode']);
            } else {}
            Navigator.pop(context);
            return res;
          } else {
            return res;
          }
        }
      } else {
        _showDialogConfirmUnsuccessful();
      }
      print({'res.getResult()2', res.getResult()});
    }

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
                    debounceDuration: Duration(milliseconds: 1000),
                    hideOnEmpty: true,
                    getImmediateSuggestions: false,
                    textFieldConfiguration: TextFieldConfiguration(
                      focusNode: productFocus,
                      enabled: this.productEnable,
                      controller: productTextController,
                      decoration: InputDecoration(
                          hasFloatingPlaceholder: true, labelText: 'Producto'),
                    ),
                    suggestionsCallback: (pattern) async {
                      final data = await getOdooProductsProducts(pattern);
                      return data.getResult()['records'];
                    },
                    itemBuilder: (context, product) {
                      return ListTile(
                        leading: Icon(Icons.shopping_cart),
                        title: Text(product['display_name']),
                        subtitle: Text('\$${product['lst_price']}'),
                      );
                    },
                    onSuggestionSelected: (product) async {
                      this.product = product;
                      final data = await getStockInventoryLine(product['id']);

                      // TODO: Si es vacio debe de generar un dialogo mostrando el error, "Ha sucedido un error, vuelve a intentarlo"
                      setState(() {
                        this.productEnable = false;
                      });
                      productTextController.text = product['display_name'];

                      teoricalTextController.text = widget
                          .stockInventoryLine['theoretical_qty']
                          .toString();
                      realTextController.text = '';
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
                    focusNode: realQtyFocus,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hasFloatingPlaceholder: true,
                        labelText: 'Cantidad Real'),
                    controller: realTextController,
                    onChanged: (value) {
                      if (double.parse(this.realTextController.text) !=
                          this.initRealQty) {
                        setState(() {
                          this.theresChange = true;
                        });
                      }
                    },
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
                      this.theresChange = true;
                      setState(() {
                        this.productEnable = true;
                        FocusScope.of(context).requestFocus(productFocus);
                      });
                      this.productTextController.clear();
                      this.teoricalTextController.clear();
                      this.realTextController.clear();
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
                onPressed: () {
                  Navigator.pop(context);
                  // _showDialogConfirmSuccessful();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('DESCARTAR',
                        style: TextStyle(fontWeight: FontWeight.w800))
                  ],
                ),
                elevation: 5,
              ),
              RawMaterialButton(
                fillColor: this.theresChange ? Colors.orange : Colors.grey,
                constraints: BoxConstraints.tight(
                  Size(MediaQuery.of(context).size.width / 2, 60),
                ),
                onPressed: theresChange ? confirmarBtn : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('CONFIRMAR',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, color: Colors.white))
                  ],
                ),
                elevation: 5,
              ),
            ],
          )
        ],
      ),
    );
    // TODO: Cambio en FutureBuilder el texto necesita ser asignado en otro momento o lograr que no recargue cada vez que aparece el teclado
    // HAY QUE MOVER TODO A OTRO LADO;
    if (this.loading) {
      return container;
    } else {
      return Container(
        child: Text('Cargando.......'),
      );
    }
  }
}
