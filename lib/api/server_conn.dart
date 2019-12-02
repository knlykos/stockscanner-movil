import 'package:odoo_api/odoo_api.dart';
import 'package:odoo_api/odoo_user_response.dart';

class ServerConn {
  static String userField;
  static String passwordField;
  static String databaseField;
  static String hostField;
  OdooClient _client;
  bool isAuth;
  String sessionId;

  OdooClient get client => _client;

  set client(OdooClient client) {
    _client = client;
  }

  bool debug = true;

  static final ServerConn _singleton = ServerConn._internal();

  factory ServerConn(
      {String user, String password, String database, String host}) {
    userField = user;
    passwordField = password;
    databaseField = database;
    hostField = host;

    return _singleton;
  }

  ServerConn._internal() {
    if (this.client == null) {
      this.client = OdooClient(hostField);
      this.client.getDatabases().then((onValue) {
        print(onValue);
      });
    }
  }

  Future<bool> auth() async {
    this.client.debugRPC(this.debug);
    AuthenticateCallback auth =
        await this.client.authenticate(userField, passwordField, databaseField);
    bool isAuth = auth.isSuccess;
    print(isAuth);
    if (isAuth == true) {
      this.sessionId = auth.getSessionId();
      this.client.setSessionId(auth.getSessionId());
    }
    return isAuth;
  }

  // rest of the class
}
