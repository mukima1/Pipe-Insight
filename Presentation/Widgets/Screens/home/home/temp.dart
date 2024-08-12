import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TemperatureGauge extends StatefulWidget {
  const TemperatureGauge({super.key});

  @override
  State<TemperatureGauge> createState() => _TemperatureGaugeState();
}

class _TemperatureGaugeState extends State<TemperatureGauge> {
  final DatabaseReference _pipelineDataRef = FirebaseDatabase.instance.ref('pipeline_data');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: StreamBuilder<DatabaseEvent>(
          stream: _pipelineDataRef.onValue,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Text("No data available");
            }

            final dataMap = snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;
            if (dataMap == null || dataMap.isEmpty) {
              return const Text("No data available");
            }

            final latestData = dataMap.entries.last.value as Map<dynamic, dynamic>;
            final temperature = latestData['temperature']?.toDouble() ?? 0.0;

            return Container(
              height: 170,
              width: 170,
              decoration: const BoxDecoration(
                color: Color.fromARGB(48, 138, 249, 3),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: SfLinearGauge(
                minimum: 61.0,
                maximum: 62.0,
                orientation: LinearGaugeOrientation.vertical,
                ranges: const [
                  LinearGaugeRange(
                    startValue: 61.0,
                    endValue: 61.3,
                    color: Colors.green,
                  ),
                  LinearGaugeRange(
                    startValue: 61.3,
                    endValue: 61.5,
                    color: Colors.orange,
                  ),
                  LinearGaugeRange(
                    startValue: 61.5,
                    endValue: 62.0,
                    color: Colors.red,
                  ),
                ],
                markerPointers: [
                  LinearShapePointer(value: temperature),
                ],
                barPointers: [
                  LinearBarPointer(value: temperature),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
