// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:light_sensor/light_sensor.dart';

// class LightSensorPage extends StatefulWidget {
//   @override
//   _LightSensorPageState createState() => _LightSensorPageState();
// }

// class _LightSensorPageState extends State<LightSensorPage> {
//   double _lightIntensity = 0.0;
//   bool _showHighIntensityPopup = true;
//   bool _showLowIntensityPopup = true;
//   bool _showMiddleIntensityPopup = true;
//   bool _isBulbOn = false;
//   late StreamSubscription<int> _lightSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _startListeningToLightSensor();
//   }

// // I/flutter (29114): Current Location: (-1.9609633, 30.1175493)
//   @override
//   void dispose() {
//     _lightSubscription.cancel();
//     super.dispose();
//   }

//   void _startListeningToLightSensor() {
//     LightSensor.hasSensor().then((hasSensor) {
//       if (hasSensor) {
//         _lightSubscription = LightSensor.luxStream().listen((int luxValue) {
//           setState(() {
//             _lightIntensity = luxValue.toDouble();
//             checkAndTriggerPopups();
//           });
//         });
//       } else {
//         print("Device does not have a light sensor");
//       }
//     });
//   }

//   void checkAndTriggerPopups() {
//     if (_lightIntensity >= 20000.0) {
//       if (_showHighIntensityPopup) {
//         _showPopup(
//             'High Light Intensity', 'Ambient light level is at its highest.');
//         _showHighIntensityPopup = false;
//         _showMiddleIntensityPopup = true;
//         _showLowIntensityPopup = true;
//       }
//       _isBulbOn = true;
//     } else if (_lightIntensity <= 100) {
//       if (_showLowIntensityPopup) {
//         _showPopup(
//             'Low Light Intensity', 'Ambient light level is at its lowest.');
//         _showLowIntensityPopup = false;
//         _showMiddleIntensityPopup = true;
//         _showHighIntensityPopup = true;
//       }
//       _isBulbOn = false;
//     } else {
//       if (_showMiddleIntensityPopup) {
//         _showPopup(
//             'Middle Light Intensity', 'Ambient light level is at its middle.');
//         _showMiddleIntensityPopup = false;
//         _showHighIntensityPopup = true;
//         _showLowIntensityPopup = true;
//       }
//       _isBulbOn = true;
//     }
//   }

//   void _showPopup(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     String bulbImage =
//         _isBulbOn ? 'lib/assets/bulb.png' : 'lib/assets/turn-off.jpg';

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: theme.hintColor,
//         title: Text(
//           'Light Sensor',
//           style: TextStyle(color: theme.primaryColor),
//         ),
//         iconTheme: IconThemeData(
//           color: theme.primaryColor,
//         ),
//       ),
//       body: Center(
//         child: Image.asset(
//           bulbImage,
//           width: 400,
//           height: 400,
//         ),
//       ),
//     );
//   }
// }

//  1st version

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:light_sensor/light_sensor.dart';

// class LightSensorPage extends StatefulWidget {
//   @override
//   _LightSensorPageState createState() => _LightSensorPageState();
// }

// class _LightSensorPageState extends State<LightSensorPage> {
//   double _lightIntensity = 0.0;
//   bool _showHighIntensityPopup = true;
//   bool _showLowIntensityPopup = true;
//   bool _showMiddleIntensityPopup = true;
//   bool _isBulbOn = false;
//   late StreamSubscription<int> _lightSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _startListeningToLightSensor();
//   }

//   @override
//   void dispose() {
//     _lightSubscription.cancel();
//     super.dispose();
//   }

//   void _startListeningToLightSensor() {
//     LightSensor.hasSensor().then((hasSensor) {
//       if (hasSensor) {
//         _lightSubscription = LightSensor.luxStream().listen((int luxValue) {
//           setState(() {
//             _lightIntensity = luxValue.toDouble();
//             checkAndTriggerPopups();
//           });
//         });
//       } else {
//         print("Device does not have a light sensor");
//       }
//     });
//   }

