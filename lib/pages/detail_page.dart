import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_secure/components/my_image.dart';
import 'package:go_secure/components/my_textfield.dart';
import 'package:go_secure/components/my_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_secure/resources/add_data.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  //Image variable
  Uint8List? _image;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  //Input Image
  Future<void> selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  //Submit method
  // Future submit() async {
  //   String fname = _firstNameController.value.text;
  //   String lname = _lastNameController.value.text;
  //   int age = int.parse(_ageController.value.text);
  //   String address = _addressController.value.text;
  //   int mobile = int.parse(_mobileController.value.text);

  //   String resp = await AddData().saveData(
  //       file: _image!,
  //       fname: fname,
  //       lname: lname,
  //       age: age,
  //       address: address,
  //       mobile: mobile);

  //   addUserDetails(fname, lname, address, age, mobile);
  Future<void> onSubmit() async {
    String resp = await AddData().saveData({
  'fname': _firstNameController.value.text,
  'lname': _lastNameController.value.text,
  'age': int.tryParse(_ageController.value.text) ?? 0,
  'address': _addressController.value.text,
  'mobile': int.tryParse(_mobileController.value.text) ?? 0,
});

// Check the response and handle accordingly
if (resp == 'Success') {
  // Data saved successfully, perform any additional actions
} else {
  // Handle the error, show a message, etc.
  print('Error: $resp');
}

    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    //call addUser Detail
    // addUserDetails(
    //   _firstNameController.text.trim(),
    //   _lastNameController.text.trim(),
    //   _addressController.text.trim(),
    //   int.parse(_ageController.text.trim()),
    //   int.parse(_mobileController.text.trim()),
    // );

    // pop Looading circle
    if (context.mounted) Navigator.pop(context);
  }

  // Future<void> addUserDetails(String firstName, String lastName, String address,
  //     int age, int mobile) async {
  //   //Add User Details
  //   await FirebaseFirestore.instance.collection("User").add({
  //     'first name': firstName,
  //     'last Name': lastName,
  //     'address': address,
  //     'age': age,
  //     'mobile': mobile,
  //   });
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      // appBar: AppBar(
      //   title: Text("Details"),
      //   backgroundColor: Colors.blueGrey,
      //   elevation: 0,
      // ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //user image
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : CircleAvatar(
                            radius: 65,
                            backgroundImage: NetworkImage(
                                'https://w7.pngwing.com/pngs/717/24/png-transparent-computer-icons-user-profile-user-account-avatar-heroes-silhouette-black-thumbnail.png'),
                          ),
                    Positioned(
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                      bottom: -10,
                      left: 80,
                    )
                  ],
                ),

                //Hello Message
                const Text(
                  "HELLO THERE",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                  ),
                ),

                const SizedBox(height: 25),
                //Text
                const Text(
                  'Enter Below Details!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 20),
                //FirstName TextField
                MyTextField(
                  controller: _firstNameController,
                  hintText: 'First Name',
                  obscureText: false,
                ),

                const SizedBox(height: 20),
                //LastName TextField
                MyTextField(
                  controller: _lastNameController,
                  hintText: 'Last Name',
                  obscureText: false,
                ),

                const SizedBox(height: 20),
                //Age TextField
                MyTextField(
                  controller: _ageController,
                  hintText: 'Age',
                  obscureText: false,
                ),

                const SizedBox(height: 20),
                //Address TextField
                MyTextField(
                  controller: _addressController,
                  hintText: 'Address',
                  obscureText: false,
                ),

                const SizedBox(height: 20),
                //Mobile Number TextField
                MyTextField(
                  controller: _mobileController,
                  hintText: 'Mobile Number',
                  obscureText: false,
                ),

                const SizedBox(height: 25),
                //Submit button
                MyButton(
                  onTap: onSubmit,
                  buttonName: "Submit",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
