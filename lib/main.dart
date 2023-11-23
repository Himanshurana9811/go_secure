import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_secure/auth/auth.dart';
import 'package:go_secure/auth/login_register.dart';
import 'package:go_secure/firebase_options.dart';
import 'package:go_secure/pages/dashboard_page.dart';
import 'package:go_secure/pages/detail_page.dart';
import 'package:go_secure/pages/map_page.dart';
// import 'pages/index_page.dart';
// import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),

      routes: {
        '/login_register_page': (context) => const LoginRegister(),
        '/home_page': (content) => DashboardPage(),
        '/detail_page': (context) => const DetailPage(),
      },

      // home: MapPage(),

      // },
      // home: const LoginRegister(),
      // home: IndexPage(),
      // home: LoginPage(),
      // home: RegistrationPage(),
      // home: DetailPage(),
    );
  }
}
