import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationSearchBar extends StatefulWidget {
  const LocationSearchBar({Key? key}) : super(key: key);

  @override
  _LocationSearchBarState createState() => _LocationSearchBarState();
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  String _currentLocation = '';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentLocation =
            'Current Location: ${position.latitude}, ${position.longitude}';
      });
    } catch (e) {
      setState(() {
        _currentLocation = 'Unable to get current location';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for a beach',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        Text(_currentLocation),
      ],
    );
  }
}
