import 'package:flutter/material.dart';
import 'package:leveling/models/todo.dart';

class TodoCreator extends StatefulWidget {
  final Todo? todo;

  TodoCreator({this.todo, Key? key}) : super(key: key);

  @override
  State<TodoCreator> createState() => _TodoCreatorState();
}

class _TodoCreatorState extends State<TodoCreator> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      controller.text = widget.todo!.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create todo')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(controller: controller),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, controller.value.text);
            },
            child: Text('Ok'),
          )
        ],
      ),
    );
  }
}
