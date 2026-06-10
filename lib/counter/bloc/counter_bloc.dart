import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState()) {
    on<CounterIncremented>((event, emit) {
      print("CounterIncremented event received ${state.count}");
      emit(CounterState(count: state.count + 1));
    });
    on<CounterDecremented>((event, emit) {
      emit(CounterState(count: state.count - 1));
    });
    on<CounterReset>((event, emit) {
      emit(const CounterState(count: 0));
    });
  }
}
