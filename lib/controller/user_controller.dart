import 'dart:convert';

import 'package:bloc_patterns/services/api_service.dart';
import 'package:bloc_patterns/services/http_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import '../model/user_data_model.dart';
import '../model/user_model.dart';

class UserController {
  static Future<UserModel> userlogin(
    String username,
    String password,
  ) async {
    Map body = {
      "username": username,
      "password": password,
    };

    print(body);

    Response response = await postRequest(
      ApiService.loginApi,
      body,
    );
    print("Response: ${response.body}");
    dynamic result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // data kiyala variyable ekakin enawa nm data and after pass this type
      // dynamic result = jsonDecode(response.body);
      // return response.body;
      return userModelFromJson(jsonEncode(result));
    } else if (response.statusCode == 400) {
      return Future.error(
        result['message'],
      );
    } else {
      return Future.error(
        Exception(
          'HTTP Request Failed : ${response.statusCode}',
        ),
      );
    }
  }

  static Future<UserDataModel> getUserDetails() async {
    //Get token from secure stroge
    // Create storage
    const storage = FlutterSecureStorage();

    // Read value
    String? userData = await storage.read(key: "LoginData");
    Logger().w("userData 2");
    UserModel logindataModel = userModelFromJson(userData!);
    Logger().w(logindataModel.token);
    Response response = await getRequest(
      ApiService.getUserData,
      token: logindataModel.token,
    );
    Logger().d(response.body);

    dynamic result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return userDataModelFromJson(jsonEncode(result));
    } else if (response.statusCode == 400) {
      return Future.error(
        result['message'],
      );
    } else {
      return Future.error(
        Exception(
          'HTTP Request Failed : ${response.statusCode}',
        ),
      );
    }
  }
}
