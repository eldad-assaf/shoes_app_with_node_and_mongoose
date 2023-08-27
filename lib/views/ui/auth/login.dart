import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoes_app_with_node_and_mongoose/controllers/login_provider.dart';
import 'package:shoes_app_with_node_and_mongoose/models/login_model.dart';
import 'package:shoes_app_with_node_and_mongoose/services/auth_helper.dart';
import 'package:shoes_app_with_node_and_mongoose/views/shared/appstyle.dart';
import 'package:shoes_app_with_node_and_mongoose/views/shared/custom_textfield.dart';
import 'package:shoes_app_with_node_and_mongoose/views/shared/reuseable_text.dart';
import 'package:shoes_app_with_node_and_mongoose/views/ui/auth/registration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50.h,
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.5,
            image: AssetImage('assets/images/bg.jpg'),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ReusableText(
                text: 'Welcome',
                style: appstyle(30, Colors.white, FontWeight.w600)),
            ReusableText(
                text: 'Fill in your details to login into your account',
                style: appstyle(14, Colors.white, FontWeight.normal)),
            SizedBox(
              height: 50.h,
            ),
            CustomTextField(
              hintText: 'Email',
              controller: email,
              validator: (email) {
                if (email!.isEmpty || !email.contains('@')) {
                  return 'Please provide a valid email';
                } else {
                  return null;
                }
              },
              keyboard: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomTextField(
              hintText: 'Password',
              controller: password,
              obscureText: authNotifier.isObsecure,
              suffixIcon: GestureDetector(
                onTap: () {
                  authNotifier.isObsecure = !authNotifier.isObsecure;
                },
                child: authNotifier.isObsecure
                    ? const Icon(Icons.visibility_off)
                    : const Icon(
                        Icons.visibility,
                      ),
              ),
              validator: (password) {
                if (password!.isEmpty || password.length < 7) {
                  return 'Password too weak';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Registration()));
                },
                child: ReusableText(
                    text: 'Register',
                    style: appstyle(14, Colors.white, FontWeight.normal)),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            GestureDetector(
              onTap: () async {
                final didLogin = await AuthHelper().login(LoginModel(
                    email: 'eldadassaf2@gmail.com', password: '123456789'));
                log('didLogin : $didLogin');
                if (didLogin) {
                  final prefs = await SharedPreferences.getInstance();
                  final token = prefs.getString('token');
                  if (token != null) {
                    await AuthHelper().getProfile(token);
                  }
                }
              },
              child: Container(
                height: 50.h,
                width: 300.w,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(0))),
                child: Center(
                  child: ReusableText(
                      text: 'L O G I N',
                      style: appstyle(18, Colors.black, FontWeight.bold)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
