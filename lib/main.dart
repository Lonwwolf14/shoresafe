import 'package:flutter/material.dart';
import 'services/beach_service.dart';
import 'models/beach_model.dart';
import 'location_search_bar.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/alerts_screen.dart';
import 'widgets/bottom_navigation.dart';

void main() => runApp(const ShoresSafeApp());

class ShoresSafeApp extends StatelessWidget {
  const ShoresSafeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShoresSafe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ShoresSafeHomePage(),
    );
  }
}

class ShoresSafeHomePage extends StatefulWidget {
  const ShoresSafeHomePage({Key? key}) : super(key: key);

  @override
  State<ShoresSafeHomePage> createState() => _ShoresSafeHomePageState();
}

class _ShoresSafeHomePageState extends State<ShoresSafeHomePage> {
  int _currentIndex = 0;
  late Future<Map<String, BeachSafetyData>> futureSafetyData;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const AlertsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    futureSafetyData = BeachService().fetchBeachSafetyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShoresSafe'),
      ),
      body: Column(
        children: [
          if (_currentIndex == 0) ...[
            const SizedBox(height: 8),
            LocationSearchBar(),
          ],
          Expanded(
            child: _currentIndex == 0
                ? BeachSafetyScreen(futureSafetyData: futureSafetyData)
                : _screens[_currentIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class BeachSafetyScreen extends StatelessWidget {
  final Future<Map<String, BeachSafetyData>> futureSafetyData;

  const BeachSafetyScreen({Key? key, required this.futureSafetyData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, BeachSafetyData>>(
      future: futureSafetyData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          final beachSafetyData = snapshot.data!;
          return ListView.builder(
            itemCount: beachSafetyData.length,
            itemBuilder: (context, index) {
              final beachName = beachSafetyData.keys.elementAt(index);
              final data = beachSafetyData[beachName]!;
              return Card(
                child: ListTile(
                  title: Text(beachName),
                  subtitle: Text('Safety: ${data.safetyCategory}'),
                  trailing: Text('Score: ${data.safetyScore.toStringAsFixed(2)}'),
                  onTap: () => _showDetailsDialog(context, data),
                ),
              );
            },
          );
        }
      },
    );
  }

  void _showDetailsDialog(BuildContext context, BeachSafetyData data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${data.beachName} Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Safety Category: ${data.safetyCategory}'),
              Text('Wave Height: ${data.conditions.waveHeight} m'),
              Text('Water Temperature: ${data.conditions.waterTemperature} °C'),
              Text('Timestamp: ${data.timestamp}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}