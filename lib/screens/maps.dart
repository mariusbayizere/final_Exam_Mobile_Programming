// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:smart_home_app/components/consts.dart';
// import 'package:smart_home_app/main.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({super.key});

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   Location _locationController = Location();
//   final Completer<GoogleMapController> _mapController =
//       Completer<GoogleMapController>();
//   LatLng _kigaliCenter =
//       LatLng(-1.9441, 30.0619); // Coordinates for Kigali center
//   LatLng? _currentP;
//   Map<PolylineId, Polyline> polylines = {};
//   Map<PolygonId, Polygon> _polygons = {};
//   StreamSubscription<LocationData>? _locationSubscription;
//   bool _notificationSentOutSide = false;
//   bool _notificationSentInSide = false;

//   // Define predefined locations
//   final Map<String, LatLng> predefinedLocations = {
//     "Home": LatLng(-1.9501, 30.0587),
//     "School": LatLng(-1.9423, 30.0605)
//   };

//   @override
//   void initState() {
//     super.initState();
//     _createNotificationChannel();
//     _initializeLocation();
//     _createGeofence();
//   }

//   @override
//   void dispose() {
//     _locationSubscription?.cancel(); // Cancel location updates subscription
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: theme.hintColor,
//         title: Text(
//           'Your Location',
//           style: TextStyle(color: theme.primaryColor),
//         ),
//         iconTheme: IconThemeData(
//           color: theme.primaryColor,
//         ),
//       ),
//       body: _currentP == null
//           ? const Center(
//               child: Text("Loading..."),
//             )
//           : GoogleMap(
//               onMapCreated: ((GoogleMapController controller) =>
//                   _mapController.complete(controller)),
//               initialCameraPosition: CameraPosition(
//                 target: _kigaliCenter,
//                 zoom: 13,
//               ),
//               polygons: Set<Polygon>.of(_polygons.values),
//               markers: {
//                 Marker(
//                   markerId: MarkerId("_currentLocation"),
//                   icon: BitmapDescriptor.defaultMarker,
//                   position: _currentP!,
//                 ),
//               },
//               polylines: Set<Polyline>.of(polylines.values),
//             ),
//     );
//   }

//   Future<void> _initializeLocation() async {
//     await _checkPermissions();
//     await getLocationUpdates();
//   }

//   Future<void> _checkPermissions() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;

//     _serviceEnabled = await _locationController.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await _locationController.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }

//     _permissionGranted = await _locationController.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await _locationController.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//   }

//   Future<void> getLocationUpdates() async {
//     _locationSubscription = _locationController.onLocationChanged
//         .listen((LocationData currentLocation) {
//       if (currentLocation.latitude != null &&
//           currentLocation.longitude != null) {
//         LatLng newLocation =
//             LatLng(currentLocation.latitude!, currentLocation.longitude!);
//         updateMarkerAndCircle(newLocation);
//         _cameraToPosition(newLocation);
//         _checkGeofence(newLocation);
//       }
//     });
//   }

//   void updateMarkerAndCircle(LatLng newLocation) {
//     setState(() {
//       _currentP = newLocation;
//     });
//   }

//   Future<void> _cameraToPosition(LatLng pos) async {
//     final GoogleMapController controller = await _mapController.future;
//     CameraPosition _newCameraPosition = CameraPosition(
//       target: pos,
//       zoom: 13,
//     );
//     await controller.animateCamera(
//       CameraUpdate.newCameraPosition(_newCameraPosition),
//     );
//   }

//   void _createGeofence() {
//     List<LatLng> kigaliBoundaries = [
//       LatLng(-1.9740, 30.0274), // Northwest corner
//       LatLng(-1.9740, 30.1300), // Northeast corner
//       LatLng(-1.8980, 30.1300), // Southeast corner
//       LatLng(-1.8980, 30.0274), // Southwest corner
//     ];

//     PolygonId polygonId = PolygonId('kigali');
//     Polygon polygon = Polygon(
//       polygonId: polygonId,
//       points: kigaliBoundaries,
//       strokeWidth: 2,
//       strokeColor: Colors.red,
//       fillColor: Colors.red.withOpacity(0.3),
//     );

//     setState(() {
//       _polygons[polygonId] = polygon;
//     });
//   }

//   void _checkGeofence(LatLng currentLocation) {
//     bool isInsideGeofence = _isPointInPolygon(
//         currentLocation, _polygons[PolygonId('kigali')]!.points);

