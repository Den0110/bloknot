import 'package:bloknot/models/todo_item.dart';
import 'package:bloknot/redux/todo/todo_actions.dart';
import 'package:redux/redux.dart';

class TodoViewModel {
  final List<TodoItem> items;
  final Function(int) onAddPriorityPressed;
  final Function(int, String) onEdited;
  final Function(int) onDeletePressed;

  TodoViewModel({
    required this.items,
    required this.onAddPriorityPressed,
    required this.onEdited,
    required this.onDeletePressed,
  });

  static TodoViewModel fromStore(Store<List<TodoItem>> store) {
    return TodoViewModel(
      items: store.state,
      onAddPriorityPressed: (index) =>
          store.dispatch(TodoAddPriorityAction(store.state[index])),
      onEdited: (index, text) =>
          store.dispatch(TodoEditAction(store.state[index], text)),
      onDeletePressed: (index) =>
          store.dispatch(TodoDeleteAction(store.state[index])),
    );
  }
}
