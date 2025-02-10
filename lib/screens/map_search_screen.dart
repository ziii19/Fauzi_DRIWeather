import 'dart:convert';
import 'package:fauzi_driweather/core/theme/app_color.dart';
import 'package:fauzi_driweather/core/utils/show_snackbar.dart';
import 'package:fauzi_driweather/screens/blocs/location/location_cubit.dart';
import 'package:fauzi_driweather/services/get_current_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import 'blocs/weather/weather_bloc.dart';

class MapSearchScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const MapSearchScreen(),
      );
  const MapSearchScreen({super.key});

  @override
  MapSearchScreenState createState() => MapSearchScreenState();
}

class MapSearchScreenState extends State<MapSearchScreen> {
  LatLng _currentLocation = const LatLng(-7.250445, 112.768845);
  final TextEditingController _searchController = TextEditingController();
  final MapController _mapController = MapController();
  List<Map<String, dynamic>> _suggestions = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await getUserLocation();
    _updateLocation(LatLng(position.latitude, position.longitude));
  }

  void _updateLocation(LatLng newLocation) {
    setState(() {
      _currentLocation = newLocation;
      context
          .read<LocationCubit>()
          .setLocation(newLocation.latitude, newLocation.longitude);
    });
    _mapController.move(_currentLocation, 13.0);
  }

  Future<List<Map<String, dynamic>>> _searchLocation(String query) async {
    final url =
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=5';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load location');
    }
  }

  void _onSearchChanged(String query) async {
    if (query.isNotEmpty) {
      final results = await _searchLocation(query);
      setState(() {
        _suggestions = results;
      });
    } else {
      setState(() {
        _suggestions = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is WeatherFailed) {
          showSnackBar(context, state.error);
        } else if (state is WeatherSuccess) {
          Navigator.pop(context);
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _currentLocation,
                  initialZoom: 13.0,
                  onTap: (_, latlng) => _updateLocation(latlng),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    tileProvider: CancellableNetworkTileProvider(),
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: _currentLocation,
                        child: const Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildSearchBar(),
                      if (_suggestions.isNotEmpty) _buildSuggestionsList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: Stack(
            children: <Widget>[
              Positioned(
                bottom: 80.0,
                right: 16.0,
                child: FloatingActionButton(
                  heroTag: null,
                  child: const Icon(Icons.check),
                  onPressed: () => context.read<WeatherBloc>().add(
                      GetRealtimWeather(
                          lat: _currentLocation.latitude,
                          lon: _currentLocation.longitude)),
                ),
              ),
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: FloatingActionButton(
                  heroTag: null,
                  child: const Icon(Icons.my_location),
                  onPressed: () => _getCurrentLocation(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 15),
          border: InputBorder.none,
          hintText: 'Search location...',
          prefixIcon: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        onChanged: _onSearchChanged,
      ),
    );
  }

  Widget _buildSuggestionsList() {
    return Container(
      width: double.infinity,
      height: 300,
      color: AppColor.white,
      child: ListView.builder(
        itemCount: _suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = _suggestions[index];
          return ListTile(
            title: Text(suggestion['display_name']),
            onTap: () {
              final lat = double.parse(suggestion['lat']);
              final lon = double.parse(suggestion['lon']);
              _updateLocation(LatLng(lat, lon));
              setState(() {
                _suggestions = [];
                _searchController.clear();
              });
            },
          );
        },
      ),
    );
  }
}
