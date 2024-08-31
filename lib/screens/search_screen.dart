import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> beaches = ['Beach 1', 'Beach 2', 'Beach 3']; // Your beach data
  List<String> filteredBeaches = [];

  @override
  void initState() {
    super.initState();
    filteredBeaches = beaches;
  }

  void _filterBeaches(String query) {
    setState(() {
      filteredBeaches = beaches
          .where((beach) => beach.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Beaches')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterBeaches,
              decoration: InputDecoration(
                labelText: 'Search beaches',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredBeaches.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredBeaches[index]),
                  // Add more beach details here
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}