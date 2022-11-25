import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Utils/network_handler.dart';

class AuthRepositories {
  Future<void> login() async {
    print("attempting");

    await Future.delayed(Duration(seconds: 3));
    print("Logged in");
  }

  Future<void> authenticateUser(String email, String password) async {
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
        // user = User.fromJson(json.decode(response.body));
        // await this.getUserCoreData(context);
        // this.isUserLoggedIn = true;
        // checkIfUserConsultant();

        log("User Entered");
        print("user entered");
      } else if (response.statusCode == 206) {
        throw Exception("No Core Details Exist");
      } else {
        throw Exception(json.decode(response.body)['error']);
      }
    } catch (e) {
      throw Exception(e.toString());
      // Network.handleError(e, showCustomMessage: true);
    }
  }
}
