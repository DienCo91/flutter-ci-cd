part of 'timer_bloc.dart';

// @immutable
sealed class TimerEvent {
  const TimerEvent();
}

final class TimerInitialized extends TimerEvent {
  final int second;
  const TimerInitialized({required this.second});
}

final class TimerStarted extends TimerEvent {}

final class TimeTicked extends TimerEvent {
  final int second;
  const TimeTicked({required this.second});
}

final class TimerPaused extends TimerEvent {
  const TimerPaused();
}

final class TimerReset extends TimerEvent {
  const TimerReset();
}
