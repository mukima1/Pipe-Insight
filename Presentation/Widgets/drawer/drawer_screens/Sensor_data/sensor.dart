import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Sensors',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DataSensorScreen(),
    );
  }
}

class DataSensorScreen extends StatefulWidget {
  const DataSensorScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DataSensorScreenState createState() => _DataSensorScreenState();
}

class _DataSensorScreenState extends State<DataSensorScreen> {
  final DatabaseReference _pipelineDataRef = FirebaseDatabase.instance.ref().child('new_pipeline_data');
  late Stream<DatabaseEvent> _pipelineDataStream;

  String temperatureReading = 'Loading...';
  String pressureReading = 'Loading...';
  String flowRateReading = 'Loading...';
  String globalVolumeErrorReading = 'Loading...';

  String temperatureHistorical = 'Loading...';
  String pressureHistorical = 'Loading...';
  String flowRateHistorical = 'Loading...';
  String globalVolumeErrorHistorical = 'Loading...';

  double temperatureMin = double.infinity;
  double temperatureMax = double.negativeInfinity;
  double pressureMin = double.infinity;
  double pressureMax = double.negativeInfinity;
  double flowRateMin = double.infinity;
  double flowRateMax = double.negativeInfinity;
  double globalVolumeErrorMin = double.infinity;
  double globalVolumeErrorMax = double.negativeInfinity;

  @override
  void initState() {
    super.initState();
    _pipelineDataStream = _pipelineDataRef.onValue;
    _pipelineDataStream.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map<dynamic, dynamic>);
      setState(() {
        updateReadings(data);
      });
    });
  }

  void updateReadings(Map<String, dynamic> data) {
    final double temperature = data['temperature'];
    final double pressure = data['pressure'];
    final double flowRate = data['massFlowRate'];
    final double globalVolumeError = data['globalVolumeError'];

    // Update current readings
    temperatureReading = '$temperature°C';
    pressureReading = '$pressure Bara';
    flowRateReading = '$flowRate kg/s';
    globalVolumeErrorReading = '$globalVolumeError';

    // Update historical data
    if (temperature < temperatureMin) temperatureMin = temperature;
    if (temperature > temperatureMax) temperatureMax = temperature;
    temperatureHistorical = 'Max: $temperatureMax°C, Min: $temperatureMin°C';

    if (pressure < pressureMin) pressureMin = pressure;
    if (pressure > pressureMax) pressureMax = pressure;
    pressureHistorical = 'Max: $pressureMax Bara, Min: $pressureMin Bara';

    if (flowRate < flowRateMin) flowRateMin = flowRate;
    if (flowRate > flowRateMax) flowRateMax = flowRate;
    flowRateHistorical = 'Max: $flowRateMax kg/s, Min: $flowRateMin kg/s';

    if (globalVolumeError < globalVolumeErrorMin) globalVolumeErrorMin = globalVolumeError;
    if (globalVolumeError > globalVolumeErrorMax) globalVolumeErrorMax = globalVolumeError;
    globalVolumeErrorHistorical = 'Max: $globalVolumeErrorMax, Min: $globalVolumeErrorMin';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Sensors'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SensorCard(
              sensorName: 'Temperature Sensor',
              sensorType: 'Thermocouple',
              sensorLocation: 'Pipeline Section 1',
              currentReading: temperatureReading,
              status: temperatureReading == 'Loading...' ? 'Inactive' : 'Active',
              historicalData: temperatureHistorical,
              connectionQuality: temperatureReading == 'Loading...' ? 'Poor' : 'Good',
            ),
            SensorCard(
              sensorName: 'Pressure Sensor',
              sensorType: 'Piezoelectric',
              sensorLocation: 'Pipeline Section 1',
              currentReading: pressureReading,
              status: pressureReading == 'Loading...' ? 'Inactive' : 'Active',
              historicalData: pressureHistorical,
              connectionQuality: pressureReading == 'Loading...' ? 'Poor' : 'Good',
            ),
            SensorCard(
              sensorName: 'Flow Rate Sensor',
              sensorType: 'Ultrasonic',
              sensorLocation: 'Pipeline Section 1',
              currentReading: flowRateReading,
              status: flowRateReading == 'Loading...' ? 'Inactive' : 'Active',
              historicalData: flowRateHistorical,
              connectionQuality: flowRateReading == 'Loading...' ? 'Poor' : 'Good',
            ),
            SensorCard(
              sensorName: 'Global Volume Error Sensor',
              sensorType: 'Calculation-based',
              sensorLocation: 'Pipeline Section 1',
              currentReading: globalVolumeErrorReading,
              status: globalVolumeErrorReading == 'Loading...' ? 'Inactive' : 'Active',
              historicalData: globalVolumeErrorHistorical,
              connectionQuality: globalVolumeErrorReading == 'Loading...' ? 'Poor' : 'Good',
            ),
          ],
        ),
      ),
    );
  }
}

class SensorCard extends StatelessWidget {
  final String sensorName;
  final String sensorType;
  final String sensorLocation;
  final String currentReading;
  final String status;
  final String historicalData;
  final String connectionQuality;

  const SensorCard({
    Key? key,
    required this.sensorName,
    required this.sensorType,
    required this.sensorLocation,
    required this.currentReading,
    required this.status,
    required this.historicalData,
    required this.connectionQuality,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sensorName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Type: $sensorType'),
            Text('Location: $sensorLocation'),
            Text('Current Reading: $currentReading'),
            Text('Status: $status'),
            Text('Historical Data: $historicalData'),
            Text('Connection Quality: $connectionQuality'),
          ],
        ),
      ),
    );
  }
}