//   void checkAndTriggerPopups() {
//     if (_lightIntensity >= 20000.0) {
//       if (_showHighIntensityPopup) {
//         _showPopup(
//             'High Light Intensity', 'Ambient light level is at its highest.');
//         _showHighIntensityPopup = false;
//         _showMiddleIntensityPopup = true;
//         _showLowIntensityPopup = true;
//       }
//       _isBulbOn = true;
//     } else if (_lightIntensity <= 100) {
//       if (_showLowIntensityPopup) {
//         _showPopup(
//             'Low Light Intensity', 'Ambient light level is at its lowest.');
//         _showLowIntensityPopup = false;
//         _showMiddleIntensityPopup = true;
//         _showHighIntensityPopup = true;
//       }
//       _isBulbOn = false;
//     } else {
//       if (_showMiddleIntensityPopup) {
//         _showPopup(
//             'Middle Light Intensity', 'Ambient light level is at its middle.');
//         _showMiddleIntensityPopup = false;
//         _showHighIntensityPopup = true;
//         _showLowIntensityPopup = true;
//       }
//       _isBulbOn = true;
//     }
//   }

//   void _showPopup(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     String bulbImage =
//         _isBulbOn ? 'lib/assets/bulb.png' : 'lib/assets/turn-off.jpg';

//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.blue, Colors.purple],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         title: Text(
//           'Light Sensor',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               elevation: 5,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Light Intensity: $_lightIntensity lux',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: theme.primaryColor,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Image.asset(
//                       bulbImage,
//                       width: 200,
//                       height: 200,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//  second version

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:light_sensor/light_sensor.dart';

// class LightSensorPage extends StatefulWidget {
//   @override
//   _LightSensorPageState createState() => _LightSensorPageState();
// }

// class _LightSensorPageState extends State<LightSensorPage> {
//   double _lightIntensity = 0.0;
//   bool _showHighIntensityPopup = true;
//   bool _showLowIntensityPopup = true;
//   bool _showMiddleIntensityPopup = true;
//   bool _isBulbOn = false;
//   late StreamSubscription<int> _lightSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _startListeningToLightSensor();
//   }

//   @override
//   void dispose() {
//     _lightSubscription.cancel();
//     super.dispose();
//   }

//   void _startListeningToLightSensor() {
//     LightSensor.hasSensor().then((hasSensor) {
//       if (hasSensor) {
//         _lightSubscription = LightSensor.luxStream().listen((int luxValue) {
//           setState(() {
//             _lightIntensity = luxValue.toDouble();
//             checkAndTriggerPopups();
//           });
//         });
//       } else {
//         print("Device does not have a light sensor");
//       }
//     });
//   }

//   void checkAndTriggerPopups() {
//     if (_lightIntensity >= 20000.0) {
//       if (_showHighIntensityPopup) {
//         _showPopup(
//             'High Light Intensity', 'Ambient light level is at its highest.');
//         _showHighIntensityPopup = false;
//         _showMiddleIntensityPopup = true;
//         _showLowIntensityPopup = true;
//       }
//       _isBulbOn = true;
//     } else if (_lightIntensity <= 100) {
//       if (_showLowIntensityPopup) {
//         _showPopup(
//             'Low Light Intensity', 'Ambient light level is at its lowest.');
//         _showLowIntensityPopup = false;
//         _showMiddleIntensityPopup = true;
//         _showHighIntensityPopup = true;
//       }
//       _isBulbOn = false;
//     } else {
//       if (_showMiddleIntensityPopup) {
//         _showPopup(
//             'Middle Light Intensity', 'Ambient light level is at its middle.');
//         _showMiddleIntensityPopup = false;
//         _showHighIntensityPopup = true;
//         _showLowIntensityPopup = true;
//       }
//       _isBulbOn = true;
//     }
//   }

//   void _showPopup(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.blue, Colors.purple],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         title: Text(
//           'Light Sensor',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               elevation: 5,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Light Intensity: $_lightIntensity lux',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: theme.primaryColor,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Icon(
//                       _isBulbOn ? Icons.lightbulb : Icons.lightbulb_outline,
//                       color: _isBulbOn ? Colors.yellow : Colors.grey,
//                       size: 100,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//  3 thrid version

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:light_sensor/light_sensor.dart';

// class LightSensorPage extends StatefulWidget {
//   @override
//   _LightSensorPageState createState() => _LightSensorPageState();
// }

