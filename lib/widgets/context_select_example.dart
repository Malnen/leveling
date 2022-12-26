import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leveling/blocs/counter_bloc/counter_bloc.dart';
import 'package:leveling/blocs/counter_bloc/counter_state.dart';

class ContextSelectExample extends StatelessWidget {
  const ContextSelectExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int value = context.select<CounterBloc, int>((CounterBloc bloc) => bloc.state.value);
    return Text(value.toString());
  }
}
