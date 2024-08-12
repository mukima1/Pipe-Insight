import 'package:flutter/material.dart';
import 'package:pipeinsight/Presentation/Widgets/drawer/drawer_screens/Sensor_data/sensor.dart';
import 'package:pipeinsight/Presentation/Widgets/drawer/drawer_screens/Settings/settings.dart';
import 'package:pipeinsight/Presentation/Widgets/drawer/drawer_screens/alerts/alert.dart';
import 'package:pipeinsight/Presentation/Widgets/drawer/drawer_screens/model_perfomance/model.dart';
import 'package:pipeinsight/Presentation/Widgets/drawer/drawer_screens/pipeline/pipeline.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';


// ignore: camel_case_types
class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pipe Insight',
                  style: TextStyle(
                    color: Color.fromARGB(255, 207, 205, 205),
                    fontSize: 35,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.start,
                ),
               Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/Img.png'),
                    radius: 30,
                  ),
                  SizedBox(width: 6,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Predictive Mantinance for;',
                      style: TextStyle(
                        fontWeight: FontWeight.w900
                      ),),
                      
                      Text('Maintinance Engineers',
                      style: TextStyle(
                        fontSize: 12
                      ),),
                      Text('Pipe Engineers in Tilenga',
                      style: TextStyle(
                        fontSize: 12
                      ),),
                     
                    ],
                  )
                ],
               )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.sensors),
            title: const Text('Sensor Data'),
            onTap: () {
              // Update the state of the app
            Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const DataSensorScreen()),
);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const SettingsScreen()),
);
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_alert),
            title: const Text('Alerts'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const AlertScreen()),
);
            },
          ),
          ListTile(
            leading: const Icon(Icons.memory),
            title: const Text('Model Performance'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const ModelPerformanceScreen()),
);
            },
          ),
          ListTile(
            leading: const Icon(Icons.plumbing),
            title: const Text('Pipeline'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
                   Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const PipelineScreen()),
);
            },
          ),
         ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('FeedBack'),
            onTap: () async {
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'ashirafssenkima@yahoo.com',
                query: 'subject=Feedback&body=Hello, I would like to provide some feedback...',
              );
              // ignore: deprecated_member_use
              if (await canLaunch(emailLaunchUri.toString())) {
                // ignore: deprecated_member_use
                await launch(emailLaunchUri.toString());
              } else {
                throw 'Could not launch $emailLaunchUri';
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text('Logout'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Exit App'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              _showExitDialog(context);
            },
          ),
        ],
      ),
    );
  }
}

void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit Application'),
          content: const Text('Are you sure you want to exit the application?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                exit(0); // Close the app
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
