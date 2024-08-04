// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:smart_home_prject_app/components/ThemeProvider.dart';
// import 'package:smart_home_prject_app/screens/StepCounter.dart';
// import 'package:smart_home_prject_app/screens/lightsensor.dart';
// import 'package:smart_home_prject_app/screens/maps.dart';
// import 'package:smart_home_prject_app/screens/signup_screen.dart';
// import 'package:smart_home_prject_app/screens/login_screen.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:smart_home_prject_app/screens/stepcounter.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initNotifications();
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => ThemeNotifier(),
//       child: const MyApp(),
//     ),
//   );
// }

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> initNotifications() async {
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');

//   final InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//   );

//   await flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//     onDidReceiveNotificationResponse:
//         (NotificationResponse notificationResponse) async {
//       // Handle notification tap
//     },
//   );

//   print('Notification plugin initialized');
// }

// Future<void> sendTestNotification() async {
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     'high_importance_channel',
//     'High Importance Notifications',
//     channelDescription: 'This channel is used for important notifications.',
//     importance: Importance.high,
//     priority: Priority.high,
//     showWhen: false,
//   );

//   const NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);

//   await flutterLocalNotificationsPlugin.show(
//     0,
//     'Test Notification',
//     'This is a test notification',
//     platformChannelSpecifics,
//     payload: 'Test Payload',
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final themeNotifier = Provider.of<ThemeNotifier>(context);
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: themeNotifier.currentTheme,
//       home: const MyHomePage(title: 'Home'),
//       routes: {
//         '/signup': (context) => SignUpScreen(),
//         '/login': (context) => LoginScreen(),
//         '/home': (context) => MyHomePage(title: 'Home'),
//       },
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   final String title;
//   const MyHomePage({required this.title, Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: theme.hintColor,
//         title: Text(
//           widget.title,
//           style: TextStyle(color: theme.primaryColor),
//         ),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           _buildOption(
//             context,
//             theme,
//             icon: Icons.lightbulb_rounded,
//             label: 'Light Sensor',
//             onTap: () => Navigator.of(context).push(
//                 MaterialPageRoute(builder: (context) => LightSensorPage())),
//           ),
//           _buildOption(
//             context,
//             theme,
//             icon: Icons.map,
//             label: 'Maps',
//             onTap: () => Navigator.of(context)
//                 .push(MaterialPageRoute(builder: (context) => MapPage())),
//           ),
//           _buildOption(
//             context,
//             theme,
//             icon: Icons.run_circle_outlined,
//             label: 'Step Counter',
//             onTap: () => Navigator.of(context).push(
//                 MaterialPageRoute(builder: (context) => StepCounterPage())),
//           ),
//           _buildOption(
//             context,
//             theme,
//             icon: Icons.notification_important,
//             label: 'Send Test Notification',
//             onTap: () async {
//               await sendTestNotification();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Test notification sent')),
//               );
//             },
//           ),
//           _buildOption(
//             context,
//             theme,
//             icon: Icons.login,
//             label: 'Login',
//             onTap: () => Navigator.of(context)
//                 .push(MaterialPageRoute(builder: (context) => LoginScreen())),
//           ),
//           _buildOption(
//             context,
//             theme,
//             icon: Icons.person_add,
//             label: 'Sign Up',
//             onTap: () => Navigator.of(context)
//                 .push(MaterialPageRoute(builder: (context) => SignUpScreen())),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildOption(BuildContext context, ThemeData theme,
//       {required IconData icon,
//       required String label,
//       required VoidCallback onTap}) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       decoration: BoxDecoration(
//         color: theme.cardColor,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: ListTile(
//         leading: Icon(icon, size: 50.0, color: theme.primaryColor),
//         title: Text(label, style: TextStyle(color: theme.primaryColor)),
//         onTap: onTap,
//       ),
//     );
//   }
// }

/// The above code is a Flutter application that includes features like theme management, notifications,
/// different screens for light sensor, maps, step counter, signup, and login, along with the
/// functionality to send test notifications.

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:smart_home_prject_app/components/ThemeProvider.dart';
// import 'package:smart_home_prject_app/screens/lightsensor.dart';
// import 'package:smart_home_prject_app/screens/maps.dart';
// import 'package:smart_home_prject_app/screens/motion_detection_screen.dart';
// import 'package:smart_home_prject_app/screens/signup_screen.dart';
// import 'package:smart_home_prject_app/screens/login_screen.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:smart_home_prject_app/screens/stepcounter.dart'; // Ensure this is the correct import

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initNotifications();
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => ThemeNotifier(),
//       child: const MyApp(),
//     ),
//   );
// }

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> initNotifications() async {
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');

//   final InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//   );

//   await flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//     onDidReceiveNotificationResponse:
//         (NotificationResponse notificationResponse) async {
//       // Handle notification tap
//     },
//   );

//   print('Notification plugin initialized');
// }

// Future<void> sendTestNotification() async {
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     'high_importance_channel',
//     'High Importance Notifications',
//     channelDescription: 'This channel is used for important notifications.',
//     importance: Importance.high,
//     priority: Priority.high,
//     showWhen: false,
//   );

//   const NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);

//   await flutterLocalNotificationsPlugin.show(
//     0,
//     'Test Notification',
//     'This is a test notification',
//     platformChannelSpecifics,
//     payload: 'Test Payload',
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final themeNotifier = Provider.of<ThemeNotifier>(context);
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: themeNotifier.currentTheme,
//       home: const MyHomePage(title: 'Home'),
//       routes: {
//         '/signup': (context) => SignUpScreen(),
//         '/login': (context) => LoginScreen(),
//         '/home': (context) => MyHomePage(title: 'Home'),
//       },
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   final String title;
//   const MyHomePage({required this.title, Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);

//     // Colors extracted from the image
//     final Color iconColor1 = Color(0xFF8D82F6); // Purple
//     final Color iconColor2 = Color(0xFFFFC85C); // Yellow
//     final Color iconColor3 = Color(0xFFFF7171); // Red
//     final Color iconColor4 = Color(0xFF61D4FF); // Light Blue

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: theme.hintColor,
//         title: Text(
//           widget.title,
//           style: TextStyle(color: theme.primaryColor),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.menu, color: theme.primaryColor),
//           onPressed: () {},
//         ),
//         actions: [
//           CircleAvatar(
//             backgroundImage: AssetImage('lib/assets/Mrius_24.jpg'),
//           ),
//           SizedBox(width: 16),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Welcome, Smart Home App',
//               style: TextStyle(
//                   fontSize: 24,
//                   color: theme.primaryColor,
//                   fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'House 1\n395 Amherst St, East Orange, NJ',
//               style: TextStyle(fontSize: 16, color: theme.primaryColor),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 16.0,
//                 crossAxisSpacing: 16.0,
//                 children: [
//                   _buildOption(
//                     context,
//                     theme,
//                     icon: Icons.lightbulb_rounded,
//                     label: 'Light Sensor',
//                     iconColor: iconColor1,
//                     onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => LightSensorPage())),
//                   ),
//                   _buildOption(
//                     context,
//                     theme,
//                     icon: Icons.map,
//                     label: 'Maps',
//                     iconColor: iconColor2,
//                     onTap: () => Navigator.of(context).push(
//                         MaterialPageRoute(builder: (context) => MapPage())),
//                   ),
//                   _buildOption(
//                     context,
//                     theme,
//                     icon: Icons.run_circle_outlined,
//                     label: 'Step Counter',
//                     iconColor: iconColor3,
//                     onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) =>
//                             StepCounterPage(flutterLocalNotificationsPlugin))),
//                   ),
//                   _buildOption(
//                     context,
//                     theme,
//                     icon: Icons.notification_important,
//                     label: 'Send Test Notification',
//                     iconColor: iconColor4,
//                     onTap: () async {
//                       await sendTestNotification();
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Test notification sent')),
//                       );
//                     },
//                   ),
//                   _buildOption(
//                     context,
//                     theme,
//                     icon: Icons.login,
//                     label: 'Login',
//                     iconColor: iconColor1,
//                     onTap: () => Navigator.of(context).push(
//                         MaterialPageRoute(builder: (context) => LoginScreen())),
//                   ),
//                   _buildOption(
//                     context,
//                     theme,
//                     icon: Icons.person_add,
//                     label: 'Sign Up',
//                     iconColor: iconColor2,
//                     onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => SignUpScreen())),
//                   ),
//                   _buildOption(
//                     context,
//                     theme,
//                     // icon: Icons.person_add,

//                     // motion_photos_on
//                     icon: Icons.directions_run,
//                     label: 'Motion Detector',
//                     iconColor: iconColor3,
//                     onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => MotionDetectionScreen())),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.access_time),
//             label: 'History',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildOption(BuildContext context, ThemeData theme,
//       {required IconData icon,
//       required String label,
//       required Color iconColor,
//       required VoidCallback onTap}) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.black, // Set the grid color to blue
//         borderRadius: BorderRadius.circular(30), // Set border radius to 30
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(30),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(icon, size: 50.0, color: iconColor),
//                 SizedBox(height: 10),
//                 Text(label, style: TextStyle(color: Colors.white)),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// new version

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_prject_app/components/ThemeProvider.dart';
import 'package:smart_home_prject_app/screens/lightsensor.dart';
import 'package:smart_home_prject_app/screens/maps.dart';
import 'package:smart_home_prject_app/screens/motion_detection_screen.dart';
import 'package:smart_home_prject_app/screens/signup_screen.dart';
import 'package:smart_home_prject_app/screens/login_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smart_home_prject_app/screens/stepcounter.dart'; // Ensure this is the correct import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) async {
      // Handle notification tap
    },
  );

  print('Notification plugin initialized');
}

