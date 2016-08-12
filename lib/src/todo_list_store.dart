import 'dart:async';

import 'package:w_flux/w_flux.dart';
import 'package:w_module/w_module.dart' show DispatchKey;

import 'data_api.dart';
import 'model/todo_item.dart';
import 'todo_list_actions.dart';
import 'todo_list_events.dart';

class TodoListStore extends Store {
  final DataApi _api;
  final TodoListEvents _events;
  final DispatchKey _key;
  final Map<String, TodoItem> _todoItems = {};

  TodoListStore(this._api, TodoListActions actions, this._events, this._key) {
    actions.addTodo.listen(_onAddTodo);
    actions.deleteTodo.listen(_onDeleteTodo);
    actions.finishTodo.listen(_onFinishTodo);

    _api.getAllItems().then((items) => _todoItems.addAll(items));
  }

  Map<String, TodoItem> get todoItems => new Map.unmodifiable(_todoItems);

  Future _onAddTodo(NewTodoItemParams newTodo) async {
    TodoItem todo = new TodoItem(description: newTodo.description, reportId: newTodo.reportId, isFinished: false);
    String id = await _api.saveTodoItem(todo);

    _todoItems[id] = todo;
    _trigger();
  }

  Future _onDeleteTodo(String id) async {
    await _api.deleteTodoItem(id);

    _todoItems.remove(id);
    _trigger();
  }

  Future _onFinishTodo(String id) async {
    TodoItem todo = _todoItems[id];
    todo = new TodoItem(description: todo.description, reportId: todo.reportId, isFinished: true);
    await _api.updateTodoItem(id, todo);

    _todoItems[id] = todo;
    _trigger();
  }

  void _trigger() {
    _events.todoListUpdated(todoItems, _key);
    trigger();
  }
}
