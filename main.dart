import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pipeinsight/Presentation/Widgets/Screens/graphs/graphs.dart';
import 'package:pipeinsight/Presentation/Widgets/Screens/home/home.dart';
import 'package:pipeinsight/Presentation/Widgets/Screens/notifications/notifications.dart';

import 'package:pipeinsight/dataSource/generateData.dart';
import 'package:pipeinsight/firebase_options.dart';
import 'package:pipeinsight/presentation/widgets/screens/compare/compare.dart';
 // Import the data sender file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _page = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    NotificationScreen(),
    const GraphScreen(),
    const DataDisplayScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Start sending data to Firebase Realtime Database every 4 seconds
    startSendingData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.blueAccent,
          animationDuration: const Duration(milliseconds: 300),
          items: const <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.notifications, size: 30),
            Icon(Icons.auto_graph_sharp, size: 30),
            Icon(Icons.compare, size: 30),
          ],
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        body: _screens[_page],
      ),
    );
  }
}
