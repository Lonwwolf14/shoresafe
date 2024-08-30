import 'package:flutter/material.dart';
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

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const AlertsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
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