import 'dart:convert';

import 'package:http/http.dart';

Future<Response> postRequest(String url, Object body, {String? token}) async {
  final headers = <String, String>{};

  headers['Content-Type'] = 'application/json';

  if (token != null && token.isNotEmpty) {
    headers['Authorization'] = 'Bearer $token';
  }

  return await post(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode(body),
  );
}

Future<Response> getRequest(String url, {String? token}) async {
  final headers = <String, String>{};

  headers['Content-Type'] = 'application/json';

  if (token != null && token.isNotEmpty) {
    headers['Authorization'] = 'Bearer $token';
  }

  return await post(
    Uri.parse(url),
    headers: headers,
  );
}
