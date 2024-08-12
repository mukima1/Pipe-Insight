import 'package:flutter/material.dart';

// ignore: camel_case_types
class temp_w extends StatelessWidget {
  const temp_w({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        color: const Color.fromARGB(57, 215, 220, 216),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: IntrinsicHeight(
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align content to the start
                children: [
                  Text(
                    'Warning: High Pressure. The pressure levels in the pipeline have exceeded the safe limit. Immediate action is required to avoid potential hazards.',
                    style: TextStyle(
                      fontFamily: AutofillHints.countryCode,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 20), // Add some space between the text and the row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start, // Align the row content to the start
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: Color.fromARGB(255, 244, 3, 3), // Brighter red color
                      ),
                      SizedBox(width: 10), // Add space between the circles
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: Color.fromARGB(255, 72, 255, 0),
                      ),
                      SizedBox(width: 10), // Add space between the circles
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Color.fromARGB(255, 217, 255, 0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
