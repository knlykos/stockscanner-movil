import 'package:flutter/foundation.dart';
import 'package:odoo_api/odoo_api.dart';
import 'package:odoo_api/odoo_api_connector.dart';
import 'package:odoo_api/odoo_user_response.dart';
import 'package:stockscanner/api/server_api.dart';

class ServerProvider with ChangeNotifier {
  String _serverUrl;

  String get serverUrl => _serverUrl;

  set serverUrl(String serverUrl) {
    _serverUrl = serverUrl;
    notifyListeners();
  }

  String _userDB;

  String get userDB => _userDB;

  set userDB(String userDB) {
    _userDB = userDB;
    notifyListeners();
  }

  String _passwordDB;

  String get passwordDB => _passwordDB;

  set passwordDB(String passwordDB) {
    _passwordDB = passwordDB;
    notifyListeners();
  }

  String _selectedDB;

  String get selectedDB => _selectedDB;

  set selectedDB(String selectedDB) {
    _selectedDB = selectedDB;
    notifyListeners();
  }

  bool _isAuth;

  bool get isAuth => _isAuth;

  set isAuth(bool isAuth) {
    _isAuth = isAuth;
    notifyListeners();
  }

  setAuthParams(userDB, passwordDB, selectedDB) {
    this._userDB = userDB;
    this._passwordDB = passwordDB;
    this._selectedDB = selectedDB;
  }

  // Future<List<dynamic>> getDatabases(serverURL) {
  //   var serverApi = new ServerApi();
  //   return serverApi.getDatabases(serverURL);
  // }

  // Future<AuthenticateCallback> serverAuth(userDb, passwordDb, selectedDb) {
  //   var serverApi = new ServerApi();
  // }
}
