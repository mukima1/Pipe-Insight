// ignore: file_names
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RealTimeChartScreen extends StatefulWidget {
  const RealTimeChartScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RealTimeChartScreenState createState() => _RealTimeChartScreenState();
}

class _RealTimeChartScreenState extends State<RealTimeChartScreen> {
  List<_ChartData> pressureData = [];
  List<_ChartData> temperatureData = [];
  List<_ChartData> volumeErrorData = [];
  List<_ChartData> massFlowRateData = [];
  late ChartSeriesController _pressureController;
  late ChartSeriesController _temperatureController;
  late ChartSeriesController _volumeErrorController;
  late ChartSeriesController _massFlowRateController;

  @override
  void initState() {
    super.initState();
    _initializeFirebaseStream();
  }

  void _initializeFirebaseStream() {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('new_pipeline_data');
    ref.onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      final timestamp = DateTime.now();

      setState(() {
        if (pressureData.length > 20) pressureData.removeAt(0);
        if (temperatureData.length > 20) temperatureData.removeAt(0);
        if (volumeErrorData.length > 20) volumeErrorData.removeAt(0);
        if (massFlowRateData.length > 20) massFlowRateData.removeAt(0);

        pressureData.add(_ChartData(timestamp, data['pressure'].toDouble()));
        temperatureData.add(_ChartData(timestamp, data['temperature'].toDouble()));
        volumeErrorData.add(_ChartData(timestamp, data['globalVolumeError'].toDouble()));
        massFlowRateData.add(_ChartData(timestamp, data['massFlowRate'].toDouble()));

        _pressureController.updateDataSource(addedDataIndex: pressureData.length - 1, removedDataIndex: 0);
        _temperatureController.updateDataSource(addedDataIndex: temperatureData.length - 1, removedDataIndex: 0);
        _volumeErrorController.updateDataSource(addedDataIndex: volumeErrorData.length - 1, removedDataIndex: 0);
        _massFlowRateController.updateDataSource(addedDataIndex: massFlowRateData.length - 1, removedDataIndex: 0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildChartContainer(pressureData, Colors.blue, 'Pressure', (ChartSeriesController controller) {
          _pressureController = controller;
        }),
        _buildChartContainer(temperatureData, Colors.red, 'Temperature', (ChartSeriesController controller) {
          _temperatureController = controller;
        }),
        _buildChartContainer(volumeErrorData, Colors.green, 'Global Volume Error', (ChartSeriesController controller) {
          _volumeErrorController = controller;
        }),
        _buildChartContainer(massFlowRateData, Colors.orange, 'Mass Flow Rate', (ChartSeriesController controller) {
          _massFlowRateController = controller;
        }),
      ],
    );
  }

  Widget _buildChartContainer(List<_ChartData> data, Color color, String title, Function(ChartSeriesController) onRendererCreated) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(216, 255, 255, 255),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(85, 158, 158, 158).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: SfCartesianChart(
                primaryXAxis: DateTimeAxis(),
                primaryYAxis: NumericAxis(
                  majorGridLines: const MajorGridLines(width: 0),
                ),
                series: <LineSeries<_ChartData, DateTime>>[
                  LineSeries<_ChartData, DateTime>(
                    onRendererCreated: onRendererCreated,
                    dataSource: data,
                    xValueMapper: (_ChartData data, _) => data.time,
                    yValueMapper: (_ChartData data, _) => data.value,
                    color: color,
                  )
                ],
                zoomPanBehavior: ZoomPanBehavior(
                  enablePinching: true,
                  enablePanning: true,
                  enableDoubleTapZooming: true,
                  enableSelectionZooming: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.time, this.value);
  final DateTime time;
  final double value;
}
