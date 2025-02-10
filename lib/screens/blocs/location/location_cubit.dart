import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../services/get_current_location.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  void getCurrentLocation() async {
    Position location = await getUserLocation();

    final locationName = await _getDistrictFromLatLng(
      location.latitude,
      location.longitude,
    );

    emit(
      LocationSuccess(
        currentLocation: LatLng(
          location.latitude,
          location.longitude,
        ),
        locationName: locationName ?? 'Surabaya',
      ),
    );
  }

  void setLocation(double lat, double lon) async {
    final locationName = await _getDistrictFromLatLng(
      lat,
      lon,
    );
    emit(
      LocationSuccess(
        currentLocation: LatLng(
          lat,
          lon,
        ),
        locationName: locationName ?? 'Surabaya',
      ),
    );
  }

  Future<String?> _getDistrictFromLatLng(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      return place.subLocality ?? 'sub-district not found';
    } catch (e) {
      return 'sub-district not found';
    }
  }
}
