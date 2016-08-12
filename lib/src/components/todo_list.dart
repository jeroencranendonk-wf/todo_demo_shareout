import 'package:web_skin_dart/ui_core.dart';

import '../todo_list_actions.dart';
import '../todo_list_store.dart';

@Factory()
UiFactory<TodoListProps> TodoList;

@Props()
class TodoListProps extends FluxUiProps<TodoListActions, TodoListStore> {}

@Component()
class TodoListComponent extends FluxUiComponent<TodoListProps> {
  @override
  render() {
    // render props.store.todoItems;
  }
}
