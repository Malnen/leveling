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

  Widget onConnection(AsyncSnapshot<int> snapshot) {
    if (snapshot.hasError) {
      return const Text('Error');
    } else if (snapshot.hasData) {
      return onHasData(snapshot);
    }

    return const Text('Empty data');
  }

  Widget onHasData(AsyncSnapshot<int> snapshot) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          snapshot.data.toString(),
          style: const TextStyle(
            color: Colors.red,
            fontSize: 40,
          ),
        ),
        if (snapshot.data == 2137)
          Row(
            children: [
              const SizedBox(width: 10),
              SizedBox(
                child: Image.network('https://www.sp-klucze.pl/wp-content/uploads/2016/11/Jan-Pawe%C5%82-II.jpg'),
                height: 80,
                width: 80,
              ),
            ],
          ),
      ],
    );
  }

  Future<void> generateNumbers() async {
    counting = true;
    setState(() {});
    streamController = StreamController<int>();
    await Future<void>.delayed(const Duration(seconds: 3));

    for (int i = 1; i <= 2137; i++) {
      streamController.add(i);
      await Future<void>.delayed(const Duration(microseconds: 1));
      setState(() {});
    }

    await Future<void>.delayed(const Duration(seconds: 2));
    streamController.close();
    await Future<void>.delayed(const Duration(seconds: 2));
    counting = false;
    setState(() {});
  }
}
