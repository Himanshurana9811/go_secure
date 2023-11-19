import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_secure/components/my_drawer.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({
    super.key,
  });

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
                Text(user!['email']),
                Text(user['username']),
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
