import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';
import 'package:shoes_app_with_node_and_mongoose/controllers/cart_provider.dart';
import 'package:shoes_app_with_node_and_mongoose/controllers/favourites_provider.dart';
import 'package:shoes_app_with_node_and_mongoose/controllers/login_provider.dart';
import 'package:shoes_app_with_node_and_mongoose/controllers/mainscreen_provider.dart';
import 'package:shoes_app_with_node_and_mongoose/controllers/payment_controller.dart';
import 'package:shoes_app_with_node_and_mongoose/controllers/product_provider.dart';
import 'package:shoes_app_with_node_and_mongoose/views/ui/mainscreen.dart';

// entrypoint of the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('cart_box');
  await Hive.openBox('fav_box');
  //method that initializes the app and run top level wigets
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
    ChangeNotifierProvider(create: (context) => ProductNotifier()),
    ChangeNotifierProvider(create: (context) => FavoritesNotifier()),
    ChangeNotifierProvider(create: (context) => LoginNotifier()),
    ChangeNotifierProvider(create: (context) => CartProvider()),
    ChangeNotifierProvider(create: (context) => PaymentNotifier()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // overall theme and app layout
    return ScreenUtilInit(
        //For iphone 13 pro
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'dbestech',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                scaffoldBackgroundColor: const Color(0xFFE2E2E2)),

            // sets the homescreen of the app
            home: MainScreen(),
          );
        });
  }
}
