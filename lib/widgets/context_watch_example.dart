import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leveling/blocs/counter_bloc/counter_bloc.dart';
import 'package:leveling/blocs/counter_bloc/counter_state.dart';

class ContextWatchExample extends StatelessWidget {
  const ContextWatchExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterState state = context.watch<CounterBloc>().state;
    final int value = state.value;

    return Text(value.toString());
  }
}
