import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  int _refreshInterval = 5;
  bool _dataCollectionEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Account Settings'),
            leading: const Icon(Icons.person),
            onTap: () {
              // Navigate to Account Settings screen
            },
          ),
          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
            secondary: const Icon(Icons.notifications_active),
          ),
          ListTile(
            title: const Text('Data Refresh Interval'),
            subtitle: Text('$_refreshInterval seconds'),
            leading: const Icon(Icons.timer),
            onTap: () {
              _showRefreshIntervalDialog();
            },
          ),
          SwitchListTile(
            title: const Text('Enable Data Collection'),
            value: _dataCollectionEnabled,
            onChanged: (bool value) {
              setState(() {
                _dataCollectionEnabled = value;
              });
            },
            secondary: const Icon(Icons.data_usage),
          ),
          ListTile(
            title: const Text('Help and Support'),
            leading: const Icon(Icons.help),
            onTap: () {
              // Navigate to Help and Support screen
            },
          ),
          ListTile(
            title: const Text('About'),
            leading: const Icon(Icons.info),
            onTap: () {
              // Navigate to About screen
            },
          ),
        ],
      ),
    );
  }

  void _showRefreshIntervalDialog() {
    showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Set Refresh Interval'),
          content: DropdownButton<int>(
            value: _refreshInterval,
            items: [1, 5, 10, 30, 60]
                .map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text('$value seconds'),
              );
            }).toList(),
            onChanged: (int? newValue) {
              if (newValue != null) {
                setState(() {
                  _refreshInterval = newValue;
                });
                Navigator.of(context).pop();
              }
            },
          ),
        );
      },
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SettingsScreen(),
  ));
}
