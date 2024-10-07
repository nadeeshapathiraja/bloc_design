import 'dart:convert';

import 'package:http/http.dart';

import '../model/todo_task_model.dart';
import '../services/api_service.dart';
import '../services/http_services.dart';

class TaskController {
  static Future<List<TodoTask>> getTaskList() async {
    Response response = await getRequest(
      ApiService.getUseTaskList,
    );

    print("Response: ${response.body}");

    dynamic result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return todoTaskFromJson(jsonEncode(result));
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
