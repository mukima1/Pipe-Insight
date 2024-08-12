import 'dart:async';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';

void startSendingData() {
  final databaseReference = FirebaseDatabase.instance.ref().child('new_pipeline_data');
  final random = Random(); // Instantiate Random once

  double getRandomValue(double min, double max) {
    return min + (max - min) * random.nextDouble();
  }

  Timer.periodic(const Duration(seconds: 4), (timer) async {
    double pressure = getRandomValue(50.164719, 61.476921);
    double temperature = getRandomValue(60.668968, 62.0);
    double massFlowRate = getRandomValue(5.768561, 20.121691);
    double globalVolumeError = getRandomValue(0.0, 0.000849065);

    try {
      await databaseReference.set({
        'pressure': pressure,
        'temperature': temperature,
        'massFlowRate': massFlowRate,
        'globalVolumeError': globalVolumeError,
        'timestamp': ServerValue.timestamp,
      });
      print('Data added successfully to Realtime Database');
    } catch (e) {
      print('Failed to add data: $e');
    }
  });
}
