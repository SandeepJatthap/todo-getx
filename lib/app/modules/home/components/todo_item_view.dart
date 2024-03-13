import 'package:flutter/material.dart';

import '../../../data/data/model/todo_model.dart';

class TodoItemView extends StatelessWidget {
  final Function() onClick;
  final TodoItem todoItem;

  const TodoItemView(
      {super.key, required this.onClick, required this.todoItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: <Widget>[
          if (todoItem.status == 0)
            ListTile(
                title: Hero(
                    tag: todoItem.id.toString(),
                    child: Text(
                      todoItem.title ?? "",
                      style: TextStyle(
                        fontSize: 18.0,
                        decoration: todoItem.status == 0
                            ? TextDecoration.none
                            : TextDecoration.lineThrough,
                      ),
                    )),
                subtitle: Text(
                  '${todoItem.date} • ${todoItem.priority}',
                  style: TextStyle(
                    fontSize: 15.0,
                    decoration: todoItem.status == 0
                        ? TextDecoration.none
                        : TextDecoration.lineThrough,
                  ),
                ),
                trailing: Checkbox(
                  onChanged: (value) {
                    todoItem.status = value! ? 1 : 0;
                    // DatabaseHelper.instance.updateTask(task);
                    // Toast.show("Task Completed", context,
                    //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    // _updateTaskList();
                  },
                  activeColor: Theme.of(context).primaryColor,
                  value: todoItem.status == 1 ? true : false,
                ),
                onTap: onClick),
          //Divider(),
        ],
      ),
    );
  }
}
