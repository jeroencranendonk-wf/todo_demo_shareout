import 'dart:async';

import 'package:w_flux/w_flux.dart' show ActionSubscription;
import 'package:w_module/w_module.dart';

import 'components/todo_list.dart';
import 'data_api.dart';
import 'todo_list_actions.dart';
import 'todo_list_events.dart';
import 'todo_list_store.dart';

final DispatchKey _dispatchKey = new DispatchKey('TodoListModule');

class TodoListModule extends Module {
  final TodoListEvents _events;
  final TodoListActions _actions;
  TodoListStore _store;
  TodoListModuleComponents _components;

  List<ActionSubscription> _subscriptions;

  TodoListModule()
      : _events = new TodoListEvents(_dispatchKey),
        _actions = new TodoListActions() {
    _store = new TodoListStore(new DataApi(), _actions, _events, _dispatchKey);
    _components = new TodoListModuleComponents(_actions, _store);
  }

  @override
  ModuleComponents get components => _components;

  @override
  TodoListEvents get events => _events;

  @override
  Future onLoad() async {
    _subscriptions = [
      _actions.showReport.listen((reportId) => _events.showReport(reportId, _dispatchKey))
    ];
  }

  @override
  Future onUnload() async {
    _subscriptions?.forEach((sub) => sub.cancel());
  }
}

class TodoListModuleComponents extends ModuleComponents {
  final TodoListActions _actions;
  final TodoListStore _store;

  TodoListModuleComponents(this._actions, this._store);

  content() {
    return (TodoList()
      ..store = _store
      ..actions = _actions)();
  }
}
