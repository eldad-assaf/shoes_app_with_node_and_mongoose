import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app_with_node_and_mongoose/controllers/login_provider.dart';
import 'package:shoes_app_with_node_and_mongoose/services/auth_helper.dart';
import 'package:shoes_app_with_node_and_mongoose/views/ui/auth/login.dart';
import 'package:shoes_app_with_node_and_mongoose/views/ui/cartpage.dart';
import 'package:shoes_app_with_node_and_mongoose/views/ui/nonuser.dart';

import '../shared/appstyle.dart';
import '../shared/reuseable_text.dart';
import '../shared/tiles_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifier>(context);
    return authNotifier.loggedIn == false
        ? const NonUser()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFFE2E2E2),
              elevation: 0,
              leading: const Icon(
                MaterialCommunityIcons.qrcode_scan,
                size: 18,
                color: Colors.black,
              ),
              actions: [
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/usa.svg',
                          width: 15.w,
                          height: 25,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Container(
                          height: 15.h,
                          width: 1.w,
                          color: Colors.grey,
                        ),
                        ReusableText(
                            text: "USA",
                            style:
                                appstyle(16, Colors.black, FontWeight.normal)),
                        SizedBox(
                          width: 10.w,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Icon(
                            SimpleLineIcons.settings,
                            color: Colors.black,
                            size: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 70.h,
                    decoration: const BoxDecoration(color: Color(0xFFE2E2E2)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 10, 16, 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 35.h,
                                    width: 35.w,
                                    child: const CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/images/user.jpeg'),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  FutureBuilder(
                                      future: AuthHelper().getProfile(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator
                                                .adaptive(),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Center(
                                            child: ReusableText(
                                                text: 'Error getting thr data',
                                                style: appstyle(
                                                  18,
                                                  Colors.black,
                                                  FontWeight.w600,
                                                )),
                                          );
                                        } else {
                                          final userData = snapshot.data;
                                          return SizedBox(
                                            height: 37.h,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ReusableText(
                                                  text:
                                                      userData?.username ?? '',
                                                  style: appstyle(
                                                      12,
                                                      Colors.grey.shade600,
                                                      FontWeight.normal),
                                                ),
                                                ReusableText(
                                                  text: userData?.email ?? '',
                                                  style: appstyle(
                                                      12,
                                                      Colors.grey.shade600,
                                                      FontWeight.normal),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      }),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                    onTap: () {},
                                    child: const Icon(
                                      Feather.edit,
                                      size: 18,
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 10.h),
                      Container(
                        height: 170.h,
                        color: Colors.grey.shade200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TilesWidget(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              },
                              title: " My Orders",
                              leading:
                                  MaterialCommunityIcons.truck_fast_outline,
                            ),
                            TilesWidget(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Favouries()));
                              },
                              title: "My Favorites",
                              leading: MaterialCommunityIcons.heart_outline,
                            ),
                            TilesWidget(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CartPage()));
                              },
                              title: "My Cart",
                              leading: Fontisto.shopping_bag_1,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 110.h,
                        color: Colors.grey.shade200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TilesWidget(
                              onTap: () {},
                              title: "Coupons",
                              leading: MaterialCommunityIcons.tag_outline,
                            ),
                            TilesWidget(
                              onTap: () {},
                              title: "My Store",
                              leading: MaterialCommunityIcons.shopping_outline,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 170.h,
                        color: Colors.grey.shade200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TilesWidget(
                              onTap: () {},
                              title: "Shipping address",
                              leading: SimpleLineIcons.location_pin,
                            ),
                            TilesWidget(
                              onTap: () {},
                              title: "Settings",
                              leading: AntDesign.setting,
                            ),
                            TilesWidget(
                              onTap: () async {
                                authNotifier.logout();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              },
                              title: "Logout",
                              leading: AntDesign.logout,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
