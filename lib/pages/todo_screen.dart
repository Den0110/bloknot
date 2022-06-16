import 'package:bloknot/models/todo_item.dart';
import 'package:bloknot/redux/todo/todo_reducer.dart';
import 'package:bloknot/redux/todo/todo_viewmodel.dart';
import 'package:bloknot/widgets/todo/todo_item_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final Store<List<TodoItem>> store = Store<List<TodoItem>>(
    todoReducers,
    initialState: const [
      TodoItem(text: 'Попить чай', priority: 5),
      TodoItem(text: 'Сдать приложение Bloknot', priority: 2),
      TodoItem(text: 'Доделать экран todo', priority: 2),
      TodoItem(text: 'Реализовать заметки', priority: 2),
      TodoItem(text: 'Сходить в магазин', priority: 1),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo'),
      ),
      body: StoreProvider(
        store: store,
        child: StoreConnector<List<TodoItem>, TodoViewModel>(
          converter: (store) => TodoViewModel.fromStore(store),
          builder: (context, vm) {
            return ListView.builder(
              itemBuilder: (context, index) => TodoItemView(
                todoItem: vm.items[index],
                onAddPriorityPressed: () => vm.onAddPriorityPressed(index),
                onEdited: (text) => vm.onEdited(index, text),
                onDeletePressed: () => vm.onDeletePressed(index),
              ),
              itemCount: vm.items.length,
            );
          },
        ),
      ),
    );
  }
}
