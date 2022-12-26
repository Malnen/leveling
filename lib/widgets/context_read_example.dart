import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leveling/blocs/counter_bloc/counter_bloc.dart';
import 'package:leveling/blocs/counter_bloc/counter_state.dart';

class ContextReadExample extends StatefulWidget {
  const ContextReadExample({Key? key}) : super(key: key);

  @override
  State<ContextReadExample> createState() => _ContextReadExampleState();
}

class _ContextReadExampleState extends State<ContextReadExample> {
  late final CounterBloc counterBloc;

  @override
  void initState() {
    super.initState();
    counterBloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, CounterState>(
      bloc: counterBloc,
      builder: (BuildContext context, CounterState state) => Text(
        state.value.toString(),
      ),
    );
  }
}
