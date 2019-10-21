import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:odoo_api/odoo_api.dart';
import 'package:odoo_api/odoo_user_response.dart';
import 'package:odoo_api/odoo_version.dart';
import 'package:provider/provider.dart';
import 'package:stockscanner/pages/stock_inventory_screen.dart';
import 'package:stockscanner/provider/login_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // OdooClient client;
  final odooUrl = TextEditingController(text: 'https://odoo.nkodexsoft.com');
  final odooUser = TextEditingController(text: 'administrador');
  final odooPassword = TextEditingController(text: '123456');
  final odooDB = TextEditingController();
  final LocalStorage storage = new LocalStorage('inventory-scanner');
  String dbSelected;
  List odooDBList;
  @override
  void initState() {
    this.dbSelected = null;
    this.odooDBList = [''];

    super.initState();
  }

  odooAuth() {
    // client = new OdooClient(odooUrl.text);
    // client.connect().then((OdooVersion version) {
    //   print(version);
    // });
    // client.getDatabases().then((List databases) {
    //   setState(() {
    //     print(databases);
    //     this.odooDBList = databases;
    //     print({'LISTA DB: ', this.odooDBList});
    //   });
    // });
  }

  // void loginOdoo() {
  //   // var client = new OdooClient(odooUrl.text);
  //   var client = new OdooClient(odooUrl.text);
  //   client.connect().then((OdooVersion version) {
  //     print(version);
  //   });
  //   // client.getDatabases().then((List databases) {
  //   //   setState(() {
  //   //     this.odooDBList = databases;
  //   //   });
  //   // });
  //   print(odooUrl.text);
  //   print(odooUser.text);
  //   print(odooPassword.text);
  //   print(dbSelected);
  //   client
  //       .authenticate(odooUser.text, odooPassword.text, dbSelected)
  //       .then((AuthenticateCallback auth) {
  //     if (auth.isSuccess) {
  //       // print(auth.getUser());
  //       storage.setItem('odooUser', odooUser.text);
  //       storage.setItem('odooPassword', odooPassword.text);
  //       // storage.setItem('', value)
  //       print(auth.getUser().uid);
  //     } else {
  //       print('nel');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
        content: Text('Verifique sus credenciales'),
        action: SnackBarAction(
          label: 'REINTENTAR',
          onPressed: () {},
        ));
    final loginProvider = Provider.of<LoginProvider>(context);

    void getDatabaseList() async {
      try {
        var dbs = await loginProvider.getDatabases(odooUrl.text);
        setState(() {
          this.odooDBList = dbs;
        });
      } catch (e) {
        // print(e);
      }
    }

    Future<bool> serverAuth() async {
      loginProvider.selectedDb = this.dbSelected;
      loginProvider.password = this.odooPassword.text;
      loginProvider.user = this.odooUser.text;

      var data = await loginProvider.serverAuth();
      loginProvider.auth = data;
      return loginProvider.auth.isSuccess;
    }
    // final GlobalKey<ScaffoldState> _scaffoldKey =
    //     new GlobalKey<ScaffoldState>();

    return Scaffold(body: Builder(
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Container(
                child: Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                ),
              ),
              TextFormField(
                controller: odooUrl,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: 'URL',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        getDatabaseList();
                      },
                    )),
                onSaved: (e) {
                  // print(e);
                },
              ),
              DropdownButton<dynamic>(
                isExpanded: true,
                value: this.dbSelected,
                icon: Icon(Icons.keyboard_arrow_down),
                iconSize: 24,
                elevation: 16,
                onChanged: (dynamic newValue) {
                  setState(() {
                    this.dbSelected = newValue;
                  });
                },
                items: this
                    .odooDBList
                    .map<DropdownMenuItem<dynamic>>((dynamic value) {
                  return DropdownMenuItem<dynamic>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextFormField(
                controller: odooUser,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: 'Usuario'),
              ),
              TextFormField(
                controller: odooPassword,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(hintText: 'Contraseña'),
              ),
              Expanded(
                child: Container(),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Colors.indigo,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text('Login'),
                      onPressed: () async {
                        if (await serverAuth()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      StockInventoryScreen()));
                        } else {
                          Scaffold.of(context).showSnackBar(snackBar);
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    ));
  }
}
