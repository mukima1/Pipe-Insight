import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Global extends StatefulWidget {
  const Global({super.key});

  @override
  State<Global> createState() => _GlobalState();
}

class _GlobalState extends State<Global> {
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

            // Assuming data is a list and you want to display the latest entry
            final latestData = dataMap.entries.last.value as Map<dynamic, dynamic>;
            final globalVolumeError = latestData['globalVolumeError']?.toDouble() ?? 0.0;

            return Container(
              height: 170,
              width: 170,
              decoration: const BoxDecoration(
                color: Color.fromARGB(48, 138, 249, 3),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      globalVolumeError.toStringAsFixed(5),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'GrbVol error',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
