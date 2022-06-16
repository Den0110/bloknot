import 'package:bloknot/models/todo_item.dart';
import 'package:bloknot/redux/todo/todo_actions.dart';

List<TodoItem> todoReducers(List<TodoItem> items, dynamic action) {
  if (action is TodoEditAction) {
    return editItem(items, action);
  } else if (action is TodoAddPriorityAction) {
    return addPriorityState(items, action);
  } else if (action is TodoDeleteAction) {
    return deleteItemState(items, action);
  }
  return items;
}

List<TodoItem> editItem(List<TodoItem> items, TodoEditAction action) {
  return items
      .map((item) => item == action.item ? item.copyWith(text: action.newText) : item)
      .toList();
}

List<TodoItem> addPriorityState(
    List<TodoItem> items, TodoAddPriorityAction action) {
  return items
      .map((item) => item == action.item
          ? item.copyWith(priority: item.priority + 1)
          : item)
      .toList()
    ..sort((a, b) => b.priority - a.priority);
}

List<TodoItem> deleteItemState(List<TodoItem> items, TodoDeleteAction action) {
  return List.from(items)..remove(action.item);
}