// class _LightSensorPageState extends State<LightSensorPage> {
//   double _lightIntensity = 0.0;
//   bool _showHighIntensityPopup = true;
//   bool _showLowIntensityPopup = true;
//   bool _showMiddleIntensityPopup = true;
//   bool _isBulbOn = false;
//   late StreamSubscription<int> _lightSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _startListeningToLightSensor();
//   }

//   @override
//   void dispose() {
//     _lightSubscription.cancel();
//     super.dispose();
//   }

//   void _startListeningToLightSensor() {
//     LightSensor.hasSensor().then((hasSensor) {
//       if (hasSensor) {
//         _lightSubscription = LightSensor.luxStream().listen((int luxValue) {
//           setState(() {
//             _lightIntensity = luxValue.toDouble();
//             checkAndTriggerPopups();
//           });
//         });
//       } else {
//         print("Device does not have a light sensor");
//       }
//     });
//   }

//   void checkAndTriggerPopups() {
//     if (_lightIntensity >= 20000.0) {
//       if (_showHighIntensityPopup) {
//         _showPopup(
//             'High Light Intensity', 'Ambient light level is at its highest.');
//         _showHighIntensityPopup = false;
//         _showMiddleIntensityPopup = true;
//         _showLowIntensityPopup = true;
//       }
//       _isBulbOn = true;
//     } else if (_lightIntensity <= 100) {
//       if (_showLowIntensityPopup) {
//         _showPopup(
//             'Low Light Intensity', 'Ambient light level is at its lowest.');
//         _showLowIntensityPopup = false;
//         _showMiddleIntensityPopup = true;
//         _showHighIntensityPopup = true;
//       }
//       _isBulbOn = false;
//     } else {
//       if (_showMiddleIntensityPopup) {
//         _showPopup(
//             'Middle Light Intensity', 'Ambient light level is at its middle.');
//         _showMiddleIntensityPopup = false;
//         _showHighIntensityPopup = true;
//         _showLowIntensityPopup = true;
//       }
//       _isBulbOn = true;
//     }
//   }

//   void _showPopup(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.blue, Colors.purple],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         title: Text(
//           'Light Sensor',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               elevation: 5,
//               child: Container(
//                 width: MediaQuery.of(context).size.width * 0.9,
//                 height: MediaQuery.of(context).size.height * 0.6,
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Light Intensity: $_lightIntensity lux',
//                       style: TextStyle(
//                         fontSize:  24,
//                         fontWeight: FontWeight.bold,
//                         color: theme.primaryColor,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Icon(
//                       // _isBulbOn ? Icons.lightbulb : Icons.lightbulb_outline,
//                       _isBulbOn
//                           ? FontAwesomeIcons.solidLightbulb
//                           : FontAwesomeIcons.lightbulb,
//                       color: _isBulbOn ? Colors.yellow : Colors.grey,
//                       // size: 150,
//                       size: 300,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//  new vesrion

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:light_sensor/light_sensor.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';

// class LightSensorPage extends StatefulWidget {
//   @override
//   _LightSensorPageState createState() => _LightSensorPageState();
// }

// class _LightSensorPageState extends State<LightSensorPage> {
//   double _lightIntensity = 0.0;
//   bool _showHighIntensityPopup = true;
//   bool _showLowIntensityPopup = true;
//   bool _showMiddleIntensityPopup = true;
//   bool _isBulbOn = false;
//   late StreamSubscription<int> _lightSubscription;
//   late FlutterLocalNotificationsPlugin _localNotificationsPlugin;

//   @override
//   void initState() {
//     super.initState();
//     _startListeningToLightSensor();
//     _initializeNotifications();
//   }

//   @override
//   void dispose() {
//     _lightSubscription.cancel();
//     super.dispose();
//   }

//   void _initializeNotifications() {
//     _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//     );
//     _localNotificationsPlugin.initialize(initializationSettings);
//   }

//   void _startListeningToLightSensor() {
//     LightSensor.hasSensor().then((hasSensor) {
//       if (hasSensor) {
//         _lightSubscription = LightSensor.luxStream().listen((int luxValue) {
//           setState(() {
//             _lightIntensity = luxValue.toDouble();
//             checkAndTriggerPopups();
//           });
//         });
//       } else {
//         print("Device does not have a light sensor");
//       }
//     });
//   }

