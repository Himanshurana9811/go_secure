import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_secure/pages/dashboard_page.dart';
import 'package:go_secure/pages/detail_page.dart';
import 'package:go_secure/auth/login_register.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //user is logged in
            if (snapshot.hasData) {
              return DashboardPage();
            }
            //user not logged in
            else {
              return const LoginRegister();
            }
          }),
    );
  }
}