//     if (isInsideGeofence && !_notificationSentInSide) {
//       _triggerGeofenceNotification('inside');
//       _notificationSentInSide = true;
//       _notificationSentOutSide = false;
//     } else if (!isInsideGeofence && !_notificationSentOutSide) {
//       _triggerGeofenceNotification('outside');
//       _notificationSentOutSide = true;
//       _notificationSentInSide = false;
//     }

//     for (var entry in predefinedLocations.entries) {
//       String locationName = entry.key;
//       LatLng locationCoords = entry.value;
//       double distance = _calculateDistance(
//           currentLocation.latitude,
//           currentLocation.longitude,
//           locationCoords.latitude,
//           locationCoords.longitude);

//       // If within 100 meters
//       if (distance < 0.1) {
//         _triggerLocationNotification(locationName);
//       }
//     }
//   }

//   bool _isPointInPolygon(LatLng point, List<LatLng> polygon) {
//     int intersectCount = 0;
//     for (int j = 0; j < polygon.length - 1; j++) {
//       if (_rayCastIntersect(point, polygon[j], polygon[j + 1])) {
//         intersectCount++;
//       }
//     }
//     return ((intersectCount % 2) == 1); // odd = inside, even = outside;
//   }

//   bool _rayCastIntersect(LatLng point, LatLng vertA, LatLng vertB) {
//     double aY = vertA.latitude;
//     double bY = vertB.latitude;
//     double aX = vertA.longitude;
//     double bX = vertB.longitude;
//     double pY = point.latitude;
//     double pX = point.longitude;

//     if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
//       return false;
//     }

//     double m = (aY - bY) / (aX - bX);
//     double bee = (-aX) * m + aY;
//     double x = (pY - bee) / m;

//     return x > pX;
//   }

//   double _calculateDistance(
//       double lat1, double lon1, double lat2, double lon2) {
//     const double R = 6371; // Radius of the Earth in kilometers
//     double dLat = _degreesToRadians(lat2 - lat1);
//     double dLon = _degreesToRadians(lon2 - lon1);
//     double a = sin(dLat / 2) * sin(dLat / 2) +
//         cos(_degreesToRadians(lat1)) *
//             cos(_degreesToRadians(lat2)) *
//             sin(dLon / 2) *
//             sin(dLon / 2);
//     double c = 2 * atan2(sqrt(a), sqrt(1 - a));
//     double distance = R * c; // Distance in kilometers
//     return distance;
//   }

//   double _degreesToRadians(double degrees) {
//     return degrees * pi / 180;
//   }

//   void _triggerLocationNotification(String locationName) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'Location_channel', // Channel ID
//       'Location Notifications', // Channel name
//       channelDescription: 'This channel is used for location notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Location Alert',
//       'You are at $locationName',
//       platformChannelSpecifics,
//     );
//   }

//   void _triggerGeofenceNotification(String status) async {
//     String message = status == 'inside'
//         ? 'You have entered the geofenced area'
//         : 'You have exited the geofenced area';

//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'Geofence_channel', // Channel ID
//       'Geofence Notifications', // Channel name
//       channelDescription: 'This channel is used for geofence notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       1,
//       'Geofence Alert',
//       message,
//       platformChannelSpecifics,
//     );
//   }

//   void _createNotificationChannel() async {
//     const AndroidNotificationChannel locationChannel =
//         AndroidNotificationChannel(
//       'Location_channel', // id
//       'Location Notifications', // title
//       description:
//           'This channel is used for location notifications', // description
//       importance: Importance.high,
//     );

//     const AndroidNotificationChannel geofenceChannel =
//         AndroidNotificationChannel(
//       'Geofence_channel', // id
//       'Geofence Notifications', // title
//       description:
//           'This channel is used for geofence notifications', // description
//       importance: Importance.high,
//     );

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(locationChannel);

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(geofenceChannel);
//   }
// }

// ======================================= Home ==================================

//  New sending Notification to Home
// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:smart_home_app/components/consts.dart';
// import 'package:smart_home_app/main.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({super.key});

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   Location _locationController = Location();
//   final Completer<GoogleMapController> _mapController =
//       Completer<GoogleMapController>();
//   LatLng _kigaliCenter =
//       LatLng(-1.9441, 30.0619); // Coordinates for Kigali center
//   LatLng? _currentP;
//   Map<PolylineId, Polyline> polylines = {};
//   Map<PolygonId, Polygon> _polygons = {};
//   Map<CircleId, Circle> _circles = {};
//   StreamSubscription<LocationData>? _locationSubscription;
//   bool _notificationSentKicukiro = false;
//   bool _notificationSentGasabo = false;

