import 'package:flutter/material.dart';

class ModelPerformanceScreen extends StatelessWidget {
  const ModelPerformanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Model Performance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const PerformanceMetric(
              metricName: 'Accuracy',
              metricValue: '95%',
            ),
            const PerformanceMetric(
              metricName: 'Precision',
              metricValue: '94%',
            ),
            const PerformanceMetric(
              metricName: 'Recall',
              metricValue: '93%',
            ),
            const PerformanceMetric(
              metricName: 'F1 Score',
              metricValue: '93.5%',
            ),
            const PerformanceMetric(
              metricName: 'Mean Absolute Error (MAE)',
              metricValue: '0.05',
            ),
            const PerformanceMetric(
              metricName: 'Mean Squared Error (MSE)',
              metricValue: '0.01',
            ),
            const PerformanceMetric(
              metricName: 'Training Time',
              metricValue: '2 hours',
            ),
            const SizedBox(height: 20),
            const Text(
              'Confusion Matrix',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('Predicted: 0')),
                  DataColumn(label: Text('Predicted: 1')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('Actual: 0')),
                    DataCell(Text('50')),
                    DataCell(Text('10')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Actual: 1')),
                    DataCell(Text('5')),
                    DataCell(Text('35')),
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Model Parameters',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const ListTile(
              title: Text('Parameter 1: Value'),
            ),
            const ListTile(
              title: Text('Parameter 2: Value'),
            ),
            const ListTile(
              title: Text('Parameter 3: Value'),
            ),
            // Add more parameters as needed
          ],
        ),
      ),
    );
  }
}

class PerformanceMetric extends StatelessWidget {
  final String metricName;
  final String metricValue;

  const PerformanceMetric({
    Key? key,
    required this.metricName,
    required this.metricValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(metricName),
      trailing: Text(metricValue),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ModelPerformanceScreen(),
  ));
}
