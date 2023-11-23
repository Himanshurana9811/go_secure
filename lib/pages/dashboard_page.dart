import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_secure/components/my_button.dart';
import 'package:go_secure/components/my_drawer.dart';
import 'package:go_secure/helper/helper_function.dart';
// import 'package:go_secure/pages/map_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({
    super.key,
  });

  Future<void> _requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      getLocation();
    } else {
      // Handle denied permission more gracefully, e.g., show a dialog.
      print('Location permission denied');
    }
  }

  void getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Handle disabled location services more gracefully, e.g., show a dialog.
      print('Location services are disabled.');
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print("position--------- $position");
    } catch (e) {
      // Handle exception
      // Do something with the position...
    } catch (e) {
      // Handle errors when getting the current location.
      print('Error getting location: $e');
    }
  }

  Future<void> sos() async {
    try {
      await _requestLocationPermission();
      getLocation();
      // Implement SOS sending code here...
    } catch (e) {
      // Handle errors during SOS functionality, e.g., show a dialog.
      print('Error during SOS: $e');
    }
  }

  //current logged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  //future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("User")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      backgroundColor: Colors.grey[300],
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          //loading..
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //error
          else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          //data
          else if (snapshot.hasData) {
            //extract Data
            Map<String, dynamic>? user = snapshot.data!.data();

            return Column(
              children: [
                const SizedBox(height: 30),
                const Text(
                  'DETAILS',
                  style: TextStyle(
                    color: Color.fromARGB(255, 90, 89, 89),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //All Details Below From FireBase
                const SizedBox(height: 50),
                Text(user!['email']),
                const SizedBox(height: 20),
                Text(user['fname']),
                const SizedBox(height: 20),
                Text(user['lname']),
                const SizedBox(height: 20),
                Text(user['age'].toString()),
                const SizedBox(height: 20),
                Text(user['mobile'].toString()),
                const SizedBox(height: 20),
                Text(user['address']),

                const SizedBox(height: 100),
                //sos in button to send the sos location to the mobile number above
                MyButton(
                  onTap: sos,
                  buttonName: "SOS!",
                ),
              ],
            );
          } else {
            return Text("No Data");
          }
        },
      ),
    );
  }
}