//   // Define predefined locations
//   final Map<String, LatLng> predefinedLocations = {
//     "Home": LatLng(-1.9501, 30.0587),
//     "School": LatLng(-1.9423, 30.0605)
//   };

//   // Define district locations
//   final LatLng _kicukiroDistrict = LatLng(-1.9686, 30.0959);
//   final LatLng _gasaboDistrict = LatLng(-1.9294, 30.0821);

//   // Define notification channel
//   static const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.high,
//   );

//   @override
//   void initState() {
//     super.initState();
//     _createNotificationChannel();
//     _initializeLocation();
//     _createGeofence();
//   }

//   @override
//   void dispose() {
//     _locationSubscription?.cancel(); // Cancel location updates subscription
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: theme.hintColor,
//         title: Text(
//           'Your Location',
//           style: TextStyle(color: theme.primaryColor),
//         ),
//         iconTheme: IconThemeData(
//           color: theme.primaryColor,
//         ),
//       ),
//       body: _currentP == null
//           ? const Center(
//               child: Text("Loading..."),
//             )
//           : GoogleMap(
//               onMapCreated: ((GoogleMapController controller) =>
//                   _mapController.complete(controller)),
//               initialCameraPosition: CameraPosition(
//                 target: _kigaliCenter,
//                 zoom: 13,
//               ),
//               polygons: Set<Polygon>.of(_polygons.values),
//               markers: {
//                 Marker(
//                   markerId: MarkerId("_currentLocation"),
//                   icon: BitmapDescriptor.defaultMarker,
//                   position: _currentP!,
//                 ),
//               },
//               circles: Set<Circle>.of(_circles.values),
//               polylines: Set<Polyline>.of(polylines.values),
//             ),
//     );
//   }

//   Future<void> _initializeLocation() async {
//     await _checkPermissions();
//     await getLocationUpdates();
//   }

//   Future<void> _checkPermissions() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;

//     _serviceEnabled = await _locationController.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await _locationController.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }

//     _permissionGranted = await _locationController.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await _locationController.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//   }

//   Future<void> getLocationUpdates() async {
//     _locationSubscription = _locationController.onLocationChanged
//         .listen((LocationData currentLocation) {
//       if (currentLocation.latitude != null &&
//           currentLocation.longitude != null) {
//         LatLng newLocation =
//             LatLng(currentLocation.latitude!, currentLocation.longitude!);
//         updateMarkerAndCircle(newLocation);
//         _cameraToPosition(newLocation);
//         _checkGeofence(newLocation);
//       }
//     });
//   }

//   void updateMarkerAndCircle(LatLng newLocation) {
//     setState(() {
//       _currentP = newLocation;
//       _circles[CircleId("_currentLocationCircle")] = Circle(
//         circleId: CircleId("_currentLocationCircle"),
//         center: newLocation,
//         radius: 100, // radius in meters
//         fillColor: Colors.blue.withOpacity(0.5),
//         strokeColor: Colors.blue,
//         strokeWidth: 1,
//       );
//     });
//   }

//   Future<void> _cameraToPosition(LatLng pos) async {
//     final GoogleMapController controller = await _mapController.future;
//     CameraPosition _newCameraPosition = CameraPosition(
//       target: pos,
//       zoom: 13,
//     );
//     await controller.animateCamera(
//       CameraUpdate.newCameraPosition(_newCameraPosition),
//     );
//   }

//   void _createGeofence() {
//     List<LatLng> kigaliBoundaries = [
//       LatLng(-1.9740, 30.0274), // Northwest corner
//       LatLng(-1.9740, 30.1300), // Northeast corner
//       LatLng(-1.9150, 30.1300), // Southeast corner
//       LatLng(-1.9150, 30.0274), // Southwest corner
//     ];

//     PolygonId polygonId = PolygonId("Kigali");
//     Polygon polygon = Polygon(
//       polygonId: polygonId,
//       points: kigaliBoundaries,
//       strokeColor: Colors.blue,
//       strokeWidth: 2,
//       fillColor: Colors.blue.withOpacity(0.15),
//     );

