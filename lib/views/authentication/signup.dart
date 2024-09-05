import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_template/views/authentication/signin.dart';
import 'package:get/get.dart';

import '../../controllers/authetication/auth_controller.dart';
class SignUpScreen extends GetView<AuthController> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthController authController = Get.find();

  SignUpScreen({super.key});

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //controller.callAuthenticateAPI(NetworkConstantSuperApp.AUTHENTICATE);
    return Scaffold(
      body: Container(

        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Scrollbar(
              thumbVisibility: false,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        authController.createUser(emailController.text, passwordController.text);
                      },
                      child: Text('Register'),
                    ),
                    SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () {
                        Get.to(() =>SignInScreen());
                      },
                      child: Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

      ),

    );
  }


}