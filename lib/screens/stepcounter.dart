// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:lottie/lottie.dart';
// import 'package:smart_home_prject_app/main.dart';
// import 'package:sensors_plus/sensors_plus.dart';

// class StepCounterPage extends StatefulWidget {
//   @override
//   _StepCounterPageState createState() => _StepCounterPageState();
// }

// class _StepCounterPageState extends State<StepCounterPage> {
//   int _stepCount = 0;
//   bool _motionDetected = false;
//   bool _notificationShown = false;
//   late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _startListeningToAccelerometer();
//   }

//   @override
//   void dispose() {
//     _accelerometerSubscription.cancel();
//     super.dispose();
//   }

//   void _startListeningToAccelerometer() {
//     Timer? motionTimer;

//     _accelerometerSubscription =
//         accelerometerEvents.listen((AccelerometerEvent event) {
//       if (event.z.abs() > 10.0) {
//         setState(() {
//           _stepCount++;
//           _motionDetected = true;
//           _triggerNotification();
//           _notificationShown = true;
//           motionTimer?.cancel();
//           motionTimer = Timer(const Duration(seconds: 10), () {
//             if (mounted) {
//               setState(() {
//                 _motionDetected = false;
//                 _notificationShown = false;
//               });
//             }
//           });
//         });
//       }
//     });
//   }

//   void _triggerNotification() async {
//     if (!_notificationShown) {
//       const AndroidNotificationDetails androidPlatformChannelSpecifics =
//           AndroidNotificationDetails(
//         'StepCounter_channel',
//         'StepCounter Notifications',
//         importance: Importance.max,
//         priority: Priority.high,
//       );
//       const NotificationDetails platformChannelSpecifics =
//           NotificationDetails(android: androidPlatformChannelSpecifics);
//       await flutterLocalNotificationsPlugin.show(
//         0,
//         'Hello!',
//         'Motion detected! Keep It Up',
//         platformChannelSpecifics,
//       );
//       print('Motion detected! Alerting user...');
//       _notificationShown = true;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: theme.hintColor,
//         title: Text(
//           'Step Counter',
//           style: TextStyle(color: theme.primaryColor),
//         ),
//         iconTheme: IconThemeData(
//           color: theme.primaryColor,
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Step Count:',
//               style: TextStyle(fontSize: 40, color: theme.primaryColor),
//             ),
//             Text(
//               '$_stepCount',
//               style: TextStyle(
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                   color: theme.primaryColor),
//             ),
//             SizedBox(height: 20),
//             _motionDetected
//                 ? Text(
//                     'Motion Detected!',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.red, // Highlight in red for emphasis
//                     ),
//                   )
//                 : Text(
//                     'At rest',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green, // Use green color for rest
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//  this main Updated last vesion

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sensors_plus/sensors_plus.dart';

class StepCounterPage extends StatefulWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  StepCounterPage(this.flutterLocalNotificationsPlugin);

  @override
  _StepCounterPageState createState() => _StepCounterPageState();
}

class _StepCounterPageState extends State<StepCounterPage> {
  int _stepCount = 0;
  bool _motionDetected = false;
  bool _notificationShown = false;
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
  late Timer _timer;
  Duration _duration = Duration(seconds: 0);

  @override
  void initState() {
    super.initState();
    _startListeningToAccelerometer();
    _startTimer();
  }

  @override
  void dispose() {
    _accelerometerSubscription.cancel();
    _timer.cancel();
    super.dispose();
  }

