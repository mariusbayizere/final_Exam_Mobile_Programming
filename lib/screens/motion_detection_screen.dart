// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import '../accelerometer_data.dart';

// class MotionDetectionScreen extends StatefulWidget {
//   @override
//   _MotionDetectionScreenState createState() => _MotionDetectionScreenState();
// }

// class _MotionDetectionScreenState extends State<MotionDetectionScreen> {
//   List<AccelerometerData> _data = [];
//   late ChartSeriesController _chartSeriesController;
//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//   @override
//   void initState() {
//     super.initState();

//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     const initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     const initializationSettingsIOS = DarwinInitializationSettings();
//     const initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);

//     accelerometerEvents.listen((AccelerometerEvent event) {
//       setState(() {
//         _data.add(AccelerometerData(DateTime.now(), event.x, event.y, event.z));
//         if (_data.length > 20) {
//           _data.removeAt(0);
//         }
//         _chartSeriesController.updateDataSource(
//           addedDataIndexes: [_data.length - 1],
//           removedDataIndexes: [0],
//         );

//         // Check for significant motion
//         if (event.x.abs() > 10 || event.y.abs() > 10 || event.z.abs() > 10) {
//           _showNotification();
//         }
//       });
//     });
//   }

//   Future<void> _showNotification() async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'motion_channel',
//       'Motion Detection',
//       channelDescription: 'Channel for motion detection notifications',
//       importance: Importance.high,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );
//     const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Motion Detected',
//       'Significant motion detected!',
//       platformChannelSpecifics,
//       payload: 'Motion detected payload',
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Motion Detection'),
//       ),
//       body: SfCartesianChart(
//         primaryXAxis: DateTimeAxis(),
//         series: <LineSeries<AccelerometerData, DateTime>>[
//           LineSeries<AccelerometerData, DateTime>(
//             onRendererCreated: (ChartSeriesController controller) {
//               _chartSeriesController = controller;
//             },
//             dataSource: _data,
//             xValueMapper: (AccelerometerData data, _) => data.time,
//             yValueMapper: (AccelerometerData data, _) => data.x,
//             name: 'X-Axis',
//           ),
//           LineSeries<AccelerometerData, DateTime>(
//             dataSource: _data,
//             xValueMapper: (AccelerometerData data, _) => data.time,
//             yValueMapper: (AccelerometerData data, _) => data.y,
//             name: 'Y-Axis',
//           ),
//           LineSeries<AccelerometerData, DateTime>(
//             dataSource: _data,
//             xValueMapper: (AccelerometerData data, _) => data.time,
//             yValueMapper: (AccelerometerData data, _) => data.z,
//             name: 'Z-Axis',
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import '../accelerometer_data.dart';

// class MotionDetectionScreen extends StatefulWidget {
//   @override
//   _MotionDetectionScreenState createState() => _MotionDetectionScreenState();
// }

// class _MotionDetectionScreenState extends State<MotionDetectionScreen> {
//   List<AccelerometerData> _data = [];
//   late ChartSeriesController _chartSeriesController;
//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//   int motionCounter = 0;

//   @override
//   void initState() {
//     super.initState();

//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     const initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     const initializationSettingsIOS = DarwinInitializationSettings();
//     const initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);

//     accelerometerEvents.listen((AccelerometerEvent event) {
//       setState(() {
//         _data.add(AccelerometerData(DateTime.now(), event.x, event.y, event.z));
//         if (_data.length > 20) {
//           _data.removeAt(0);
//         }
//         _chartSeriesController.updateDataSource(
//           addedDataIndexes: [_data.length - 1],
//           removedDataIndexes: [0],
//         );

//         // Check for significant motion
//         if (event.x.abs() > 10 || event.y.abs() > 10 || event.z.abs() > 10) {
//           motionCounter++;
//           _showNotification();
//         }
//       });
//     });
//   }

