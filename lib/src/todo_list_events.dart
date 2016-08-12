import 'package:w_module/w_module.dart' show Event, DispatchKey;

import 'model/todo_item.dart';

class TodoListEvents {
  final Event<String> showReport;
  final Event<Map<String, TodoItem>> todoListUpdated;

  TodoListEvents(DispatchKey key)
      : showReport = new Event(key),
        todoListUpdated = new Event(key);
}
