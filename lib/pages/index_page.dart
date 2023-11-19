import 'package:flutter/material.dart';
import 'package:go_secure/components/my_button.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});
  //login method
  void login() {}
  //register method
  void register() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('GoSecure'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'lib/images/logoScoreUp.png',
                width: 400,
                height: 200,
              ),
              const SizedBox(height: 100),
              //Login and Register Buttons
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                      onTap: login,
                      buttonName: "Login",
                    ),

                    const SizedBox(height: 15),
                    // Register Button
                    MyButton(
                      onTap: register,
                      buttonName: "Register",
                    ),

                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login as:',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Admin',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
