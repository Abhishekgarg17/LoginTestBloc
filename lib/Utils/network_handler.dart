import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
enum API_CALL_TYPE { GET, POST, PUT, DELETE, PATCH }

class Network {
  static String internetConnectionErrorMsg =
      "Some Error Occured. Please check your Internet Connection";
  static String internalServerErrorMsg =
      "Server Error Occured. Please try again";
  static String generalErrorMsg = "Some Error Occured";

  static Future<http.Response> call(
    API_CALL_TYPE type,
    String endPoint, {
    var params,
    var body,
    bool setContentType = true,
    bool setContentAsFormData = false,
    bool staging = false,
  }) async {
    String username = "alnourish.official@gmail.com";
    String pass = "ackshayjain1";
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$pass'));

    String url = staging
        ? 'newstagingthcnewweb.herokuapp.com'
        : 'www.thehealthycompany.in';

    var uri;

    if (params != null) {
      uri = Uri.https(url, endPoint, params);
    } else {
      uri = Uri.https(url, endPoint);
    }

    var headers = <String, String>{
      'authorization': basicAuth,
    };

    if (setContentType) {
      headers['content-type'] = 'application/json';
    }
    if (setContentAsFormData) {
      headers['content-type'] = 'application/x-www-form-urlencoded';
    }

    late http.Response resp;

    try {
      switch (type) {
        case API_CALL_TYPE.GET:
          try {
            resp = await http.get(uri, headers: headers);
          } catch (e) {
            debugPrint("Exception GET : " + e.toString());
            throw Exception(e.toString());
          }
          break;
        case API_CALL_TYPE.POST:
          try {
            resp = await http.post(uri, headers: headers, body: body);
          } catch (e) {
            debugPrint("Exception POST : " + e.toString());
            throw Exception(e.toString());
          }
          break;
        case API_CALL_TYPE.PUT:
          try {
            resp = await http.put(uri, headers: headers, body: body);
          } catch (e) {
            debugPrint("Exception PUT : " + e.toString());
            throw Exception(e.toString());
          }
          break;
        case API_CALL_TYPE.DELETE:
          try {
            resp = await http.delete(uri, headers: headers);
          } catch (e) {
            debugPrint("Exception DELETE : " + e.toString());
            throw Exception(e.toString());
          }
          break;
        case API_CALL_TYPE.PATCH:
          try {
            resp = await http.patch(uri, headers: headers, body: body);
          } catch (e) {
            debugPrint("Exception PATCH : " + e.toString());
            throw Exception(e.toString());
          }
          break;
      }
    } catch (e) {
      debugPrint('Network Call Exception : ' + e.toString());

      if (e.toString().contains("SocketException")) {
        return http.Response.bytes(
          [0],
          110,
          reasonPhrase: internetConnectionErrorMsg,
        );
      } else if (e.toString().contains("Internal Server")) {
        return http.Response.bytes(
          [0],
          110,
          reasonPhrase: internalServerErrorMsg,
        );
      } else {
        return http.Response.bytes(
          [],
          110,
          reasonPhrase: generalErrorMsg,
        );
      }
    }
    return resp;
  }

  static void handleError(e, {bool showCustomMessage = false}) {
    // If network call error then throw error recieved
    // else for runtime error throw general error Message
    if (e.toString().contains(internetConnectionErrorMsg)) {
      throw Exception(e.toString());
    } else if (e.toString().contains("Internal Server Error")) {
      throw Exception(internalServerErrorMsg);
    } else if (showCustomMessage) {
      throw Exception(e.message);
    } else {
      throw Exception(Network.generalErrorMsg);
    }
  }
}
