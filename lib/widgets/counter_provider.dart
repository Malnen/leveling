import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leveling/blocs/counter_bloc/counter_bloc.dart';
import 'package:leveling/blocs/counter_bloc/counter_event.dart';

class CounterProvider extends StatefulWidget {
  final Widget child;

  const CounterProvider({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  State<CounterProvider> createState() => _CounterProviderState();
}

class _CounterProviderState extends State<CounterProvider> {
  late final CounterBloc counterBloc;

  @override
  void initState() {
    super.initState();
    counterBloc = CounterBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>.value(
      value: counterBloc,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          widget.child,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => counterBloc.add(IncrementEvent()),
                child: const Text('Increment'),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () => counterBloc.add(DecrementEvent()),
                child: const Text('Decrement'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