Future<void> sendTestNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'high_importance_channel',
    'High Importance Notifications',
    channelDescription: 'This channel is used for important notifications.',
    importance: Importance.high,
    priority: Priority.high,
    showWhen: false,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    'Test Notification',
    'This is a test notification',
    platformChannelSpecifics,
    payload: 'Test Payload',
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: themeNotifier.currentTheme,
      home: MyHomePage(title: 'Home'),
      routes: {
        '/signup': (context) => SignUpScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => MyHomePage(title: 'Home'),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({required this.title, Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return LoginScreen();
      case 1:
        return SignUpScreen();
      case 2:
        return Text("Calculator Screen"); // Placeholder for Calculator screen
      default:
        return Text("Error");
    }
  }

  _onMenuItemSelected(int index) {
    setState(() {
      _selectedDrawerIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    // Colors extracted from the image
    final Color iconColor1 = Color.fromARGB(255, 25, 180, 95); // Green
    final Color iconColor2 = Color(0xFFFFC85C); // Yellow
    final Color iconColor3 = Color(0xFFFF7171); // Red
    final Color iconColor4 = Color(0xFF61D4FF); // Light Blue

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.hintColor,
        title: Text(
          widget.title,
          style: TextStyle(color: theme.primaryColor),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('lib/assets/Mrius_24.jpg'),
          ),
          SizedBox(width: 16),
          IconButton(
            icon: Icon(Icons.brightness_6, color: theme.primaryColor),
            onPressed: () {
              themeNotifier.toggleTheme();
            },
          ),
        ],
      ),
      drawer: MyDrawer(onMenuItemSelected: _onMenuItemSelected),
      body: _selectedDrawerIndex == 0
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, Smart Home App',
                    style: TextStyle(
                        fontSize: 24,
                        color: theme.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors
                          .grey[850], // Background color similar to the image
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.white, // Icon color
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'House 1',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Text color for 'House 1'
                              ),
                            ),
                            Text(
                              '395 Amherst St, East Orange, NJ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors
                                    .grey[400], // Text color for the address
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white, // Arrow color
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 16.0,
                      children: [
                        _buildOption(
                          context,
                          theme,
                          icon: Icons.lightbulb_rounded,
                          label: 'Light Sensor',
                          iconColor: iconColor1,
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => LightSensorPage())),
                        ),
                        _buildOption(
                          context,
                          theme,
                          icon: Icons.map,
                          label: 'Maps',
                          iconColor: iconColor2,
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => MapPage())),
                        ),
                        _buildOption(
                          context,
                          theme,
                          icon: Icons.run_circle_outlined,
                          label: 'Step Counter',
                          iconColor: iconColor3,
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => StepCounterPage(
                                      flutterLocalNotificationsPlugin))),
                        ),
                        _buildOption(
                          context,
                          theme,
                          icon: Icons.notification_important,
                          label: 'Send Test Notification',
                          iconColor: iconColor4,
                          onTap: () async {
                            await sendTestNotification();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Test notification sent')),
                            );
                          },
                        ),
                        _buildOption(
                          context,
                          theme,
                          icon: Icons.login,
                          label: 'Login',
                          iconColor: iconColor1,
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen())),
                        ),
                        _buildOption(
                          context,
                          theme,
                          icon: Icons.person_add,
                          label: 'Sign Up',
                          iconColor: iconColor2,
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen())),
                        ),
                        _buildOption(
                          context,
                          theme,
                          icon: Icons.directions_run,
                          label: 'Motion Detector',
                          iconColor: iconColor3,
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MotionDetectionScreen())),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : _getDrawerItemWidget(_selectedDrawerIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.access_time),
            icon: Icon(Icons.access_time),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, ThemeData theme,
      {required IconData icon,
      required String label,
      required Color iconColor,
      required VoidCallback onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black, // Set the grid color to black
        borderRadius: BorderRadius.circular(30), // Set border radius to 30
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
          BoxShadow(
            color: Colors.green.withOpacity(0.9),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 50.0, color: iconColor),
                SizedBox(height: 10),
                Text(label, style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  final Function(int) onMenuItemSelected;

  const MyDrawer({required this.onMenuItemSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text(
              'Smart Home Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Sign In'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login');
            },
          ),
          ListTile(
            leading: Icon(Icons.app_registration),
            title: Text('Sign Up'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/signup');
              // onMenuItemSelected(1);
            },
          ),
        ],
      ),
    );
  }
}
