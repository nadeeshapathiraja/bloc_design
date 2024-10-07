
// To parse this JSON data, do
//
//     final todoTask = todoTaskFromJson(jsonString);

import 'dart:convert';

List<TodoTask> todoTaskFromJson(String str) => List<TodoTask>.from(json.decode(str).map((x) => TodoTask.fromJson(x)));

String todoTaskToJson(List<TodoTask> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodoTask {
    int? id;
    String? todo;
    bool? completed;
    int? userId;

    TodoTask({
        this.id,
        this.todo,
        this.completed,
        this.userId,
    });

    factory TodoTask.fromJson(Map<String, dynamic> json) => TodoTask(
        id: json["id"],
        todo: json["todo"],
        completed: json["completed"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "todo": todo,
        "completed": completed,
        "userId": userId,
    };
}
