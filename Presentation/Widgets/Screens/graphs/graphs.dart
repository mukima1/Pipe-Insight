import 'package:flutter/material.dart';
import 'package:pipeinsight/Presentation/Widgets/Screens/graphs/graphs/myCharts.dart';
import 'package:pipeinsight/Presentation/Widgets/drawer/main_drawer.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Charts and Graphs',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 233, 233, 238),
      ),
      drawer: const drawer(), // Changed from 'drawer' to 'MainDrawer'
      body: SingleChildScrollView( // Ensure scrolling if content exceeds screen
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.blueAccent,  
          child: const RealTimeChartScreen(),    
          ),
        ),
      
    );
  }
}