//     setState(() {
//       _polygons[polygonId] = polygon;
//     });
//   }

//   void _checkGeofence(LatLng currentLocation) {
//     double distanceToKicukiro = _calculateDistance(
//         currentLocation.latitude,
//         currentLocation.longitude,
//         _kicukiroDistrict.latitude,
//         _kicukiroDistrict.longitude);
//     double distanceToGasabo = _calculateDistance(
//         currentLocation.latitude,
//         currentLocation.longitude,
//         _gasaboDistrict.latitude,
//         _gasaboDistrict.longitude);

//     print('Distance to Kicukiro: $distanceToKicukiro');
//     print('Distance to Gasabo: $distanceToGasabo');

//     if (distanceToKicukiro < 5.0 && !_notificationSentKicukiro) {
//       // Lowered threshold for testing
//       print('Triggering Kicukiro notification');
//       _triggerLocationNotification('Hi Marius, you have reached home.');
//       _notificationSentKicukiro = true;
//       _notificationSentGasabo = false;
//     } else if (distanceToGasabo < 5.0 && !_notificationSentGasabo) {
//       // Lowered threshold for testing
//       print('Triggering Gasabo notification');
//       _triggerLocationNotification('Hi Marius, you are in school Auca.');
//       _notificationSentGasabo = true;
//       _notificationSentKicukiro = false;
//     }
//   }

//   double _calculateDistance(lat1, lon1, lat2, lon2) {
//     var p = 0.017453292519943295;
//     var c = cos;
//     var a = 0.5 -
//         c((lat2 - lat1) * p) / 2 +
//         c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//     return 12742 * asin(sqrt(a));
//   }

//   void _triggerLocationNotification(String message) {
//     String title = 'Location Alert';
//     String body = message;

//     _showNotification(title, body);
//   }

//   void _showNotification(String title, String body) {
//     flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           channelDescription: channel.description,
//           importance: Importance.high,
//           priority: Priority.high,
//           ticker: 'ticker',
//         ),
//       ),
//     );
//   }

//   void _createNotificationChannel() async {
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     final InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//   }
// }

//  New Bad version

// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:smart_home_app/components/consts.dart';
// import 'package:smart_home_app/main.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({super.key});

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   Location _locationController = Location();
//   final Completer<GoogleMapController> _mapController =
//       Completer<GoogleMapController>();
//   LatLng _kigaliCenter =
//       LatLng(-1.9441, 30.0619); // Coordinates for Kigali center
//   LatLng? _currentP;
//   Map<PolylineId, Polyline> polylines = {};
//   Map<PolygonId, Polygon> _polygons = {};
//   Map<CircleId, Circle> _circles = {};
//   StreamSubscription<LocationData>? _locationSubscription;
//   bool _notificationSentKicukiro = false;
//   bool _notificationSentGasabo = false;

//   // Define predefined locations
//   final Map<String, LatLng> predefinedLocations = {
//     "Home": LatLng(-1.9501, 30.0587),
//     "School": LatLng(-1.9423, 30.1030) // Updated coordinates for AUCA
//   };

//   // Define district locations
//   final LatLng _kicukiroDistrict = LatLng(-1.9686, 30.0959);
//   final LatLng _gasaboDistrict = LatLng(-1.9294, 30.0821);

//   // Define notification channel
//   static const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.high,
//   );

//   @override
//   void initState() {
//     super.initState();
//     _createNotificationChannel();
//     _initializeLocation();
//     _createGeofence();
//   }

//   @override
//   void dispose() {
//     _locationSubscription?.cancel(); // Cancel location updates subscription
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: theme.hintColor,
//         title: Text(
//           'Your Location',
//           style: TextStyle(color: theme.primaryColor),
//         ),
//         iconTheme: IconThemeData(
//           color: theme.primaryColor,
//         ),
//       ),
//       body: _currentP == null
//           ? const Center(
//               child: Text("Loading..."),
//             )
//           : GoogleMap(
//               onMapCreated: ((GoogleMapController controller) =>
//                   _mapController.complete(controller)),
//               initialCameraPosition: CameraPosition(
//                 target: _kigaliCenter,
//                 zoom: 13,
//               ),
//               polygons: Set<Polygon>.of(_polygons.values),
//               markers: {
//                 Marker(
//                   markerId: MarkerId("_currentLocation"),
//                   icon: BitmapDescriptor.defaultMarker,
//                   position: _currentP!,
//                 ),
//               },
//               circles: Set<Circle>.of(_circles.values),
//               polylines: Set<Polyline>.of(polylines.values),
//             ),
//     );
//   }

