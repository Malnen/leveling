import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:leveling/blocs/counter_bloc/counter_event.dart';
import 'package:leveling/blocs/counter_bloc/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(value: 0)) {
    on<IncrementEvent>(_onIncrementEvent);
    on<DecrementEvent>(_onDecrementEvent);
  }

  void _onIncrementEvent(IncrementEvent event, Emitter<CounterState> emit) {
    final CounterState newState = CounterState(value: state.value + 1);
    emit(newState);
  }

  void _onDecrementEvent(DecrementEvent event, Emitter<CounterState> emit) {
    final CounterState newState = CounterState(value: state.value - 1);
    emit(newState);
  }
}
