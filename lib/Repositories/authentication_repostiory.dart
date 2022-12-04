import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Utils/network_handler.dart';

class AuthenticationRepository {
  // Login
  Future<dynamic> authenticateUser(String email, String password) async {
    var body = json.encode({
      'email': email,
      'password': password,
    });
    late http.Response response;

    try {
      response = await Network.call(
        API_CALL_TYPE.POST,
        '/api/v2/user/main/fetch/',
        body: body,
      );
      if (response.statusCode == 200) {
        log("LoginBloc:User Entered or Successfully Login");
      } else if (response.statusCode == 206) {
        throw Exception("No Core Details Exist");
      } else {
        throw Exception(json.decode(response.body)['error']);
      }
    } catch (e) {
      log(response.statusCode.toString());
      return response.statusCode.toString();
    }
    return response.statusCode.toString();
  }

  // SignUp
  Future<dynamic> registerUser(
      String name, String email, String password, String phone) async {
    late http.Response response;
    try {
      response = await Network.call(
        API_CALL_TYPE.POST,
        '/api/v2/user/main/create/',
        body: json.encode({
          'first_name': name,
          'email': email,
          'password': password,
          'platform': 'THCAPP',
          'phone': phone
        }),
      );
      if (response.statusCode == 200) {
        log("User registered");

        // user = User.fromJson(json.decode(response.body));
      } else {
        throw Exception(json.decode(response.body)['error']);
      }
    } catch (e) {
      log(response.body.toString());
      return json.decode(response.body)['error'].toString();
      // return response.statusCode.toString();
    }
    return response.statusCode.toString();
  }
}
