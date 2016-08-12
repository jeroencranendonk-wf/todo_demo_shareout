import 'dart:async';

import 'package:uuid/uuid.dart';

import 'model/todo_item.dart';

final Uuid _uuid = new Uuid();

class DataApi {
  Future<Map<String, TodoItem>> getAllItems() async => {};

  Future<String> saveTodoItem(TodoItem item) async => _uuid.v4();

  Future updateTodoItem(String id, TodoItem item) async {}

  Future deleteTodoItem(String id) async {}
}
