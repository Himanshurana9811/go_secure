// import 'dart:typed_data';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// // import 'package:flutter/material.dart';
// final currentUser = FirebaseAuth.instance.currentUser;
// final FirebaseStorage _storage = FirebaseStorage.instance;
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// class AddData {
//   Future<String> uploadImageToStorage(String childName, Uint8List file) async {
//     Reference ref = _storage.ref().child(childName).child('id');

//     UploadTask uploadTask = ref.putData(file);

//     TaskSnapshot snapshot = await uploadTask;
//     String downloadUrl = await snapshot.ref.getDownloadURL();

//     return downloadUrl;
//   }

//   Future<String> saveData({
//     required Uint8List file,
//     required String fname,
//     required String lname,
//     required int age,
//     required String address,
//     required int mobile,
//   }) async {
//     String resp = "Some Error Occurred";
//     try {
//       if (fname.isNotEmpty ||
//           lname.isNotEmpty ||
//           age.isNaN ||
//           address.isNotEmpty ||
//           mobile.isNaN) {
//         //to Store image Data
//         String imageUrl = await uploadImageToStorage('profileImage', file);

//         //To store other Data
//         Future<void> addUserDetails(String firstName, String lastName,
//             String address, int age, int mobile) async {
//           await _firestore.collection('User').get({
//                 'fname': fname,
//                 'lname': lname,
//                 'age': age,
//                 'address': address,
//                 'mobile': mobile,
//                 'imageLink': imageUrl,
//               } as GetOptions?);

//           resp = 'Success';
//         }
//       }
//     } catch (e) {
//       resp = e.toString();
//       print("Error On Adding the user Detail to fireStore");
//     }
//     return resp;
//   }
// }
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// import 'package:flutter/material.dart';
final currentUser = FirebaseAuth.instance.currentUser;
final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class AddData {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName).child('id');

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<void> addUserDetails(String fname, String lname, int age, String address, int mobile, String imageUrl) async {
    await _firestore.collection('User').add({
      'fname': fname,
      'lname': lname,
      'age': age,
      'address': address,
      'mobile': mobile,
      'imageLink': imageUrl,
    });
  }

  Future<String> saveData({
    required Uint8List file,
    required String fname,
    required String lname,
    required int age,
    required String address,
    required int mobile,
  }) async {
    String resp = "Some Error Occurred";
    try {
      if (fname.isNotEmpty &&
          lname.isNotEmpty &&
          !age.isNaN &&
          address.isNotEmpty &&
          !mobile.isNaN) {
        // Store image Data
        String imageUrl = await uploadImageToStorage('profileImage', file);

        // Store other Data
        await addUserDetails(fname, lname, age, address, mobile, imageUrl);

        resp = 'Success';
      }
    } catch (e) {
      resp = e.toString();
      print("Error On Adding the user Detail to Firestore");
    }
    return resp;
  }
}
