import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  File? _modelFile;
  final DatabaseReference _pipelineDataRef =
      FirebaseDatabase.instance.ref().child('new_pipeline_data');

  @override
  void initState() {
    super.initState();
    initNotifications();
    downloadModel(); // Changed from fetchAndLoadModel to downloadModel
    startListening();
  }

  Future<void> downloadModel() async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('models/autoencoder_model(1).tflite');
      final localFile = File('path/to/local/autoencoder_model.tflite');

      await storageRef.writeToFile(localFile);

      setState(() {
        _modelFile = localFile;
      });

      print('Model downloaded and loaded successfully.');
    } catch (e) {
      print('Failed to download or load model: $e');
    }
  }

  void startListening() {
    _pipelineDataRef.onValue.listen((event) async {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        final pipelineData = {
          'temperature': data['temperature'] ?? 0.0,
          'pressure': data['pressure'] ?? 0.0,
          'massFlowRate': data['massFlowRate'] ?? 0.0,
          'globalVolumeError': data['globalVolumeError'] ?? 0.0,
          'timestamp': data['timestamp'] ?? DateTime.now().millisecondsSinceEpoch,
        };
        await processPipelineData(pipelineData);
      }
    });
  }

  Future<void> processPipelineData(Map<String, dynamic> data) async {
    if (_modelFile == null) return;

    try {
      // ignore: unused_local_variable
      final inputData = [
        data['temperature'] as double,
        data['pressure'] as double,
        data['massFlowRate'] as double,
        data['globalVolumeError'] as double
      ];

      // ignore: unused_local_variable
      final interpreter = Interpreter.fromFile(_modelFile!);
      // Implement your own inference logic here
      // For example:
      // final results = runInference(interpreter, inputData);

      final results = [0.0, 0.0, 0.0, 0.0]; // Replace with actual inference results

      print('Model output: $results');

      const threshold = 0.01;
      final notifications = <String>[];

      if (results[0] > threshold) notifications.add('Temperature anomaly detected.');
      if (results[1] > threshold) notifications.add('Pressure anomaly detected.');
      if (results[2] > threshold) notifications.add('Mass flow rate anomaly detected.');
      if (results[3] > threshold) notifications.add('Global volume error detected.');

      if (notifications.isEmpty) {
        notifications.add('No anomalies detected.');
      } else if (notifications.length == 4) {
        notifications.add('All parameters are anomalous. Immediate action needed!');
      }

      for (final notification in notifications) {
        showNotification(notification, data['timestamp'] as int);
      }
    } catch (e) {
      print('Failed to run inference: $e');
    }
  }

  void initNotifications() {
    const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(String message, int timestamp) async {
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        importance: Importance.high,
        priority: Priority.high,
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Anomaly Detected',
      '$message at ${DateTime.fromMillisecondsSinceEpoch(timestamp).toLocal()}',
      notificationDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anomaly Detection Notifications'),
      ),
      body: const Center(
        child: Text(
          'Listening for anomalies...',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
