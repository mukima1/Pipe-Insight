import 'package:flutter/material.dart';
import 'package:pipeinsight/Presentation/Widgets/Screens/home/home/groal.dart';
import 'package:pipeinsight/Presentation/Widgets/Screens/home/home/information/danger.dart';
import 'package:pipeinsight/Presentation/Widgets/Screens/home/home/information/normal.dart';
import 'package:pipeinsight/Presentation/Widgets/Screens/home/home/information/pressure_w.dart';
import 'package:pipeinsight/Presentation/Widgets/Screens/home/home/information/warning.dart';
import 'package:pipeinsight/Presentation/Widgets/Screens/home/home/mass_flow.dart';
import 'package:pipeinsight/Presentation/Widgets/Screens/home/home/pressure.dart';
import 'package:pipeinsight/Presentation/Widgets/Screens/home/home/temp.dart';
import 'package:pipeinsight/Presentation/Widgets/drawer/drawer_screens/Sensor_data/sensor.dart';
import 'package:pipeinsight/Presentation/Widgets/drawer/main_drawer.dart';
// Assuming you have this screen defined

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Dash Board',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 234, 234, 240),
      ),
      drawer: const drawer(), // Ensure MainDrawer is correctly defined
      body: Container(
        color: Colors.blueAccent,
        child: ListView(
          children: [
            const Row(
              children: [
                Expanded(child: TemperatureGauge()),
                Expanded(child: MassFlow()),
              ],
            ),
            const Row(
              children: [
                Expanded(child: Global()),
                Expanded(child: PressureGauge()),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {
                  // Update the state of the app
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DataSensorScreen()),
                  );
                },
                child: const Text(
                  'More information...',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            const normal(),
            const Danger(),
            const pressure_w(),
            const temp_w(),
          ],
        ),
      ),
    );
  }
}
