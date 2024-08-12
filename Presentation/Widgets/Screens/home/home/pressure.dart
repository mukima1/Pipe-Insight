import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PressureGauge extends StatefulWidget {
  const PressureGauge({super.key});

  @override
  State<PressureGauge> createState() => _PressureGaugeState();
}

class _PressureGaugeState extends State<PressureGauge> {
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
            final pressure = latestData['pressure']?.toDouble() ?? 0.0;

            return Container(
              height: 170,
              width: 170,
              decoration: const BoxDecoration(
                color: Color.fromARGB(48, 138, 249, 3),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 150,
                        ranges: <GaugeRange>[
                          GaugeRange(startValue: 0, endValue: 50, color: Colors.green),
                          GaugeRange(startValue: 50, endValue: 100, color: Colors.orange),
                          GaugeRange(startValue: 100, endValue: 150, color: Colors.red),
                        ],
                        pointers: <GaugePointer>[
                          NeedlePointer(value: pressure),
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                            widget: Column(
                              children: [
                                Text(
                                  pressure.toStringAsFixed(1),
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                const Text('Bara')
                              ],
                            ),
                            angle: 90,
                            positionFactor: 1.5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
