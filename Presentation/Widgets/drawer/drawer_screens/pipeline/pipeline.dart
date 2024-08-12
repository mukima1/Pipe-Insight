import 'package:flutter/material.dart';

class PipelineScreen extends StatelessWidget {
  const PipelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pipeline Overview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              'Pipeline Overview',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            PipelineInfoCard(
              title: 'Length',
              value: '1500 km',
            ),
            PipelineInfoCard(
              title: 'Material',
              value: 'Steel',
            ),
            PipelineInfoCard(
              title: 'Sections',
              value: '10',
            ),
            SizedBox(height: 16),
            Text(
              'Current Status',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            PipelineStatusCard(
              section: 'Section 1',
              status: 'Operational',
              issues: 'None',
            ),
            PipelineStatusCard(
              section: 'Section 2',
              status: 'Maintenance Required',
              issues: 'Leak detected',
            ),
            SizedBox(height: 16),
            Text(
              'Recent Maintenance Logs',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            MaintenanceLogCard(
              date: '2023-06-01',
              type: 'Routine Inspection',
              notes: 'No issues detected',
            ),
            MaintenanceLogCard(
              date: '2023-05-20',
              type: 'Leak Repair',
              notes: 'Leak fixed in Section 2',
            ),
            SizedBox(height: 16),
            Text(
              'Operational Statistics',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            OperationalStatisticsCard(
              section: 'Section 1',
              flowRate: '500 kg/s',
              pressure: '100 kPa',
              temperature: '25°C',
            ),
            OperationalStatisticsCard(
              section: 'Section 2',
              flowRate: '480 kg/s',
              pressure: '95 kPa',
              temperature: '26°C',
            ),
            SizedBox(height: 16),
            Text(
              'Alerts and Notifications',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            AlertNotificationCard(
              alert: 'High pressure detected in Section 3',
              date: '2023-06-03',
            ),
            AlertNotificationCard(
              alert: 'Routine maintenance due in Section 4',
              date: '2023-06-05',
            ),
          ],
        ),
      ),
    );
  }
}

class PipelineInfoCard extends StatelessWidget {
  final String title;
  final String value;

  const PipelineInfoCard({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}

class PipelineStatusCard extends StatelessWidget {
  final String section;
  final String status;
  final String issues;

  const PipelineStatusCard({
    Key? key,
    required this.section,
    required this.status,
    required this.issues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(section),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: $status'),
            Text('Issues: $issues'),
          ],
        ),
      ),
    );
  }
}

class MaintenanceLogCard extends StatelessWidget {
  final String date;
  final String type;
  final String notes;

  const MaintenanceLogCard({
    Key? key,
    required this.date,
    required this.type,
    required this.notes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(date),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: $type'),
            Text('Notes: $notes'),
          ],
        ),
      ),
    );
  }
}

class OperationalStatisticsCard extends StatelessWidget {
  final String section;
  final String flowRate;
  final String pressure;
  final String temperature;

  const OperationalStatisticsCard({
    Key? key,
    required this.section,
    required this.flowRate,
    required this.pressure,
    required this.temperature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(section),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Flow Rate: $flowRate'),
            Text('Pressure: $pressure'),
            Text('Temperature: $temperature'),
          ],
        ),
      ),
    );
  }
}

class AlertNotificationCard extends StatelessWidget {
  final String alert;
  final String date;

  const AlertNotificationCard({
    Key? key,
    required this.alert,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(alert),
        subtitle: Text(date),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: PipelineScreen(),
  ));
}
