// ignore: camel_case_types
class new_pipeline_data {
  final double globalVolumeError;
  final double massFlowRate;
  final double pressure;
  final double temperature;
  final int timestamp;

  new_pipeline_data({
    required this.globalVolumeError,
    required this.massFlowRate,
    required this.pressure,
    required this.temperature,
    required this.timestamp,
  });

  factory new_pipeline_data.fromJson(Map<dynamic, dynamic> json) {
    return new_pipeline_data(
      globalVolumeError: json['globalVolumeError'],
      massFlowRate: json['massFlowRate'],
      pressure: json['pressure'],
      temperature: json['temperature'],
      timestamp: json['timestamp'],
    );
  }
}
