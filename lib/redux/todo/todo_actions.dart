import 'package:bloknot/models/todo_item.dart';

class TodoEditAction {
  final TodoItem item;
  final String newText;

  TodoEditAction(this.item, this.newText);
}

class TodoAddPriorityAction {
  final TodoItem item;

  TodoAddPriorityAction(this.item);
}

class TodoDeleteAction {
  final TodoItem item;

  TodoDeleteAction(this.item);
}
