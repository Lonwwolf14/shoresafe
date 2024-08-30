import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import '../models/beach_model.dart';

class BeachService {
  final String stormglassApiKey = '69491270-66fa-11ef-a732-0242ac130004-694912d4-66fa-11ef-a732-0242ac130004';

  Future<Map<String, BeachSafetyData>> fetchBeachSafetyData() async {
    final csvData = await _loadCsvData();
    final beachData = _getBeachData();
    final Map<String, BeachSafetyData> beachSafetyData = {};

    for (var beachName in beachData.keys) {
      final conditions = await _getStormglassData(beachData[beachName]!);
      final safetyScore = _calculateSafetyScore(conditions);
      final safetyCategory = _categorizeBeachSafety(safetyScore);
      beachSafetyData[beachName] = BeachSafetyData(
        beachName: beachName,
        safetyCategory: safetyCategory,
        safetyScore: safetyScore,
        conditions: conditions,
        timestamp: DateTime.now().toIso8601String(),
      );
    }

    return beachSafetyData;
  }

  Future<BeachConditions> _getStormglassData(Map<String, double> coords) async {
    final url =
        'https://api.stormglass.io/v2/weather/point?lat=${coords['lat']}&lng=${coords['lng']}&params=swellHeight,waveHeight,waterTemperature,currentSpeed';
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': stormglassApiKey});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return BeachConditions(
        waveHeight: data['hours'][0]['waveHeight']['noaa'],
        waterTemperature: data['hours'][0]['waterTemperature']['noaa'],
      );
    } else {
      throw Exception('Failed to load beach conditions');
    }
  }

  Future<Map<String, dynamic>> _loadCsvData() async {
    final rawCsv = await rootBundle.loadString('assets/Data.csv');
    List<List<dynamic>> rows = const CsvToListConverter().convert(rawCsv);

    Map<String, dynamic> csvData = {};
    List<String> headers = rows.first.map((e) => e.toString()).toList();

    for (var row in rows.skip(1)) {
      Map<String, dynamic> rowData = {};
      for (int i = 1; i < row.length; i++) {
        rowData[headers[i]] = row[i];
      }
      csvData[row[0].toString()] = rowData;
    }

    return csvData;
  }

  double _calculateSafetyScore(BeachConditions conditions) {
    double safetyScore = 0.0;

    // Apply scoring logic similar to the Python version
    if (conditions.waveHeight != null &&
        conditions.waveHeight! >= 0 &&
        conditions.waveHeight! <= 2) {
      safetyScore += 3;
    }
    // Add further scoring logic for other parameters...

    return safetyScore;
  }

  String _categorizeBeachSafety(double safetyScore) {
    if (safetyScore >= 20) {
      return 'SAFE';
    } else if (safetyScore >= 10) {
      return 'CAUTION';
    } else {
      return 'UNSAFE';
    }
  }

  Map<String, Map<String, double>> _getBeachData() {
    return {
      'Juhu Beach': {'lat': 19.1048, 'lng': 72.8267},
      'Versova Beach': {'lat': 19.1247, 'lng': 72.8170},
      'Marine Drive': {'lat': 18.9432, 'lng': 72.8230},
      'Aksa Beach': {'lat': 19.1651, 'lng': 72.7954},
      'Dadar Beach': {'lat': 19.0304, 'lng': 72.8377},
      'Madh Island  Beach': {'lat': 19.1330, 'lng': 72.7963},
      'Manori Beach': {'lat': 19.2107, 'lng': 72.7841},
    };
  }
}
