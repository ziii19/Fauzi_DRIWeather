part of 'location_cubit.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationSuccess extends LocationState {
  final LatLng currentLocation;
  final String locationName;

  LocationSuccess({
    required this.currentLocation,
    required this.locationName,
  });
}
