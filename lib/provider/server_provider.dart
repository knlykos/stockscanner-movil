import 'package:flutter/foundation.dart';
import 'package:odoo_api/odoo_api.dart';
import 'package:odoo_api/odoo_user_response.dart';

class ServerProvider with ChangeNotifier {
  String _host;
  String _user;
  String _password;
  String _database;
  String _sessionId;
  bool _isAuth;
  bool _debug;
  OdooClient _client;

  getInstance({String user, String password, String database, String host}) {
    print({user, password, database, host});
    this._user = user;
    this._password = password;
    this._database = database;
    this._host = host;
    this._client = new OdooClient(this._host);
  }

  get client {
    return _client;
  }

  Future<List<dynamic>> getDatabases() async {
    this._client = new OdooClient(this._host);
    final response = await this._client.getDatabases();
    return response;
  }

  Future<bool> authentication() async {
    final auth = await this
        ._client
        .authenticate(this._user, this._password, this._database);
    this._isAuth = auth.isSuccess;
    if (this._isAuth == true) {
      this._sessionId = auth.getSessionId();
      this._client.setSessionId(this._sessionId);
    }
//     this._client.debugRPC(this._debug);
//     AuthenticateCallback auth = await this
//         ._client
//         .authenticate(this._user, this._password, this._database);
//     this._isAuth = auth.isSuccess;
// print(auth.getError());
//     if (this._isAuth == true) {
//       this._sessionId = auth.getSessionId();
//       this._client.setSessionId(this._sessionId);
//     }
    return this._isAuth;
  }
}
