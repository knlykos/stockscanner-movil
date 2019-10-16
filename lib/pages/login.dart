import 'package:flutter/material.dart';
import 'package:odoo_api/odoo_api.dart';
import 'package:odoo_api/odoo_user_response.dart';
import 'package:odoo_api/odoo_version.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  OdooClient client;
  final odooUrl = TextEditingController();
  final odooUser = TextEditingController();
  final odooPassword = TextEditingController();
  final odooDB = TextEditingController();
  String dbSelected;
  List odooDBList;
  @override
  void initState() {
    this.dbSelected = null;
    this.odooDBList = [''];

    super.initState();
  }

  odooAuth() {
    client = new OdooClient(odooUrl.text);
    client.connect().then((OdooVersion version) {
      print(version);
    });
    client.getDatabases().then((List databases) {
      setState(() {
        print(databases);
        this.odooDBList = databases;
        print({'LISTA DB: ', this.odooDBList});
      });
    });
  }

  void loginOdoo() {
    var client = new OdooClient(odooUrl.text);
    client.connect().then((OdooVersion version) {
      print(version);
    });
    // client.getDatabases().then((List databases) {
    //   setState(() {
    //     this.odooDBList = databases;
    //   });
    // });
    print(odooUrl.text);
    print(odooUser.text);
    print(odooPassword.text);
    print(dbSelected);
    client
        .authenticate(odooUser.text, odooPassword.text, dbSelected)
        .then((AuthenticateCallback auth) {
      if (auth.isSuccess) {
        print(auth.getUser());
      } else {
        print('nel');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final GlobalKey<ScaffoldState> _scaffoldKey =
    //     new GlobalKey<ScaffoldState>();

    return Scaffold(
      body: Container(
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
                      odooAuth();
                    },
                  )),
              onSaved: (e) {
                print(e);
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
                    onPressed: loginOdoo,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
