import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app_with_node_and_mongoose/controllers/cart_provider.dart';
import 'package:shoes_app_with_node_and_mongoose/models/get_products.dart';
import 'package:shoes_app_with_node_and_mongoose/services/cart_helper.dart';
import 'package:shoes_app_with_node_and_mongoose/views/shared/appstyle.dart';
import 'package:shoes_app_with_node_and_mongoose/views/shared/reuseable_text.dart';

import '../shared/checkout_btn.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<dynamic> cart = [];
  late Future<List<Product>> _cartList;

  @override
  void initState() {
    _cartList = CartHelper().getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    AntDesign.close,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "My Cart",
                  style: appstyle(36, Colors.black, FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: FutureBuilder(
                      future: _cartList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: ReusableText(
                                text: 'Faild to get cart data',
                                style: appstyle(
                                    18, Colors.black, FontWeight.w600)),
                          );
                        }

                        final cartData = snapshot.data;

                        return ListView.builder(
                            itemCount: cartData!.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              final data = cartData[index];
                              return GestureDetector(
                                onTap: () {
                                  cartProvider.setProductIndex = index;
                                  log(cartProvider.productIndex.toString());
                                  cartProvider.checkout.insert(0, data);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    child: Slidable(
                                      key: const ValueKey(0),
                                      endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            flex: 1,
                                            onPressed: doNothing,
                                            backgroundColor:
                                                const Color(0xFF000000),
                                            foregroundColor: Colors.white,
                                            icon: Icons.delete,
                                            label: 'Delete',
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.11,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.shade500,
                                                  spreadRadius: 5,
                                                  blurRadius: 0.3,
                                                  offset: const Offset(0, 1)),
                                            ]),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4),
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: SizedBox(
                                                      width: 20,
                                                      height: 20,
                                                      child: Icon(
                                                        cartProvider.productIndex ==
                                                                index
                                                            ? Feather
                                                                .check_square
                                                            : Feather.square,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      CartHelper()
                                                          .deleteItem(data.id)
                                                          .then((value) {
                                                        if (value == true) {
                                                          _cartList =
                                                              CartHelper()
                                                                  .getCart();
                                                          setState(() {});
                                                        }
                                                      });
                                                    },
                                                    child: const SizedBox(
                                                      width: 20,
                                                      height: 20,
                                                      child: Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  child: CachedNetworkImage(
                                                    imageUrl: data
                                                        .cartItem.imageUrl[0],
                                                    width: 70,
                                                    height: 70,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 3, left: 20),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data.cartItem.name,
                                                        style: appstyle(
                                                            16,
                                                            Colors.black,
                                                            FontWeight.bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(
                                                        data.cartItem.category,
                                                        style: appstyle(
                                                            14,
                                                            Colors.grey,
                                                            FontWeight.w600),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            data.cartItem.price,
                                                            style: appstyle(
                                                                18,
                                                                Colors.black,
                                                                FontWeight
                                                                    .w600),
                                                          ),
                                                          const SizedBox(
                                                            width: 40,
                                                          ),
                                                          Text(
                                                            "Size",
                                                            style: appstyle(
                                                                18,
                                                                Colors.grey,
                                                                FontWeight
                                                                    .w600),
                                                          ),
                                                          const SizedBox(
                                                            width: 15,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    16))),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        InkWell(
                                                            onTap: () {
                                                              // cartProvider.increment();
                                                            },
                                                            child: const Icon(
                                                              AntDesign
                                                                  .minussquare,
                                                              size: 20,
                                                              color:
                                                                  Colors.grey,
                                                            )),
                                                        Text(
                                                          data.quantity
                                                              .toString(),
                                                          style: appstyle(
                                                            16,
                                                            Colors.black,
                                                            FontWeight.w600,
                                                          ),
                                                        ),
                                                        InkWell(
                                                            onTap: () {
                                                              // cartProvider.decrement();
                                                            },
                                                            child: const Icon(
                                                              AntDesign
                                                                  .plussquare,
                                                              size: 20,
                                                              color:
                                                                  Colors.black,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                // ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),
                )
              ],
            ),
            cartProvider.checkout.isNotEmpty
                ? const Align(
                    alignment: Alignment.bottomCenter,
                    child: CheckoutButton(label: "Proceed to Checkout"),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  void doNothing(BuildContext context) {}
}
