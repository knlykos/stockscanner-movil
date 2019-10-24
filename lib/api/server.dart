import 'package:flutter/foundation.dart';
import 'package:odoo_api/odoo_api.dart';
import 'package:odoo_api/odoo_api_connector.dart';
import 'package:odoo_api/odoo_user_response.dart';

class ServerApi {
  OdooClient _odooClient;
  List<dynamic> _response = [];
  List<dynamic> _product = [];
  OdooClient get odooClient {
    return _odooClient;
  }

  List<dynamic> get product {
    return _product;
  }

  set product(List<dynamic> product) {
    _product = product;
    // notifyListeners();
  }

  set odooClient(OdooClient odooClient) {
    if (odooClient == null) {
      throw new ArgumentError();
    }
    _odooClient = odooClient;
  }

  List<dynamic> get response {
    return _response;
  }

  set response(List<dynamic> response) {
    _response = response;
    // notifyListeners();
  }

  // List<dynamic> _databases;
  String _userDb;
  String get user {
    return _userDb;
  }

  set user(String user) {
    if (user.isEmpty || user == '') {
      throw new ArgumentError();
    }
    _userDb = user;
  }

  String _passwordDb;

  String get password {
    return _passwordDb;
  }

  set password(String password) {
    if (password.isEmpty || password == '') {
      throw new ArgumentError();
    }
    _passwordDb = password;
  }

  String _selectedDb;
  String get selectedDb {
    return _selectedDb;
  }

  set selectedDb(String selected) {
    if (selected.isEmpty || selected == '') {
      throw new ArgumentError();
    }
    _selectedDb = selected;
  }

  int _userUid;

  int get uid {
    return _userUid;
  }

  AuthenticateCallback _auth;

  AuthenticateCallback get auth {
    return _auth;
  }

  set auth(AuthenticateCallback auth) {
    if (auth == null) {
      throw new ArgumentError();
    }
    _auth = auth;
  }

  set uid(int uid) {
    if (uid == null || uid == 0) {
      throw new ArgumentError();
    }
    _userUid = uid;
  }

  Future<List<dynamic>> getDatabases(String serverURL) async {
    odooClient = new OdooClient(serverURL);
    return await odooClient.getDatabases();
  }

  Future<AuthenticateCallback> serverAuth() async {
    return await odooClient.authenticate(_userDb, _passwordDb, _selectedDb);
  }

  Future<OdooResponse> searchRead(
      String model, dynamic domain, dynamic fields) async {
    // odooClient.connect().then((onValue) => {onValue.getVersionInfo()});

    return await odooClient.searchRead(model, domain, fields);
  }
}