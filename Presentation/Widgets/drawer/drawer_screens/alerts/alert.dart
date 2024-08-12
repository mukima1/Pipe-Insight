import 'package:flutter/material.dart';

// Mock data for alerts
final List<Map<String, String>> alerts = [
  {
    'title': 'High Temperature Warning',
    'message': 'The temperature has exceeded the threshold.',
    'type': 'warning',
  },
  {
    'title': 'Pressure Drop Detected',
    'message': 'There is a significant drop in pressure in the pipeline.',
    'type': 'error',
  },
  // Add more alerts as needed
];

class AlertScreen extends StatefulWidget {
  const AlertScreen({Key? key}) : super(key: key);

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alert Screen'),
      ),
      body: ListView.builder(
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          final alert = alerts[index];
          return ListTile(
            leading: Icon(
              alert['type'] == 'error'
                  ? Icons.error
                  : Icons.warning,
              color: alert['type'] == 'error' ? Colors.red : Colors.orange,
            ),
            title: Text(alert['title']!),
            subtitle: Text(alert['message']!),
            onTap: () {
              _showAlertDetails(context, alert);
            },
          );
        },
      ),
    );
  }

  void _showAlertDetails(BuildContext context, Map<String, String> alert) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(alert['title']!),
          content: Text(alert['message']!),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Dismiss'),
            ),
            TextButton(
              onPressed: () {
                // Handle the snooze action
                Navigator.of(context).pop();
              },
              child: const Text('Snooze'),
            ),
            TextButton(
              onPressed: () {
                // Handle the acknowledge action
                Navigator.of(context).pop();
              },
              child: const Text('Acknowledge'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AlertScreen(),
  ));
}