//   Future<void> _initializeLocation() async {
//     await _checkPermissions();
//     await getLocationUpdates();
//   }

//   Future<void> _checkPermissions() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;

//     _serviceEnabled = await _locationController.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await _locationController.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }

//     _permissionGranted = await _locationController.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await _locationController.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//   }

//   Future<void> getLocationUpdates() async {
//     _locationSubscription = _locationController.onLocationChanged
//         .listen((LocationData currentLocation) {
//       if (currentLocation.latitude != null &&
//           currentLocation.longitude != null) {
//         LatLng newLocation =
//             LatLng(currentLocation.latitude!, currentLocation.longitude!);
//         updateMarkerAndCircle(newLocation);
//         _cameraToPosition(newLocation);
//         _checkGeofence(newLocation);
//       }
//     });
//   }

//   void updateMarkerAndCircle(LatLng newLocation) {
//     setState(() {
//       _currentP = newLocation;
//       _circles[CircleId("_currentLocationCircle")] = Circle(
//         circleId: CircleId("_currentLocationCircle"),
//         center: newLocation,
//         radius: 100, // radius in meters
//         fillColor: Colors.blue.withOpacity(0.5),
//         strokeColor: Colors.blue,
//         strokeWidth: 1,
//       );
//     });
//   }

//   Future<void> _cameraToPosition(LatLng pos) async {
//     final GoogleMapController controller = await _mapController.future;
//     CameraPosition _newCameraPosition = CameraPosition(
//       target: pos,
//       zoom: 13,
//     );
//     await controller.animateCamera(
//       CameraUpdate.newCameraPosition(_newCameraPosition),
//     );
//   }

//   void _createGeofence() {
//     List<LatLng> kigaliBoundaries = [
//       LatLng(-1.9740, 30.0274), // Northwest corner
//       LatLng(-1.9740, 30.1300), // Northeast corner
//       LatLng(-1.9150, 30.1300), // Southeast corner
//       LatLng(-1.9150, 30.0274), // Southwest corner
//     ];

//     PolygonId polygonId = PolygonId("Kigali");
//     Polygon polygon = Polygon(
//       polygonId: polygonId,
//       points: kigaliBoundaries,
//       strokeColor: Colors.blue,
//       strokeWidth: 2,
//       fillColor: Colors.blue.withOpacity(0.15),
//     );

//     setState(() {
//       _polygons[polygonId] = polygon;
//     });
//   }

//   void _checkGeofence(LatLng currentLocation) {
//     double distanceToKicukiro = _calculateDistance(
//         currentLocation.latitude,
//         currentLocation.longitude,
//         _kicukiroDistrict.latitude,
//         _kicukiroDistrict.longitude);
//     double distanceToGasabo = _calculateDistance(
//         currentLocation.latitude,
//         currentLocation.longitude,
//         _gasaboDistrict.latitude,
//         _gasaboDistrict.longitude);

//     print('Distance to Kicukiro: $distanceToKicukiro');
//     print('Distance to Gasabo: $distanceToGasabo');

//     if (distanceToKicukiro < 5.0 && !_notificationSentKicukiro) {
//       // Lowered threshold for testing
//       print('Triggering Kicukiro notification');
//       _triggerLocationNotification('Hi Marius, you have reached home.');
//       _notificationSentKicukiro = true;
//       _notificationSentGasabo = false;
//     } else if (distanceToGasabo < 5.0 && !_notificationSentGasabo) {
//       // Lowered threshold for testing
//       print('Triggering Gasabo notification');
//       _triggerLocationNotification('Hi Marius, you are in school Auca.');
//       _notificationSentGasabo = true;
//       _notificationSentKicukiro = false;
//     }
//   }

//   double _calculateDistance(lat1, lon1, lat2, lon2) {
//     var p = 0.017453292519943295;
//     var c = cos;
//     var a = 0.5 -
//         c((lat2 - lat1) * p) / 2 +
//         c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//     return 12742 * asin(sqrt(a));
//   }

//   void _triggerLocationNotification(String message) {
//     String title = 'Location Alert';
//     String body = message;

