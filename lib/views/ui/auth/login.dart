import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            CustomTextField(hintText: 'Email', controller: email),
            SizedBox(
              height: 15.h,
            ),
            CustomTextField(hintText: 'Password', controller: password),
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
          ],
        ),
      ),
    );
  }
}
