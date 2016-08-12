import 'package:w_flux/w_flux.dart';

class TodoListActions {
  final Action<NewTodoItemParams> addTodo = new Action();
  final Action<String> deleteTodo = new Action();
  final Action<String> finishTodo = new Action();
  final Action<String> showReport = new Action();
}

class NewTodoItemParams {
  final String description;
  final String reportId;
  NewTodoItemParams({this.description, this.reportId});
}