  void _startListeningToAccelerometer() {
    Timer? motionTimer;

    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      if (event.z.abs() > 10.0) {
        setState(() {
          _stepCount++;
          _motionDetected = true;
          _triggerNotification();
          _notificationShown = true;
          motionTimer?.cancel();
          motionTimer = Timer(const Duration(seconds: 10), () {
            if (mounted) {
              setState(() {
                _motionDetected = false;
                _notificationShown = false;
              });
            }
          });
        });
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _duration += Duration(seconds: 1);
      });
    });
  }

  void _triggerNotification() async {
    if (!_notificationShown) {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'StepCounter_channel',
        'StepCounter Notifications',
        importance: Importance.max,
        priority: Priority.high,
      );
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await widget.flutterLocalNotificationsPlugin.show(
        0,
        'Hello!',
        'Motion detected! Keep It Up',
        platformChannelSpecifics,
      );
      print('Motion detected! Alerting user...');
      _notificationShown = true;
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  Future<void> _resetStepCounter() async {
    setState(() {
      _stepCount = 0;
      _duration = Duration(seconds: 0);
    });
  }

  Future<void> _downloadTime() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/step_counter_time.txt';
      final file = File(path);
      await file.writeAsString('Total time: ${_formatDuration(_duration)}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Time downloaded to $path'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to download time: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Step Counter',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Connecting Time',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Text(
                _formatDuration(_duration),
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  // Outer glowing effect
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.orange.withOpacity(0.4),
                          Colors.transparent,
                        ],
                        stops: [0.5, 1],
                      ),
                    ),
                  ),
                  // Inner circle with gradient
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange,
                          Colors.deepOrange,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  // Text in the center
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$_stepCount',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'mb/s',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: _downloadTime,
                        child: Icon(
                          Icons.directions_walk,
                          size: 30,
                          color: Colors.cyan,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '$_stepCount mb/s',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.cyan,
                        ),
                      ),
                      Text(
                        ' motion detected',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 40),
                  Column(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 30,
                        color: Colors.orange,
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${_duration.inMinutes} min',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        'Total Minutes',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              _motionDetected
                  ? Text(
                      'Motion Detected!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    )
                  : Text(
                      'At rest',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent,
                      ),
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetStepCounter,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: Text(
                  'START',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//  ====================================operation

// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'package:fl_chart/fl_chart.dart';

// class StepCounterPage extends StatefulWidget {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//   StepCounterPage(this.flutterLocalNotificationsPlugin);

//   @override
//   _StepCounterPageState createState() => _StepCounterPageState();
// }

// class _StepCounterPageState extends State<StepCounterPage> {
//   int _stepCount = 0;
//   bool _motionDetected = false;
//   bool _notificationShown = false;
//   late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
//   late Timer _timer;
//   Duration _duration = Duration(seconds: 0);

//   // List to store accelerometer data
//   List<FlSpot> _accelerometerData = [];

//   @override
//   void initState() {
//     super.initState();
//     _startListeningToAccelerometer();
//     _startTimer();
//   }

//   @override
//   void dispose() {
//     _accelerometerSubscription.cancel();
//     _timer.cancel();
//     super.dispose();
//   }

//   void _startListeningToAccelerometer() {
//     Timer? motionTimer;

//     _accelerometerSubscription =
//         accelerometerEvents.listen((AccelerometerEvent event) {
//       if (event.z.abs() > 10.0) {
//         setState(() {
//           _stepCount++;
//           _motionDetected = true;
//           _triggerNotification();
//           _notificationShown = true;
//           motionTimer?.cancel();
//           motionTimer = Timer(const Duration(seconds: 10), () {
//             if (mounted) {
//               setState(() {
//                 _motionDetected = false;
//                 _notificationShown = false;
//               });
//             }
//           });
//         });
//       }

//       // Update the accelerometer data list
//       setState(() {
//         _accelerometerData.add(FlSpot(_duration.inSeconds.toDouble(), event.z));
//         if (_accelerometerData.length > 100) {
//           _accelerometerData.removeAt(0); // Keep only the last 100 points
//         }
//       });
//     });
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
//       setState(() {
//         _duration += Duration(seconds: 1);
//       });
//     });
//   }

//   void _triggerNotification() async {
//     if (!_notificationShown) {
//       const AndroidNotificationDetails androidPlatformChannelSpecifics =
//           AndroidNotificationDetails(
//         'StepCounter_channel',
//         'StepCounter Notifications',
//         importance: Importance.max,
//         priority: Priority.high,
//       );
//       const NotificationDetails platformChannelSpecifics =
//           NotificationDetails(android: androidPlatformChannelSpecifics);
//       await widget.flutterLocalNotificationsPlugin.show(
//         0,
//         'Hello!',
//         'Motion detected! Keep It Up',
//         platformChannelSpecifics,
//       );
//       print('Motion detected! Alerting user...');
//       _notificationShown = true;
//     }
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = twoDigits(duration.inHours);
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return "$hours:$minutes:$seconds";
//   }

//   Future<void> _resetStepCounter() async {
//     setState(() {
//       _stepCount = 0;
//       _duration = Duration(seconds: 0);
//       _accelerometerData.clear();
//     });
//   }

//   Future<void> _downloadTime() async {
//     try {
//       final directory = await getApplicationDocumentsDirectory();
//       final path = '${directory.path}/step_counter_time.txt';
//       final file = File(path);
//       await file.writeAsString('Total time: ${_formatDuration(_duration)}');

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Time downloaded to $path'),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to download time: $e'),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text(
//           'Step Counter',
//           style: TextStyle(color: Colors.white),
//         ),
//         iconTheme: IconThemeData(
//           color: Colors.white,
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Connecting Time',
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.white,
//                 ),
//               ),
//               Text(
//                 _formatDuration(_duration),
//                 style: TextStyle(
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     width: 180,
//                     height: 180,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: RadialGradient(
//                         colors: [
//                           Colors.orange.withOpacity(0.4),
//                           Colors.transparent,
//                         ],
//                         stops: [0.5, 1],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 150,
//                     height: 150,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: LinearGradient(
//                         colors: [
//                           Colors.orange,
//                           Colors.deepOrange,
//                         ],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                     ),
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         '$_stepCount',
//                         style: TextStyle(
//                           fontSize: 40,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       Text(
//                         'mb/s',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               SizedBox(
//                 height: 200,
//                 child: LineChart(
//                   LineChartData(
//                     minX: 0,
//                     maxX: _accelerometerData.isNotEmpty
//                         ? _accelerometerData.last.x
//                         : 1,
//                     minY: -15,
//                     maxY: 15,
//                     titlesData: FlTitlesData(show: false),
//                     borderData: FlBorderData(show: false),
//                     gridData: FlGridData(show: false),
//                     lineBarsData: [
//                       LineChartBarData(
//                         spots: _accelerometerData,
//                         isCurved: true,
//                         color: Colors.cyan, // Change 'colors' to 'color'
//                         barWidth: 3,
//                         isStrokeCapRound: true,
//                         dotData: FlDotData(show: false),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Column(
//                     children: [
//                       GestureDetector(
//                         onTap: _downloadTime,
//                         child: Icon(
//                           Icons.directions_walk,
//                           size: 30,
//                           color: Colors.cyan,
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         '$_stepCount mb/s',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.cyan,
//                         ),
//                       ),
//                       Text(
//                         ' motion detected',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(width: 40),
//                   Column(
//                     children: [
//                       Icon(
//                         Icons.access_time,
//                         size: 30,
//                         color: Colors.orange,
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         '${_duration.inMinutes} min',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.orange,
//                         ),
//                       ),
//                       Text(
//                         'Total Minutes',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _resetStepCounter,
//                 child: Text('Reset'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.cyan,
//                   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//                   textStyle: TextStyle(fontSize: 20),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// =============

// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// // import 'package:fl_chart/fl_chart.dart';
// import 'package:fl_chart/fl_chart.dart';

// class StepCounterPage extends StatefulWidget {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//   StepCounterPage(this.flutterLocalNotificationsPlugin);

//   @override
//   _StepCounterPageState createState() => _StepCounterPageState();
// }

// class _StepCounterPageState extends State<StepCounterPage> {
//   int _stepCount = 0;
//   bool _motionDetected = false;
//   bool _notificationShown = false;
//   late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
//   late Timer _timer;
//   Duration _duration = Duration(seconds: 0);

//   // List to store accelerometer data
//   List<FlSpot> _accelerometerData = [];

//   @override
//   void initState() {
//     super.initState();
//     _startListeningToAccelerometer();
//     _startTimer();
//   }

//   @override
//   void dispose() {
//     _accelerometerSubscription.cancel();
//     _timer.cancel();
//     super.dispose();
//   }

//   void _startListeningToAccelerometer() {
//     Timer? motionTimer;

//     _accelerometerSubscription =
//         accelerometerEvents.listen((AccelerometerEvent event) {
//       if (event.z.abs() > 10.0) {
//         setState(() {
//           _stepCount++;
//           _motionDetected = true;
//           _triggerNotification();
//           _notificationShown = true;
//           motionTimer?.cancel();
//           motionTimer = Timer(const Duration(seconds: 10), () {
//             if (mounted) {
//               setState(() {
//                 _motionDetected = false;
//                 _notificationShown = false;
//               });
//             }
//           });
//         });
//       }

//       // Update the accelerometer data list
//       setState(() {
//         _accelerometerData.add(FlSpot(_duration.inSeconds.toDouble(), event.z));
//         if (_accelerometerData.length > 100) {
//           _accelerometerData.removeAt(0); // Keep only the last 100 points
//         }
//       });
//     });
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
//       setState(() {
//         _duration += Duration(seconds: 1);
//       });
//     });
//   }

//   void _triggerNotification() async {
//     if (!_notificationShown) {
//       const AndroidNotificationDetails androidPlatformChannelSpecifics =
//           AndroidNotificationDetails(
//         'StepCounter_channel',
//         'StepCounter Notifications',
//         importance: Importance.max,
//         priority: Priority.high,
//       );
//       const NotificationDetails platformChannelSpecifics =
//           NotificationDetails(android: androidPlatformChannelSpecifics);
//       await widget.flutterLocalNotificationsPlugin.show(
//         0,
//         'Hello!',
//         'Motion detected! Keep It Up',
//         platformChannelSpecifics,
//       );
//       print('Motion detected! Alerting user...');
//       _notificationShown = true;
//     }
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = twoDigits(duration.inHours);
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return "$hours:$minutes:$seconds";
//   }

//   Future<void> _resetStepCounter() async {
//     setState(() {
//       _stepCount = 0;
//       _duration = Duration(seconds: 0);
//       _accelerometerData.clear();
//     });
//   }

//   Future<void> _downloadTime() async {
//     try {
//       final directory = await getApplicationDocumentsDirectory();
//       final path = '${directory.path}/step_counter_time.txt';
//       final file = File(path);
//       await file.writeAsString('Total time: ${_formatDuration(_duration)}');

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Time downloaded to $path'),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to download time: $e'),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text(
//           'Step Counter',
//           style: TextStyle(color: Colors.white),
//         ),
//         iconTheme: IconThemeData(
//           color: Colors.white,
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Connecting Time',
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.white,
//                 ),
//               ),
//               Text(
//                 _formatDuration(_duration),
//                 style: TextStyle(
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     width: 180,
//                     height: 180,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: RadialGradient(
//                         colors: [
//                           Colors.orange.withOpacity(0.4),
//                           Colors.transparent,
//                         ],
//                         stops: [0.5, 1],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 150,
//                     height: 150,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: LinearGradient(
//                         colors: [
//                           Colors.orange,
//                           Colors.deepOrange,
//                         ],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                     ),
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         '$_stepCount',
//                         style: TextStyle(
//                           fontSize: 40,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       Text(
//                         'mb/s',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               SizedBox(
//                 height: 200,
//                 child: LineChart(
//                   LineChartData(
//                     minX: _accelerometerData.isNotEmpty
//                         ? _accelerometerData.first.x
//                         : 0,
//                     maxX: _accelerometerData.isNotEmpty
//                         ? _accelerometerData.last.x
//                         : 1,
//                     minY: -15,
//                     maxY: 15,
//                     titlesData: FlTitlesData(show: false),
//                     borderData: FlBorderData(show: false),
//                     gridData: FlGridData(show: false),
//                     lineBarsData: [
//                       LineChartBarData(
//                         spots: _accelerometerData,
//                         isCurved: true,
//                         color: Colors.cyan, // Change 'colors' to 'color'
//                         barWidth: 3,
//                         isStrokeCapRound: true,
//                         dotData: FlDotData(show: false),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Column(
//                     children: [
//                       GestureDetector(
//                         onTap: _downloadTime,
//                         child: Icon(
//                           Icons.directions_walk,
//                           size: 30,
//                           color: Colors.cyan,
//                         ),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         '$_stepCount mb/s',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.cyan,
//                         ),
//                       ),
//                       Text(
//                         ' motion detected',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(width: 40),
//                   Column(
//                     children: [
//                       Icon(
//                         Icons.access_time,
//                         size: 30,
//                         color: Colors.orange,
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         '${_duration.inMinutes} min',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.orange,
//                         ),
//                       ),
//                       Text(
//                         'Total Minutes',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _resetStepCounter,
//                 child: Text('Reset'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.cyan,
//                   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//                   textStyle: TextStyle(fontSize: 20),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
