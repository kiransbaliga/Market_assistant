import 'dart:convert';
// import 'dart:html';
import 'package:http/http.dart';
import 'package:markus/Objects/user.dart';
import 'package:markus/items.dart';
import 'package:markus/to_Database/sqlStorage.dart';

class DbMethods {
  String url = 'https://market-ai-markus.herokuapp.com';
  String _token = '',
      _userid = '',
      _name = '',
      _email = '',
      _username = '',
      _clas = '["ClassE"]';
  void loginuser(String email, String password) async {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$email:$password'));
    Response r =
        await get(url + '/api/login', headers: {'authorization': basicAuth});
    Map data = json.decode(r.body);

    Response detailsresponse = await get(
      url + '/api/user/${data['user_id']}',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${data['token']}'
      },
    );

    Map userdata = json.decode(detailsresponse.body);
    login(data['token'], data['user_id'], userdata['user']['name'],
        userdata['user']['email'], userdata['user']['username']);
    _token = data['token'];
    _userid = data['user_id'];
    _name = userdata['user']['name'];
    _email = userdata['user']['email'];
    _username = userdata['user']['username'];
  }

  void submitrating(Rating rating) async {
    Response r = await post(url + '/api/user/rating',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token'
        },
        body: jsonEncode({
          'brand': rating.brand,
          'quality': rating.quality,
          'offers': rating.offers,
          'price': rating.price
        }));
    print(r.body);
    Response r2 = await get(
      url + '/api/user/shoppinglist',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token'
      },
    );
    print(r2.body);
    Map theClass = json.decode(r2.body);

    _clas = theClass["class"];
    assign(_clas);
  }

  void logout() async {
    await logoutfromsql();
    _token = '';
    _userid = '';
    _name = '';
    _email = '';
    _username = '';
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

    Map data = json.decode(r.body);
    login(data['token'], data['user_id'], name, email, username);
    _token = data['token'];
    _userid = data['user_id'];

    _name = name;
    _email = email;
    _username = username;
  }

  Future<void> initialise() async {
    if (!isdatabaseopen()) {
      await openLocalStorage();
      List<Map> m = await getfromsql();
      if (m != null) {
        if (m.length == 0) {
          _token = '';
          _userid = '';
          _name = '';
        } else {
          _token = m[0]['token'] ?? '';
          _userid = m[0]['user_id'] ?? '';
          _name = m[0]['name'] ?? '';
          _email = m[0]['email'] ?? '';
          _username = m[0]['username'] ?? '';
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
    return _token != '';
  }

  String getid() {
    return _userid;
  }

  String getname() {
    return _name;
  }

  // String getclass() {
  //   return _clas[7];
  // }
}

DbMethods user = DbMethods();