//     _showNotification(title, body);
//   }

//   void _showNotification(String title, String body) {
//     flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           channelDescription: channel.description,
//           importance: Importance.high,
//           priority: Priority.high,
//           ticker: 'ticker',
//         ),
//       ),
//     );
//   }

//   void _createNotificationChannel() async {
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     final InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//   }
// }

// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:smart_home_app/components/consts.dart';
// import 'package:smart_home_app/main.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({super.key});

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   Location _locationController = Location();
//   final Completer<GoogleMapController> _mapController =
//       Completer<GoogleMapController>();
//   LatLng _kigaliCenter =
//       LatLng(-1.9441, 30.0619); // Coordinates for Kigali center
//   LatLng? _currentP;
//   Map<PolylineId, Polyline> polylines = {};
//   Map<PolygonId, Polygon> _polygons = {};
//   Map<CircleId, Circle> _circles = {};
//   StreamSubscription<LocationData>? _locationSubscription;
//   bool _notificationSentKicukiro = false;
//   bool _notificationSentGasabo = false;

//   // Define predefined locations
//   final Map<String, LatLng> predefinedLocations = {
//     // "Home": LatLng(-1.9501, 30.0587),
//     // I/flutter ( 5804): Current Location: (-1.9555326, 30.1041764)
//     "Home": LatLng(-1.9609633, 30.1175493),
//     //  "School": LatLng(-1.9423, 30.1030) // Updated coordinates for AUCA
//     "School": LatLng(-1.9555326, 30.1041764) // Updated coordinates for AUCA
//   };

//   // Define district locations
//   final LatLng _kicukiroDistrict = LatLng(-1.9686, 30.0959);
//   final LatLng _gasaboDistrict = LatLng(-1.9294, 30.0821);
//   // final LatLng _gasaboDistrict = LatLng(-1.9609633, 30.1175493);
//   // Define notification channel
//   static const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.high,
//   );

//   @override
//   void initState() {
//     super.initState();
//     _createNotificationChannel();
//     _initializeLocation();
//     _createGeofence();
//   }

//   @override
//   void dispose() {
//     _locationSubscription?.cancel(); // Cancel location updates subscription
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: theme.hintColor,
//         title: Text(
//           'Your Location',
//           style: TextStyle(color: theme.primaryColor),
//         ),
//         iconTheme: IconThemeData(
//           color: theme.primaryColor,
//         ),
//       ),
//       body: _currentP == null
//           ? const Center(
//               child: Text("Loading..."),
//             )
//           : GoogleMap(
//               onMapCreated: ((GoogleMapController controller) =>
//                   _mapController.complete(controller)),
//               initialCameraPosition: CameraPosition(
//                 target: _kigaliCenter,
//                 zoom: 13,
//               ),
//               polygons: Set<Polygon>.of(_polygons.values),
//               markers: {
//                 Marker(
//                   markerId: MarkerId("_currentLocation"),
//                   icon: BitmapDescriptor.defaultMarker,
//                   position: _currentP!,
//                 ),
//               },
//               circles: Set<Circle>.of(_circles.values),
//               polylines: Set<Polyline>.of(polylines.values),
//             ),
//     );
//   }

//   Future<void> _initializeLocation() async {
//     await _checkPermissions();
//     await getLocationUpdates();
//   }

//   Future<void> _checkPermissions() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;

//     _serviceEnabled = await _locationController.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await _locationController.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }

//     _permissionGranted = await _locationController.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await _locationController.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//   }

//   Future<void> getLocationUpdates() async {
//     _locationSubscription = _locationController.onLocationChanged
//         .listen((LocationData currentLocation) {
//       if (currentLocation.latitude != null &&
//           currentLocation.longitude != null) {
//         LatLng newLocation =
//             LatLng(currentLocation.latitude!, currentLocation.longitude!);
//         updateMarkerAndCircle(newLocation);
//         _cameraToPosition(newLocation);
//         _checkGeofence(newLocation);

//         // Print the current location coordinates to the terminal
//         print(
//             'Current Location: (${newLocation.latitude}, ${newLocation.longitude})');
//       }
//     });
//   }

