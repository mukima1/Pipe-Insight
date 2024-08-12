import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:table_calendar/table_calendar.dart';
import 'package:pipeinsight/dataSource/pipeline.dart'; // Import the new_pipeline_data class

class DataDisplayScreen extends StatefulWidget {
  const DataDisplayScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DataDisplayScreenState createState() => _DataDisplayScreenState();
}

class _DataDisplayScreenState extends State<DataDisplayScreen> {
  final databaseReference = FirebaseDatabase.instance.ref('new_pipeline_data');
  List<new_pipeline_data> dataList = [];
  Set<int> timestampsSet = {};
  DateTimeRange? selectedDateRange;

  @override
  void initState() {
    super.initState();
    _startFetchingData();
  }

  void _startFetchingData() {
    databaseReference.onValue.listen((event) {
      final dataSnapshot = event.snapshot.value as Map<dynamic, dynamic>;
      final newData = new_pipeline_data.fromJson(dataSnapshot);
      setState(() {
        if (!timestampsSet.contains(newData.timestamp)) {
          dataList.insert(0, newData); // Insert new data at the beginning
          timestampsSet.add(newData.timestamp);
        }
      });
    });
  }

  void _clearData() {
    setState(() {
      dataList.clear();
      timestampsSet.clear();
    });
  }

  void _exportToCSV() async {
    List<List<dynamic>> rows = [];
    rows.add(["Global Volume Error", "Mass Flow Rate", "Pressure", "Temperature", "Timestamp"]);
    for (var data in dataList) {
      if (selectedDateRange == null ||
          (data.timestamp >= selectedDateRange!.start.millisecondsSinceEpoch &&
              data.timestamp <= selectedDateRange!.end.millisecondsSinceEpoch)) {
        rows.add([
          data.globalVolumeError,
          data.massFlowRate,
          data.pressure,
          data.temperature,
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(data.timestamp))
        ]);
      }
    }

    String csv = const ListToCsvConverter().convert(rows);
    final String directory = (await getApplicationDocumentsDirectory()).path;
    final path = "$directory/data.csv";

    final File file = File(path);
    await file.writeAsString(csv);

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("CSV file saved at $path")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pipeline Data"),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _exportToCSV,
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _clearData,
          ),
        ],
      ),
      body: Container(
        color: Colors.blueAccent, // Set a nice background color here
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              onRangeSelected: (start, end, focusedDay) {
                setState(() {
                  selectedDateRange = DateTimeRange(start: start!, end: end!);
                });
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Timestamp')),
                      DataColumn(label: Text('Global Volume Error')),
                      DataColumn(label: Text('Mass Flow Rate')),
                      DataColumn(label: Text('Pressure')),
                      DataColumn(label: Text('Temperature')),
                    ],
                    rows: dataList.map((data) {
                      return DataRow(cells: [
                        DataCell(Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(data.timestamp)))),
                        DataCell(Text(data.globalVolumeError.toString())),
                        DataCell(Text(data.massFlowRate.toString())),
                        DataCell(Text(data.pressure.toString())),
                        DataCell(Text(data.temperature.toString())),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
