import 'dart:convert';
// import 'dart:html';
import 'package:http/http.dart';
import 'package:markus/to_Database/sqlStorage.dart';

class DbMethods {
  String url = 'http://10.0.2.2:5000';
  String _token = '', _userid = '', _name = '', _email = '', _username = '';
  void loginuser(String email, String password) async {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$email:$password'));
    print('check 2 $basicAuth');
    Response r =
        await get(url + '/api/login', headers: {'authorization': basicAuth});

    print(r.statusCode);
    print(r);
    Map data = json.decode(r.body);

    Response detailsresponse = await get(
      url + '/api/user/${data['user_id']}',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${data['token']}'
      },
    );

    Map userdata = json.decode(detailsresponse.body);
    login(data['token'], data['user_id'], userdata['name'], userdata['email'],
        userdata['username']);
    print(detailsresponse.body);
    _token = data['token'];
    _userid = data['user_id'];
    print(_token);
  }

  void signupuser(
      String name, String email, String username, String password) async {
    Response r = await post(url + '/api/register',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'username': username,
          'password': password
        }));
    print(r.body);

    Map data = json.decode(r.body);
    login(data['token'], data['user_id'], name, email, username);
    _token = data['token'];
    _userid = data['user_id'];
  }

  Future<void> initialise() async {
    if (!isdatabaseopen()) {
      print('called');
      await openLocalStorage();
      List<Map> m = await getfromsql();
      if (m != null) {
        if (m.length == 0) {
          _token = '';
          _userid = '';
          _name = '';
        } else {
          _token = m[0]['token'];
          _userid = m[0]['user_id'];
          _name = m[0]['name'];
        }
      } else {
        _token = '';
        _userid = '';
        _name = '';
      }
    }
  }

  String gettoken() {
    return _token;
  }

  bool signincheck() {
    print('token:$_token');
    print(_token != '');
    return _token != '';
  }

  String getid() {
    return _userid;
  }

  String getname() {
    return _name;
  }
}