//   void checkAndTriggerPopups() {
//     if (_lightIntensity >= 20000.0) {
//       if (_showHighIntensityPopup) {
//         _showPopup(
//             'High Light Intensity', 'Ambient light level is at its highest.');
//         _showNotification('High Light Intensity',
//             'Ambient light level is at its highest (${_lightIntensity.toStringAsFixed(2)} lux).');
//         _showHighIntensityPopup = false;
//         _showMiddleIntensityPopup = true;
//         _showLowIntensityPopup = true;
//       }
//       _isBulbOn = true;
//     } else if (_lightIntensity <= 100) {
//       if (_showLowIntensityPopup) {
//         _showPopup(
//             'Low Light Intensity', 'Ambient light level is at its lowest.');
//         _showNotification('Low Light Intensity',
//             'Ambient light level is at its lowest (${_lightIntensity.toStringAsFixed(2)} lux).');
//         _showLowIntensityPopup = false;
//         _showMiddleIntensityPopup = true;
//         _showHighIntensityPopup = true;
//       }
//       _isBulbOn = false;
//     } else {
//       if (_showMiddleIntensityPopup) {
//         _showPopup(
//             'Middle Light Intensity', 'Ambient light level is at its middle.');
//         _showNotification('Middle Light Intensity',
//             'Ambient light level is at its middle (${_lightIntensity.toStringAsFixed(2)} lux).');
//         _showMiddleIntensityPopup = false;
//         _showHighIntensityPopup = true;
//         _showLowIntensityPopup = true;
//       }
//       _isBulbOn = true;
//     }
//   }

