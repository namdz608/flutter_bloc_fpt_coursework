part of 'trip_bloc.dart';

abstract class TripState extends Equatable {}

class TripLoading extends TripState {
  @override
  List<Object> get props => [];
}

class TripLoadSuccess extends TripState {
  final Trips trip;
  TripLoadSuccess({required this.trip});

  @override
  List<Object> get props => [trip];
}

class TripAddSuccess extends TripState {
  @override
  List<Object> get props => [];
}
