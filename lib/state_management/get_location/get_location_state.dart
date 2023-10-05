part of 'get_location_bloc.dart';

abstract class GetLocationState {}

final class GetLocationInitial extends GetLocationState {}

class GetCurrentLocationSuccesState extends GetLocationState {
  final Position position;

  GetCurrentLocationSuccesState({required this.position});
}

class GetCurrentLocationfFailureState extends GetLocationState {}

class GetCurrentLocationfProccesState extends GetLocationState {}