//   void updateMarkerAndCircle(LatLng newLocation) {
//     setState(() {
//       _currentP = newLocation;
//       _circles[CircleId("_currentLocationCircle")] = Circle(
//         circleId: CircleId("_currentLocationCircle"),
//         center: newLocation,
//         radius: 100, // radius in meters
//         fillColor: Colors.blue.withOpacity(0.5),
//         strokeColor: Colors.blue,
//         strokeWidth: 1,
//       );
//     });
//   }

//   Future<void> _cameraToPosition(LatLng pos) async {
//     final GoogleMapController controller = await _mapController.future;
//     CameraPosition _newCameraPosition = CameraPosition(
//       target: pos,
//       zoom: 13,
//     );
//     await controller.animateCamera(
//       CameraUpdate.newCameraPosition(_newCameraPosition),
//     );
//   }

//   void _createGeofence() {
//     List<LatLng> kigaliBoundaries = [
//       LatLng(-1.9740, 30.0274), // Northwest corner
//       LatLng(-1.9740, 30.1300), // Northeast corner
//       LatLng(-1.9150, 30.1300), // Southeast corner
//       LatLng(-1.9150, 30.0274), // Southwest corner
//     ];

//     PolygonId polygonId = PolygonId("Kigali");
//     Polygon polygon = Polygon(
//       polygonId: polygonId,
//       points: kigaliBoundaries,
//       strokeColor: Colors.blue,
//       strokeWidth: 2,
//       fillColor: Colors.blue.withOpacity(0.15),
//     );

//     setState(() {
//       _polygons[polygonId] = polygon;
//     });
//   }

//   void _checkGeofence(LatLng currentLocation) {
//     double distanceToKicukiro = _calculateDistance(
//         currentLocation.latitude,
//         currentLocation.longitude,
//         _kicukiroDistrict.latitude,
//         _kicukiroDistrict.longitude);
//     double distanceToGasabo = _calculateDistance(
//         currentLocation.latitude,
//         currentLocation.longitude,
//         _gasaboDistrict.latitude,
//         _gasaboDistrict.longitude);

//     print('Distance to Kicukiro: $distanceToKicukiro');
//     print('Distance to Gasabo: $distanceToGasabo');

//     if (distanceToKicukiro < 5.0 && !_notificationSentKicukiro) {
//       // Lowered threshold for testing
//       print('Triggering Kicukiro notification');
//       _triggerLocationNotification('Hi Marius, you have reached home.');
//       _notificationSentKicukiro = true;
//       _notificationSentGasabo = false;
//     } else if (distanceToGasabo < 5.0 && !_notificationSentGasabo) {
//       // Lowered threshold for testing
//       print('Triggering Gasabo notification');
//       _triggerLocationNotification('Hi Marius, you are in school Auca.');
//       _notificationSentGasabo = true;
//       _notificationSentKicukiro = false;
//     }
//   }

//   double _calculateDistance(lat1, lon1, lat2, lon2) {
//     var p = 0.017453292519943295;
//     var c = cos;
//     var a = 0.5 -
//         c((lat2 - lat1) * p) / 2 +
//         c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//     return 12742 * asin(sqrt(a));
//   }

//   void _triggerLocationNotification(String message) {
//     String title = 'Location Alert';
//     String body = message;

//     _showNotification(title, body);
//   }

//   void _showNotification(String title, String body) {
//     flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           channelDescription: channel.description,
//           importance: Importance.high,
//           priority: Priority.high,
//           ticker: 'ticker',
//         ),
//       ),
//     );
//   }

//   void _createNotificationChannel() async {
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     final InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//   }
// }

