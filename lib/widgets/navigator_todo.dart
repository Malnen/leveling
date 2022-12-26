import 'package:flutter/material.dart';
import 'package:leveling/models/todo.dart';
import 'package:leveling/widgets/todo_creator.dart';

class NavigatorTodo extends StatefulWidget {
  final List<Todo> todos;

  const NavigatorTodo({Key? key, required this.todos}) : super(key: key);

  @override
  State<NavigatorTodo> createState() => _NavigatorTodoState();
}

class _NavigatorTodoState extends State<NavigatorTodo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: addTodo,
          child: const Text('Add todo'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.todos.length,
            itemBuilder: (BuildContext context, int index) => buildTodo(index),
          ),
        ),
      ],
    );
  }

  void addTodo() async {
    final String? todoText =
        await Navigator.push(context, MaterialPageRoute<String>(builder: (context) => TodoCreator()));
    if (todoText != null && todoText.isNotEmpty) {
      final Todo todo = Todo(value: todoText, id: widget.todos.length + 1);
      widget.todos.add(todo);
      setState(() {});
    }
  }

  Widget buildTodo(int index) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  widget.todos[index].id.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  widget.todos[index].value,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 10),
                InkWell(
                  child: Icon(Icons.delete),
                  onTap: () {
                    widget.todos.remove(widget.todos[index]);
                    setState(() {});
                  },
                )
              ],
            ),
            const Divider(height: 1, color: Colors.black, thickness: 1),
          ],
        ),
      ),
      onTap: () async {
        final Todo todo = widget.todos[index];
        final String? todoText = await Navigator.push(
          context,
          MaterialPageRoute<String>(
            builder: (BuildContext context) => TodoCreator(
              todo: todo,
            ),
          ),
        );
        if (todoText != null && todoText.isNotEmpty) {
          widget.todos[index] = Todo(value: todoText, id: todo.id);
          setState(() {});
        }
      },
    );
  }
}
