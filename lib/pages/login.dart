import 'package:flutter/material.dart';
import 'package:odoo_api/odoo_api.dart';
import 'package:odoo_api/odoo_user_response.dart';
import 'package:odoo_api/odoo_version.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final lusernameController = TextEditingController();
    final lpasswordController = TextEditingController();

    void loginOdoo() {
      var client = new OdooClient('http://192.168.56.1:8069');
      client.connect().then((OdooVersion version) {
        print(version);
      });
      client
          .authenticate(
              lusernameController.text, lpasswordController.text, 'demo')
          .then((AuthenticateCallback auth) {
        if (auth.isSuccess) {
          print(auth.getUser());
        } else {
          print('nel');
        }
      });
    }
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
              controller: lusernameController,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'Usuario'),
            ),
            TextFormField(
              controller: lpasswordController,
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
