import 'dart:async';

import 'package:flutter/material.dart';

class StreamBuilderExample extends StatefulWidget {
  @override
  State<StreamBuilderExample> createState() => _StreamBuilderExampleState();
}

class _StreamBuilderExampleState extends State<StreamBuilderExample> {
  late StreamController<int> streamController;

  bool counting = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (counting) buildStreamBuilder(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: generateNumbers,
            child: Text(counting ? 'Restart' : 'Start'),
          ),
        ],
      ),
    );
  }

  StreamBuilder<int> buildStreamBuilder() {
    return StreamBuilder<int>(
      stream: streamController.stream,
      builder: (
        BuildContext context,
        AsyncSnapshot<int> snapshot,
      ) {
        final ConnectionState state = snapshot.connectionState;
        switch (state) {
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          case ConnectionState.active:
            return onConnection(snapshot);
          case ConnectionState.done:
            return const Text(
              'Done',
              style: TextStyle(
                fontSize: 40,
              ),
            );
          default:
            return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }

  Text onConnection(AsyncSnapshot<int> snapshot) {
    if (snapshot.hasError) {
      return const Text('Error');
    } else if (snapshot.hasData) {
      return onHasData(snapshot);
    }

    return const Text('Empty data');
  }

  Text onHasData(AsyncSnapshot<int> snapshot) {
    return Text(
      snapshot.data.toString(),
      style: const TextStyle(
        color: Colors.red,
        fontSize: 40,
      ),
    );
  }

  Future<void> generateNumbers() async {
    counting = true;
    setState(() {});
    streamController = StreamController<int>();
    await Future<void>.delayed(const Duration(seconds: 3));

    for (int i = 1; i <= 10; i++) {
      streamController.add(i);
      await Future<void>.delayed(const Duration(seconds: 1));
      setState(() {});
    }

    streamController.close();
    await Future<void>.delayed(const Duration(seconds: 2));
    counting = false;
    setState(() {});
  }
}
