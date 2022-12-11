part of 'trip_bloc.dart';

abstract class TripEvent extends Equatable {
  const TripEvent();

  @override
  List<Object> get props => [];
}

class LoadedTrip extends TripEvent {}

class TripReloaded extends TripEvent {}

class AddedTrip extends TripEvent {
  final Trip trip;
  const AddedTrip({required this.trip});

  @override
  List<Object> get props => [trip];
}

class DeleteTrip extends TripEvent {
  final Trip trip;
  const DeleteTrip({required this.trip});

  @override
  List<Object> get props => [trip];
}
