import 'package:flutter/foundation.dart';
import 'package:odoo_api/odoo_api.dart';
import 'package:odoo_api/odoo_api_connector.dart';
import 'package:odoo_api/odoo_user_response.dart';

class ServerApi {
  OdooClient _serverConn;

  OdooClient get serverConn => _serverConn;

  set serverConn(OdooClient serverConn) {
    _serverConn = serverConn;
  }

  String _userDb;

  String get userDb => _userDb;

  set userDb(String userDb) {
    _userDb = userDb;
  }

  String _passwordDB;

  String get passwordDB => _passwordDB;

  set passwordDB(String passwordDB) {
    _passwordDB = passwordDB;
  }

  String _selectedDB;

  String get selectedDB => _selectedDB;

  set selectedDB(String selectedDB) {
    _selectedDB = selectedDB;
  }

  String _serverURL;

  String get serverURL => _serverURL;

  set serverURL(String serverURL) {
    _serverURL = serverURL;
  }

  ServerApi(this._serverURL,
      [this._userDb, this._passwordDB, this._selectedDB]) {
    this._serverConn = new OdooClient(serverURL);
  }
  Future<List<dynamic>> getDatabases() async {
    return await serverConn.getDatabases();
  }

  Future<AuthenticateCallback> auth(username, password, database) async {
        this._serverConn = new OdooClient(serverURL);
    return await this._serverConn.authenticate(username, password, database);
  }

  searchRead(String model, List domain, dynamic filter) async {
    return await serverConn.searchRead(model, domain, filter);
  }
}
