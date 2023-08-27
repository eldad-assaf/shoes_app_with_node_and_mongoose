import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app_with_node_and_mongoose/models/signup_model.dart';
import 'package:shoes_app_with_node_and_mongoose/services/auth_helper.dart';

import '../../../controllers/login_provider.dart';
import '../../shared/appstyle.dart';
import '../../shared/custom_textfield.dart';
import '../../shared/reuseable_text.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

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
                text: 'Hello!',
                style: appstyle(30, Colors.white, FontWeight.w600)),
            ReusableText(
                text: 'Fill in your details to sign up for an account',
                style: appstyle(14, Colors.white, FontWeight.normal)),
            SizedBox(
              height: 50.h,
            ),
            CustomTextField(
              hintText: 'Username',
              controller: username,
              validator: (username) {
                if (username!.isEmpty) {
                  return 'Please provide a valid username';
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
                  Navigator.pop(context);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const LoginPage()));
                },
                child: ReusableText(
                    text: 'Login',
                    style: appstyle(14, Colors.white, FontWeight.normal)),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            GestureDetector(
              onDoubleTap: () async {
                await AuthHelper().signup(SignupModel(
                    username: username.text,
                    email: email.text,
                    password: password.text));
              },
              child: Container(
                height: 50.h,
                width: 300.w,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(0))),
                child: Center(
                  child: ReusableText(
                      text: 'S I G N U P',
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