//   void _showPopup(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showNotification(String title, String message) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'light_sensor_channel', // Channel ID
//       'Light Sensor Notifications', // Channel name
//       channelDescription:
//           'Notifications for light sensor readings', // Channel description
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await _localNotificationsPlugin.show(
//       0, // Notification ID
//       title, // Notification title
//       message, // Notification message
//       platformChannelSpecifics,
//       payload: 'item x', // Optional payload
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.blue, Colors.purple],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         title: Text(
//           'Light Sensor',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               elevation: 5,
//               child: Container(
//                 width: MediaQuery.of(context).size.width * 0.9,
//                 height: MediaQuery.of(context).size.height * 0.8,
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Light Intensity: $_lightIntensity lux',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: theme.primaryColor,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     SfRadialGauge(
//                       axes: <RadialAxis>[
//                         RadialAxis(
//                           minimum: 0,
//                           maximum: 60000,
//                           ranges: <GaugeRange>[
//                             GaugeRange(
//                               startValue: 0,
//                               endValue: 20000,
//                               color: Colors.orange,
//                             ),
//                             GaugeRange(
//                               startValue: 20000,
//                               endValue: 40000,
//                               color: Colors.yellow,
//                             ),
//                             GaugeRange(
//                               startValue: 40000,
//                               endValue: 60000,
//                               color: Colors.red,
//                             ),
//                           ],
//                           pointers: <GaugePointer>[
//                             NeedlePointer(value: _lightIntensity),
//                           ],
//                           annotations: <GaugeAnnotation>[
//                             GaugeAnnotation(
//                               widget: Container(
//                                 child: Text(
//                                   _lightIntensity.toStringAsFixed(2) + ' lux',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               angle: 90,
//                               positionFactor: 0.5,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     Icon(
//                       _isBulbOn
//                           ? FontAwesomeIcons.solidLightbulb
//                           : FontAwesomeIcons.lightbulb,
//                       color: _isBulbOn ? Colors.yellow : Colors.grey,
//                       size: 150,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//  ==================================
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:light_sensor/light_sensor.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';

// class LightSensorPage extends StatefulWidget {
//   @override
//   _LightSensorPageState createState() => _LightSensorPageState();
// }

// class _LightSensorPageState extends State<LightSensorPage> {
//   double _lightIntensity = 0.0;
//   bool _showHighIntensityPopup = true;
//   bool _showLowIntensityPopup = true;
//   bool _showMiddleIntensityPopup = true;
//   bool _isBulbOn = false;
//   late StreamSubscription<int> _lightSubscription;
//   late FlutterLocalNotificationsPlugin _localNotificationsPlugin;

//   @override
//   void initState() {
//     super.initState();
//     _startListeningToLightSensor();
//     _initializeNotifications();
//   }

//   @override
//   void dispose() {
//     _lightSubscription.cancel();
//     super.dispose();
//   }

//   void _initializeNotifications() {
//     _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//     );
//     _localNotificationsPlugin.initialize(initializationSettings);
//   }

//   void _startListeningToLightSensor() {
//     LightSensor.hasSensor().then((hasSensor) {
//       if (hasSensor) {
//         _lightSubscription = LightSensor.luxStream().listen((int luxValue) {
//           setState(() {
//             _lightIntensity = luxValue.toDouble();
//             checkAndTriggerPopups();
//           });
//         });
//       } else {
//         print("Device does not have a light sensor");
//       }
//     });
//   }

//   void checkAndTriggerPopups() {
//     if (_lightIntensity >= 20000.0) {
//       if (_showHighIntensityPopup) {
//         _showPopup(
//             'High Light Intensity', 'Ambient light level is at its highest.');
//         _showNotification('High Light Intensity',
//             'Ambient light level is at its highest (${_lightIntensity.toStringAsFixed(2)} lux).');
//         _showHighIntensityPopup = false;
//         _showMiddleIntensityPopup = true;
//         _showLowIntensityPopup = true;
//       }
//       _isBulbOn = true;
//     } else if (_lightIntensity <= 100) {
//       if (_showLowIntensityPopup) {
//         _showPopup(
//             'Low Light Intensity', 'Ambient light level is at its lowest.');
//         _showNotification('Low Light Intensity',
//             'Ambient light level is at its lowest (${_lightIntensity.toStringAsFixed(2)} lux).');
//         _showLowIntensityPopup = false;
//         _showMiddleIntensityPopup = true;
//         _showHighIntensityPopup = true;
//       }
//       _isBulbOn = false;
//     } else {
//       if (_showMiddleIntensityPopup) {
//         _showPopup(
//             'Middle Light Intensity', 'Ambient light level is at its middle.');
//         _showNotification('Middle Light Intensity',
//             'Ambient light level is at its middle (${_lightIntensity.toStringAsFixed(2)} lux).');
//         _showMiddleIntensityPopup = false;
//         _showHighIntensityPopup = true;
//         _showLowIntensityPopup = true;
//       }
//       _isBulbOn = true;
//     }
//   }

//   void _showPopup(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showNotification(String title, String message) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'light_sensor_channel', // Channel ID
//       'Light Sensor Notifications', // Channel name
//       channelDescription:
//           'Notifications for light sensor readings', // Channel description
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await _localNotificationsPlugin.show(
//       0, // Notification ID
//       title, // Notification title
//       message, // Notification message
//       platformChannelSpecifics,
//       payload: 'item x', // Optional payload
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.blue, Colors.purple],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         title: Text(
//           'Light Sensor',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               elevation: 5,
//               child: Container(
//                 width: MediaQuery.of(context).size.width * 0.9,
//                 height: MediaQuery.of(context).size.height * 0.8,
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Light Intensity: $_lightIntensity lux',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: theme.primaryColor,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     SfRadialGauge(
//                       axes: <RadialAxis>[
//                         RadialAxis(
//                           minimum: 0,
//                           maximum: 60000,
//                           ranges: <GaugeRange>[
//                             GaugeRange(
//                               startValue: 0,
//                               endValue: 20000,
//                               color: Colors.orange,
//                             ),
//                             GaugeRange(
//                               startValue: 20000,
//                               endValue: 40000,
//                               color: Colors.yellow,
//                             ),
//                             GaugeRange(
//                               startValue: 40000,
//                               endValue: 60000,
//                               color: Colors.red,
//                             ),
//                           ],
//                           pointers: <GaugePointer>[
//                             NeedlePointer(value: _lightIntensity),
//                           ],
//                           annotations: <GaugeAnnotation>[
//                             GaugeAnnotation(
//                               widget: Container(
//                                 child: Text(
//                                   _lightIntensity.toStringAsFixed(2) + ' lux',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               angle: 90,
//                               positionFactor: 0.5,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     Padding(
//                       // padding: const EdgeInsets.only(top: 50.0),
//                       padding: const EdgeInsets.only(bottom: 120.0),
//                       child: Icon(
//                         _isBulbOn
//                             ? FontAwesomeIcons.solidLightbulb
//                             : FontAwesomeIcons.lightbulb,
//                         color: _isBulbOn ? Colors.yellow : Colors.grey,
//                         size: 150,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ================

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:light_sensor/light_sensor.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class LightSensorPage extends StatefulWidget {
  @override
  _LightSensorPageState createState() => _LightSensorPageState();
}

class _LightSensorPageState extends State<LightSensorPage> {
  double _lightIntensity = 0.0;
  bool _showHighIntensityPopup = true;
  bool _showLowIntensityPopup = true;
  bool _showMiddleIntensityPopup = true;
  bool _isBulbOn = false;
  late StreamSubscription<int> _lightSubscription;
  late FlutterLocalNotificationsPlugin _localNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _startListeningToLightSensor();
    _initializeNotifications();
  }

  @override
  void dispose() {
    _lightSubscription.cancel();
    super.dispose();
  }

  void _initializeNotifications() {
    _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    _localNotificationsPlugin.initialize(initializationSettings);
  }

  void _startListeningToLightSensor() {
    LightSensor.hasSensor().then((hasSensor) {
      if (hasSensor) {
        _lightSubscription = LightSensor.luxStream().listen((int luxValue) {
          setState(() {
            _lightIntensity = luxValue.toDouble();
            checkAndTriggerPopups();
          });
        });
      } else {
        print("Device does not have a light sensor");
      }
    });
  }

  void checkAndTriggerPopups() {
    if (_lightIntensity >= 20000.0) {
      if (_showHighIntensityPopup) {
        _showPopup(
            'High Light Intensity', 'Ambient light level is at its highest.');
        _showNotification('High Light Intensity',
            'Ambient light level is at its highest (${_lightIntensity.toStringAsFixed(2)} lux).');
        _showHighIntensityPopup = false;
        _showMiddleIntensityPopup = true;
        _showLowIntensityPopup = true;
      }
      _isBulbOn = true;
    } else if (_lightIntensity <= 100) {
      if (_showLowIntensityPopup) {
        _showPopup(
            'Low Light Intensity', 'Ambient light level is at its lowest.');
        _showNotification('Low Light Intensity',
            'Ambient light level is at its lowest (${_lightIntensity.toStringAsFixed(2)} lux).');
        _showLowIntensityPopup = false;
        _showMiddleIntensityPopup = true;
        _showHighIntensityPopup = true;
      }
      _isBulbOn = false;
    } else {
      if (_showMiddleIntensityPopup) {
        _showPopup(
            'Middle Light Intensity', 'Ambient light level is at its middle.');
        _showNotification('Middle Light Intensity',
            'Ambient light level is at its middle (${_lightIntensity.toStringAsFixed(2)} lux).');
        _showMiddleIntensityPopup = false;
        _showHighIntensityPopup = true;
        _showLowIntensityPopup = true;
      }
      _isBulbOn = true;
    }
  }

  void _showPopup(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showNotification(String title, String message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'light_sensor_channel', // Channel ID
      'Light Sensor Notifications', // Channel name
      channelDescription:
          'Notifications for light sensor readings', // Channel description
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _localNotificationsPlugin.show(
      0, // Notification ID
      title, // Notification title
      message, // Notification message
      platformChannelSpecifics,
      payload: 'item x', // Optional payload
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          'Light Sensor',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Light Intensity: $_lightIntensity lux',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      SfRadialGauge(
                        axes: <RadialAxis>[
                          RadialAxis(
                            minimum: 0,
                            maximum: 60000,
                            ranges: <GaugeRange>[
                              GaugeRange(
                                startValue: 0,
                                endValue: 20000,
                                color: Colors.orange,
                              ),
                              GaugeRange(
                                startValue: 20000,
                                endValue: 40000,
                                color: Colors.yellow,
                              ),
                              GaugeRange(
                                startValue: 40000,
                                endValue: 60000,
                                color: Colors.red,
                              ),
                            ],
                            pointers: <GaugePointer>[
                              NeedlePointer(value: _lightIntensity),
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                widget: Container(
                                  child: Text(
                                    _lightIntensity.toStringAsFixed(2) + ' lux',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                angle: 90,
                                positionFactor: 0.5,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: Icon(
                          _isBulbOn
                              ? FontAwesomeIcons.solidLightbulb
                              : FontAwesomeIcons.lightbulb,
                          color: _isBulbOn ? Colors.yellow : Colors.grey,
                          size: 150,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
