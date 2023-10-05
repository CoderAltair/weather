import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
part 'get_location_event.dart';
part 'get_location_state.dart';

class GetLocationBloc extends Bloc<GetLocationEvent, GetLocationState> {
  GetLocationBloc() : super(GetLocationInitial()) {
    on<GetStartCurrentLocationEvent>(getLocation);
  }
  Future<void> getLocation(
    GetStartCurrentLocationEvent event,
    Emitter<GetLocationState> emit,
  ) async {
    emit(GetCurrentLocationfProccesState());
    try {
      Position pos = await _determinePosition();
      emit(GetCurrentLocationSuccesState(position: pos));
    } catch (e) {
      emit(GetCurrentLocationfFailureState());
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