//   Future<void> _showNotification() async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'motion_channel',
//       'Motion Detection',
//       channelDescription: 'Channel for motion detection notifications',
//       importance: Importance.high,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );
//     const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Motion Detected',
//       'Significant motion detected!',
//       platformChannelSpecifics,
//       payload: 'Motion detected payload',
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Motion Detection'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     padding: EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.blueAccent,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       children: [
//                         Text(
//                           'Motion Detected',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           '$motionCounter times',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: SfCartesianChart(
//                 primaryXAxis: DateTimeAxis(),
//                 series: <LineSeries<AccelerometerData, DateTime>>[
//                   LineSeries<AccelerometerData, DateTime>(
//                     onRendererCreated: (ChartSeriesController controller) {
//                       _chartSeriesController = controller;
//                     },
//                     dataSource: _data,
//                     xValueMapper: (AccelerometerData data, _) => data.time,
//                     yValueMapper: (AccelerometerData data, _) => data.x,
//                     name: 'X-Axis',
//                   ),
//                   LineSeries<AccelerometerData, DateTime>(
//                     dataSource: _data,
//                     xValueMapper: (AccelerometerData data, _) => data.time,
//                     yValueMapper: (AccelerometerData data, _) => data.y,
//                     name: 'Y-Axis',
//                   ),
//                   LineSeries<AccelerometerData, DateTime>(
//                     dataSource: _data,
//                     xValueMapper: (AccelerometerData data, _) => data.time,
//                     yValueMapper: (AccelerometerData data, _) => data.z,
//                     name: 'Z-Axis',
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//  new one version

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../accelerometer_data.dart';

class MotionDetectionScreen extends StatefulWidget {
  @override
  _MotionDetectionScreenState createState() => _MotionDetectionScreenState();
}

class _MotionDetectionScreenState extends State<MotionDetectionScreen> {
  List<AccelerometerData> _data = [];
  late ChartSeriesController _chartSeriesController;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  int motionCounter = 0;

  @override
  void initState() {
    super.initState();

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    accelerometerEvents.listen((AccelerometerEvent event) {
      if (mounted) {
        setState(() {
          _data.add(
              AccelerometerData(DateTime.now(), event.x, event.y, event.z));
          if (_data.length > 20) {
            _data.removeAt(0);
          }
          _chartSeriesController.updateDataSource(
            addedDataIndexes: [_data.length - 1],
            removedDataIndexes: [0],
          );

          // Check for significant motion
          if (event.x.abs() > 10 || event.y.abs() > 10 || event.z.abs() > 10) {
            motionCounter++;
            _showNotification();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    // Clean up any resources such as streams or controllers
    super.dispose();
  }

  Future<void> _showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'motion_channel',
      'Motion Detection',
      channelDescription: 'Channel for motion detection notifications',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Motion Detected',
      'Significant motion detected!',
      platformChannelSpecifics,
      payload: 'Motion detected payload',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Motion Detection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Motion Detected',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$motionCounter times',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: SfCartesianChart(
                primaryXAxis: DateTimeAxis(),
                series: <LineSeries<AccelerometerData, DateTime>>[
                  LineSeries<AccelerometerData, DateTime>(
                    onRendererCreated: (ChartSeriesController controller) {
                      _chartSeriesController = controller;
                    },
                    dataSource: _data,
                    xValueMapper: (AccelerometerData data, _) => data.time,
                    yValueMapper: (AccelerometerData data, _) => data.x,
                    name: 'X-Axis',
                  ),
                  LineSeries<AccelerometerData, DateTime>(
                    dataSource: _data,
                    xValueMapper: (AccelerometerData data, _) => data.time,
                    yValueMapper: (AccelerometerData data, _) => data.y,
                    name: 'Y-Axis',
                  ),
                  LineSeries<AccelerometerData, DateTime>(
                    dataSource: _data,
                    xValueMapper: (AccelerometerData data, _) => data.time,
                    yValueMapper: (AccelerometerData data, _) => data.z,
                    name: 'Z-Axis',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
