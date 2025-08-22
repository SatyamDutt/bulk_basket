import 'dart:io';

import 'package:bulk_basket/models/cart_model.dart';
import 'package:bulk_basket/services/cart_services.dart';
import 'package:bulk_basket/views/cart/cart_order_confirmation_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Temp1 extends StatefulWidget {
  final String userId;
  const Temp1({super.key, required this.userId});

  @override
  State<Temp1> createState() => _Temp1State();
}

class _Temp1State extends State<Temp1> {
  late CartServices _cartServices = CartServices(userId: widget.userId);

  List<CartModel> cartItems = [];

  @override
  void initState() {
    super.initState();
    fetchCatItems();
  }

  void fetchCatItems() async {
    cartItems = await _cartServices.getCartItems();
    setState(() {});
  }

  void updateQuantity(String productId, int newQuantity) async {
    _cartServices.updateCartQuantity(productId, newQuantity);
    fetchCatItems();
  }

  void deleteCartItem(String productId) async {
   await _cartServices.deleteCartItems(productId);
    fetchCatItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Cart Details'),
      ),
      body: SafeArea(
        child: cartItems.isEmpty
            ? Center(child: Text('No Items in Cart'))
            : Stack(
              children: [
                ListView.separated(
                    itemCount: cartItems.length,
                    separatorBuilder: (context, index) {
                      return SizedBox();
                    },
                    itemBuilder: (context, index) {
                      var doc = cartItems[index];
                      int quantity = doc.quantity;
                
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartOrderConfirmationScreen(
                                itemName: doc.productName,
                                itemImage: doc.productImage,
                                itemPrice: doc.productPrice,
                                itemQuantity: '${doc.productQuantity}',
                                peoductDesc: doc.productDesc.toString(),
                                quantity: '$quantity',
                                productId: doc.productId, userId: widget.userId,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            child: Column(
                                              children: [
                                                Image.network(
                                                  doc.productImage,
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                                Text(
                                                    'Qty: ${doc.quantity.toString()}'),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  // Text(doc.id),
                                                  Text(
                                                    doc.productName,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    " (${doc.productQuantity})",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                '₹ ${doc.productPrice}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Container(
                                                width: 200,
                                                child: Text(
                                                  '${doc.productDesc}',
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              deleteCartItem(doc.productId);
                                            },
                                            icon: Icon(Icons.delete),
                                          ),
                                          SizedBox(height: 50),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  // Increment/Decrement Quantity Row
                                  Container(
                                    height: 35.h,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            if (quantity > 1) {
                                              setState(() {
                                                quantity--;
                                              });
                                              updateQuantity(doc.productId, quantity);
                                            }
                                          },
                                          icon: Icon(Icons.remove),
                                        ),
                                        Text(
                                          quantity.toString(),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              quantity++;
                                            });
                                            updateQuantity(doc.productId, quantity);
                                          },
                                          icon: Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider()
                          ],
                        ),
                      );
                    },
                  ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Container(
                //     color: const Color.fromARGB(255, 212, 213, 214),
                //     child: Row(
                //       children: [
                //         Expanded(child: Text('\$1500')),
                //         MaterialButton(color: Colors.amber,onPressed: () {},child: Text('Place Order', style: TextStyle(
                          
                //         ),
                //         ),
                //         ),
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
      ),
    );
  }
}
