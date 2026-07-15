part of 'price_list_bloc.dart';

sealed class PriceListEvent extends Equatable {
  const PriceListEvent();

  @override
  List<Object> get props => [];
}

class FetchLocalDataEvent extends PriceListEvent {}

class SocketUpdateEvent extends PriceListEvent {
  final Stock updatedStock;
  const SocketUpdateEvent(this.updatedStock);

  @override
  List<Object> get props => [updatedStock];
}
