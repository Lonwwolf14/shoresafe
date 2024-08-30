import 'package:flutter/material.dart';

class Beach {
  final int id;
  final String name;
  final double lat;
  final double lon;

  Beach({required this.id, required this.name, required this.lat, required this.lon});
}

class BeachConditions {
  final double waveHeight;
  final int windSpeed;
  final String waterQuality;

  BeachConditions({required this.waveHeight, required this.windSpeed, required this.waterQuality});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Beach? selectedBeach;
  String safetyStatus = '';

  final List<Beach> beaches = [
    Beach(id: 1, name: 'Marina Beach', lat: 13.0500, lon: 80.2824),
    Beach(id: 2, name: 'Kovalam Beach', lat: 8.3988, lon: 76.9780),
    Beach(id: 3, name: 'Goa Baga Beach', lat: 15.5566, lon: 73.7542),
  ];

  final Map<int, BeachConditions> dummyConditions = {
    1: BeachConditions(waveHeight: 1.2, windSpeed: 15, waterQuality: 'Good'),
    2: BeachConditions(waveHeight: 2.5, windSpeed: 25, waterQuality: 'Poor'),
    3: BeachConditions(waveHeight: 0.8, windSpeed: 10, waterQuality: 'Excellent'),
  };

  void updateSafetyStatus() {
    if (selectedBeach != null) {
      final conditions = dummyConditions[selectedBeach!.id]!;
      final isSafe = conditions.waveHeight < 2 && conditions.windSpeed < 20 && conditions.waterQuality != 'Poor';
      setState(() {
        safetyStatus = isSafe ? 'Suitable' : 'Not Suitable';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DropdownButton<Beach>(
            isExpanded: true,
            hint: Text('Select a beach'),
            value: selectedBeach,
            onChanged: (Beach? newValue) {
              setState(() {
                selectedBeach = newValue;
                updateSafetyStatus();
              });
            },
            items: beaches.map<DropdownMenuItem<Beach>>((Beach beach) {
              return DropdownMenuItem<Beach>(
                value: beach,
                child: Text(beach.name),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          if (selectedBeach != null) ...[
            Text(selectedBeach!.name, style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.location_on, size: 16),
                SizedBox(width: 5),
                Text('Lat: ${selectedBeach!.lat}, Lon: ${selectedBeach!.lon}'),
              ],
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              color: safetyStatus == 'Suitable' ? Colors.green[100] : Colors.red[100],
              child: Row(
                children: [
                  Icon(Icons.warning, size: 24),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Safety Status', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(safetyStatus),
                    ],
                  ),
                ],
              ),
            ),
          ],
          Spacer(),
          Text(
            'Note: This is a prototype using dummy data. Real-time data integration pending.',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
