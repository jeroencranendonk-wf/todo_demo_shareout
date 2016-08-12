import 'dart:async';

import 'package:wdesk_sdk/experience_framework.dart';

import 'todo_list_module.dart';

class TodoListExperience extends RichExperience {
  final String resourceId;

  final AppContext _context;
  final TodoListModule _module;

  List<StreamSubscription> _subscriptions;

  TodoListExperience(this._context, this.resourceId) : _module = new TodoListModule();

  @override
  Future onLoad() async {
    _subscriptions = [
      _module.events.showReport.listen((reportId) => _context.navigator.goTo('report', resourceId: reportId))
    ];
  }

  @override
  Future onUnload() async {
    _subscriptions?.forEach((sub) => sub.cancel());
  }
}
