import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_secure/components/my_textfield.dart';
import 'package:go_secure/components/my_button.dart';
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({
    super.key,
  });

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }
  //reset button functionality
  Future passwordReset() async{
    try{
      await FirebaseAuth.instance.
      sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              content: Text("Password reset link sent! Check your Email"),
            );
          }
      );
    } on FirebaseAuthException catch (e){
      print(e);
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        }
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0 ),
            child: Text(
                "Enter Your Email and we will send you a password reset Link.",
                textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),

          const SizedBox(height: 20),
          //email textfeild
          MyTextField(
            controller: _emailController,
            hintText: 'Email',
            obscureText: false,
          ),

          const SizedBox(height: 20),
          //button
          MyButton(
            onTap: passwordReset,
            buttonName: "Reset",
          ),
        ],
      ),
    );
  }
}
