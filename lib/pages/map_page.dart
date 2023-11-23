// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({super.key});

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   Completer<GoogleMapController> _controller = Completer();

//   static final CameraPosition _kGooglePlex = const CameraPosition(
//     target: LatLng(20.5937, 78.9629),
//     zoom: 14.4746,
//   );

//   //Adding markers
//   List<Marker> _marker = [];
//   List<Marker> _list = const [
//     Marker(
//       markerId: MarkerId('1'),
//       position: LatLng(20.5937, 78.9629),
//       infoWindow: InfoWindow(title: "My Current Location"),
//     )
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _marker.addAll(_list);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: GoogleMap(
//           initialCameraPosition: _kGooglePlex,
//           mapType: MapType.hybrid,
//           myLocationEnabled: true,
//           markers: Set<Marker>.of(_marker),
//           onMapCreated: (GoogleMapController controller) {
//             _controller.complete(controller);
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.location_on_outlined),
//           onPressed: () async {
//             GoogleMapController controller = await _controller.future;
//             controller.animateCamera(CameraUpdate.newCameraPosition(
//               CameraPosition(
//                 target: LatLng(28.612894, 77.229446),
//                 zoom: 13,
//                 // markers: Set<Marker>.of(_marker),
//               ),
//             ));
//           }),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  double latitude = 0.0;
  double longitude = 0.0;

  var locationMessage = "Email";

   Future<void> _requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      getLocation();
    } else {
      return Future.error('Location permission denied');
    }
  }

  void getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print("position------ : $position");

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      locationMessage =
          "Latitude: ${position.latitude} Longitude: ${position.longitude}";
    });

    _updateCamera();
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  _updateCamera() {
    LatLng newLocation = LatLng(latitude, longitude);
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: newLocation,
        zoom: 15.0,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Location App'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(latitude, longitude),
                zoom: 15.0,
              ),
              myLocationEnabled: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await _requestLocationPermission();
                    getLocation();
                  },
                  child: Text('Check My Live Location'),
                ),
                SizedBox(height: 10),
                Text('Latitude: $latitude, Longitude: $longitude'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
