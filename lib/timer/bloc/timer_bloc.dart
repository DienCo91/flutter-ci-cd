import 'dart:async';

import 'package:batterylevel/timer/ticker.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  late Ticker _ticker;
  late int _initialSecond;
  StreamSubscription<int>? _tickerSubscription;

  TimerBloc() : super(TimerState()) {
    on<TimerInitialized>(_handleTimerInitialized);
    on<TimerStarted>(_handleTimerStarted);
    on<TimeTicked>(_handleTimeTicked);
    on<TimerPaused>(_handleTimerPaused);
    on<TimerReset>(_handleTimerReset);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _handleTimerInitialized(TimerInitialized event, Emitter<TimerState> emit) {
    _initialSecond = event.second;
    emit(TimerState(secondState: event.second));
  }

  void _handleTimerStarted(TimerStarted event, Emitter<TimerState> emit) {
    _ticker = Ticker(take: state.secondState);
    emit(TimerState(secondState: state.secondState));
    _tickerSubscription = _ticker.tick(ticks: state.secondState).listen((second) => add(TimeTicked(second: second)));
  }

  void _handleTimerPaused(TimerPaused event, Emitter<TimerState> emit) {
    _tickerSubscription?.pause();
  }

  void _handleTimeTicked(TimeTicked event, Emitter<TimerState> emit) {
    if (event.second > 0) {
      emit(TimerState(secondState: event.second));
    } else {
      emit(TimerState(secondState: 0));
      _tickerSubscription?.cancel();
    }
  }

  void _handleTimerReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    print('reset to $_initialSecond');
    emit(TimerState(secondState: _initialSecond));
  }
}
