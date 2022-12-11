import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpt_mobileapp/model/Trip.dart';
import '../../api/tripApi.dart';
part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final TripFieldAPI api;
  TripBloc({required this.api}) : super(TripLoading()) {
    List<Trip> trip=[];
    on<LoadedTrip>((event, emit) async {
      try {
        if (state is TripLoadSuccess) {
          final current = state as TripLoadSuccess;
          Trips trips =
              await api.getTrips(current.trip.paginate.currentPage + 1);
         trip = trips.info + current.trip.info;
          emit(TripLoadSuccess(
              trip: Trips(info: trip, paginate: current.trip.paginate)));
        } else {
          emit(TripLoading());
          Trips trips = await api.getTrips(1);
          emit(TripLoadSuccess(trip: trips));
        }
      } catch (e) {
        print(e);
      }
    });

    on<TripReloaded>((event, emit) async {
      try {
        emit(TripLoading());
        Trips trips = await api.getTrips(1);
        emit(TripLoadSuccess(trip: trips));
      } catch (e) {
        print(e);
      }
    });

    on<AddedTrip>((event, emit) async {
      try {
        final a = await api.addTrip(event.trip);
        emit(TripAddSuccess());
        emit(TripLoading());
        Trips trips = await api.getTrips(1);
        emit(TripLoadSuccess(trip: trips));
      } catch (e) {
        print(e);
      }
    });

    on<DeleteTrip>((event, emit) async {
      try {
        emit(TripLoading());
        await api.deleteTrip(event.trip);
        Trips trips = await api.getTrips(1);
        emit(TripLoadSuccess(trip: trips));
      } catch (e) {
        print(e);
      }
    });
  }
}
