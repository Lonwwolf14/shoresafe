class BeachConditions {
  final double? waveHeight;
  final double? swellSurge;
  final double? oceanCurrent;
  final double? stormSurge;
  final double? waterCurrent;
  final double? turbidity;
  final double? waterTemperature;
  final double? hydrocarbon;
  final double? chlorophyllA;

  BeachConditions({
    this.waveHeight,
    this.swellSurge,
    this.oceanCurrent,
    this.stormSurge,
    this.waterCurrent,
    this.turbidity,
    this.waterTemperature,
    this.hydrocarbon,
    this.chlorophyllA,
  });

  factory BeachConditions.fromJson(Map<String, dynamic> json) {
    return BeachConditions(
      waveHeight: json['waveHeight'],
      swellSurge: json['swellSurge'],
      oceanCurrent: json['oceanCurrent'],
      stormSurge: json['stormSurge'],
      waterCurrent: json['waterCurrent'],
      turbidity: json['turbidity'],
      waterTemperature: json['waterTemperature'],
      hydrocarbon: json['hydrocarbon'],
      chlorophyllA: json['chlorophyllA'],
    );
  }
}

class BeachSafetyData {
  final String beachName;
  final String safetyCategory;
  final double safetyScore;
  final BeachConditions conditions;
  final String timestamp;

  BeachSafetyData({
    required this.beachName,
    required this.safetyCategory,
    required this.safetyScore,
    required this.conditions,
    required this.timestamp,
  });
}
