import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shoes_app_with_node_and_mongoose/views/ui/cartpage.dart';
import 'package:shoes_app_with_node_and_mongoose/views/ui/profile.dart';
import 'package:shoes_app_with_node_and_mongoose/views/ui/searchpage.dart';

import '../../controllers/mainscreen_provider.dart';
import '../shared/bottom_nav.dart';
import 'homepage.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List<Widget> pageList = [
    const HomePage(),
    const SearchPage(),
    const CartPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFE2E2E2),
          body: pageList[mainScreenNotifier.pageIndex],
          bottomNavigationBar: const BottoNavBar(),
        );
      },
    );
  }
}
