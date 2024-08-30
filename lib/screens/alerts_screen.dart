import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ... rest of the AlertsScreen implementation
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beach Safety Alerts'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSafetyStatus(),
          const SizedBox(height: 20),
          _buildWeatherSummary(),
          const SizedBox(height: 20),
          _buildAlertsList(),
          const SizedBox(height: 20),
          _buildSafetyTips(),
        ],
      ),
    );
  }

  Widget _buildSafetyStatus() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.yellow,
      child: const Text(
        'CAUTION: Moderate Risk',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildWeatherSummary() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Weather', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Temperature: 28°C'),
            Text('Wind: 15 km/h'),
            Text('Waves: 1.5m'),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Active Alerts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _buildAlertItem('Strong Rip Currents', Icons.warning, Colors.red),
        _buildAlertItem('High UV Index', Icons.wb_sunny, Colors.orange),
      ],
    );
  }

  Widget _buildAlertItem(String text, IconData icon, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text),
      tileColor: color.withOpacity(0.1),
    );
  }

  Widget _buildSafetyTips() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Safety Tips', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('• Swim between the flags'),
            Text('• Stay hydrated'),
            Text('• Apply sunscreen regularly'),
          ],
        ),
      ),
    );
  }
}