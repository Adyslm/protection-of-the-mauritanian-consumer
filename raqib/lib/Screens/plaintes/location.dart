import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Location location = Location();
  bool _isLoading = false;
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  String _errorMessage = '';

  Future<void> requestLocationPermission() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          throw Exception('Location services are disabled');
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          throw Exception('Location permissions denied');
        }
      }

      // Get location
      _locationData = await location.getLocation();
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _isLoading ? null : requestLocationPermission,
                child: _isLoading 
                    ? const CircularProgressIndicator()
                    : const Text("Get location"),
              ),
              const SizedBox(height: 20),
              if (_locationData != null) ...[
                Text("Latitude: ${_locationData!.latitude}"),
                Text("Longitude: ${_locationData!.longitude}"),
                Text("Les donnees: ${_locationData!.longitude}"),
              ],
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}