//  new version

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:smart_home_prject_app/components/consts.dart';
import 'package:smart_home_prject_app/main.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location _locationController = Location();
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  LatLng _kigaliCenter =
      LatLng(-1.9441, 30.0619); // Coordinates for Kigali center
  LatLng? _currentP;
  Map<PolylineId, Polyline> polylines = {};
  Map<PolygonId, Polygon> _polygons = {};
  Map<CircleId, Circle> _circles = {};
  StreamSubscription<LocationData>? _locationSubscription;
  bool _notificationSentHome = false;
  bool _notificationSentSchool = false;

  // Define predefined locations
  final Map<String, LatLng> predefinedLocations = {
    "Home": LatLng(-1.9609633, 30.1175493),
    "School": LatLng(-1.9554986, 30.1042431) // Coordinates for AUCA
  };

  // Define notification channel
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  @override
  void initState() {
    super.initState();
    _createNotificationChannel();
    _initializeLocation();
    _createGeofence();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel(); // Cancel location updates subscription
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.hintColor,
        title: Text(
          'Your Location',
          style: TextStyle(color: theme.primaryColor),
        ),
        iconTheme: IconThemeData(
          color: theme.primaryColor,
        ),
      ),
      body: _currentP == null
          ? const Center(
              child: Text("Loading..."),
            )
          : GoogleMap(
              onMapCreated: ((GoogleMapController controller) =>
                  _mapController.complete(controller)),
              initialCameraPosition: CameraPosition(
                target: _kigaliCenter,
                zoom: 13,
              ),
              polygons: Set<Polygon>.of(_polygons.values),
              markers: {
                Marker(
                  markerId: MarkerId("_currentLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _currentP!,
                ),
              },
              circles: Set<Circle>.of(_circles.values),
              polylines: Set<Polyline>.of(polylines.values),
            ),
    );
  }

  Future<void> _initializeLocation() async {
    await _checkPermissions();
    await getLocationUpdates();
  }

  Future<void> _checkPermissions() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<void> getLocationUpdates() async {
    _locationSubscription = _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        LatLng newLocation =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
        updateMarkerAndCircle(newLocation);
        _cameraToPosition(newLocation);
        _checkGeofence(newLocation);

        // Print the current location coordinates to the terminal
        print(
            'Current Location: (${newLocation.latitude}, ${newLocation.longitude})');
      }
    });
  }

  void updateMarkerAndCircle(LatLng newLocation) {
    setState(() {
      _currentP = newLocation;
      _circles[CircleId("_currentLocationCircle")] = Circle(
        circleId: CircleId("_currentLocationCircle"),
        center: newLocation,
        radius: 100, // radius in meters
        fillColor: Colors.blue.withOpacity(0.5),
        strokeColor: Colors.blue,
        strokeWidth: 1,
      );
    });
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  void _createGeofence() {
    List<LatLng> kigaliBoundaries = [
      LatLng(-1.9740, 30.0274), // Northwest corner
      LatLng(-1.9740, 30.1300), // Northeast corner
      LatLng(-1.9150, 30.1300), // Southeast corner
      LatLng(-1.9150, 30.0274), // Southwest corner
    ];

    PolygonId polygonId = PolygonId("Kigali");
    Polygon polygon = Polygon(
      polygonId: polygonId,
      points: kigaliBoundaries,
      strokeColor: Colors.blue,
      strokeWidth: 2,
      fillColor: Colors.blue.withOpacity(0.15),
    );

    setState(() {
      _polygons[polygonId] = polygon;
    });
  }

  void _checkGeofence(LatLng currentLocation) {
    double distanceToHome = _calculateDistance(
        currentLocation.latitude,
        currentLocation.longitude,
        predefinedLocations["Home"]!.latitude,
        predefinedLocations["Home"]!.longitude);
    double distanceToSchool = _calculateDistance(
        currentLocation.latitude,
        currentLocation.longitude,
        predefinedLocations["School"]!.latitude,
        predefinedLocations["School"]!.longitude);

    print('Distance to Home: $distanceToHome');
    print('Distance to School: $distanceToSchool');

    if (distanceToHome < 0.05) {
      print('Within 50 meters of Home');
    }
    if (distanceToSchool < 0.05) {
      print('Within 50 meters of School');
    }

    if (distanceToHome < 0.05 && !_notificationSentHome) {
      print('Triggering Home notification');
      _triggerLocationNotification('Hi Marius, you have reached home.');
      _notificationSentHome = true;
      _notificationSentSchool = false;
    } else if (distanceToSchool < 0.05 && !_notificationSentSchool) {
      print('Triggering School notification');
      _triggerLocationNotification('Hi Marius, you are in school AUCA.');
      _notificationSentSchool = true;
      _notificationSentHome = false;
    } else if (distanceToHome > 0.1 && distanceToSchool > 0.1) {
      // Reset notifications if user is outside both predefined locations
      _notificationSentHome = false;
      _notificationSentSchool = false;
    }
  }

  double _calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  void _triggerLocationNotification(String message) {
    String title = 'Location Alert';
    String body = message;

    _showNotification(title, body);
  }

  void _showNotification(String title, String body) {
    flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.high,
          priority: Priority.high,
          ticker: 'ticker',
        ),
      ),
    );
  }

  void _createNotificationChannel() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
}
