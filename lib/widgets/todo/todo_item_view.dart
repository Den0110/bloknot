import 'package:bloknot/models/todo_item.dart';
import 'package:flutter/material.dart';

class TodoItemView extends StatefulWidget {
  final TodoItem todoItem;
  final VoidCallback onAddPriorityPressed;
  final Function(String) onEdited;
  final VoidCallback onDeletePressed;

  const TodoItemView({
    Key? key,
    required this.todoItem,
    required this.onAddPriorityPressed,
    required this.onEdited,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  State<TodoItemView> createState() => _TodoItemViewState();
}

class _TodoItemViewState extends State<TodoItemView> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: isEditing
          ? TextFormField(
              autofocus: true,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                // border: InputBorder.none,
              ),
              initialValue: widget.todoItem.text,
              onFieldSubmitted: (text) {
                widget.onEdited(text);
                setState(() {
                  isEditing = false;
                });
              },
            )
          : Text(widget.todoItem.text),
      subtitle: Text("Приоритет: ${widget.todoItem.priority}"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            child: const Icon(Icons.arrow_upward),
            onTap: widget.onAddPriorityPressed,
          ),
          const SizedBox(width: 8),
          InkWell(
            child: const Icon(Icons.edit),
            onTap: () => setState(() {
              isEditing = !isEditing;
            }),
          ),
          const SizedBox(width: 8),
          InkWell(
            child: const Icon(Icons.delete),
            onTap: widget.onDeletePressed,
          ),
        ],
      ),
    );
  }
}
