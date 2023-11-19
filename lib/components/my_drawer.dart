import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  //logout user
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: Colors.white,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          children: [
            DrawerHeader(
              child: Icon(
                Icons.favorite,
                color: Colors.black12,
              ),
            ),

            const SizedBox(height: 25),
            //home tile
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.home_outlined,
                  color: Colors.black12,
                ),
                title: const Text("H O M E"),
                onTap: () {
                  //This is already the DashBoard Page so just pop the Drawer
                  Navigator.pop(context);

                  //navigate to detail Page
                  Navigator.pushNamed(context, '/home_page');
                },
              ),
            ),

            //Details tile
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.black12,
                ),
                title: const Text("D E T A I L S"),
                onTap: () {
                  Navigator.pop(context);

                  //navigate to details page
                  Navigator.pushNamed(context, '/detail_page');
                },
              ),
            ),
          ],
        ),

        //Logout tile
        Padding(
          padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
          child: ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.black12,
            ),
            title: Text("L O G O U T"),
            onTap: () {
              //pop Drawer
              Navigator.pop(context);
              //logout
              logout();
            },
          ),
        )
      ]),
    );
  }
}
