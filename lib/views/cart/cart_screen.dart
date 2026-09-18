// import 'package:bulk_basket/views/cart/cart_order_confirmation_screen.dart';
// import 'package:bulk_basket/views/cart/cart_product_details_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});
//
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//   }
//
//   var ItemList = [];
//
//   void fetchProducts() async {
//     QuerySnapshot snapshot =
//         await FirebaseFirestore.instance.collection('Cart').get();
//
//     setState(() {
//       ItemList = snapshot.docs;
//     });
//
//     for (var doc in snapshot.docs) {
//       print(doc["ProductName"]);
//     }
//     // print(snapshot.docs.length);
//     // print('Product length');
//     print('helo');
//     print(ItemList.length);
//
//     for (var doc in ItemList) {
//       print('Item List');
//       print(doc["Product Name"]);
//     }
//   }
//
//   void DeleteProduct(String productId) async {
//     await FirebaseFirestore.instance.collection('Cart').doc(productId).delete();
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('1 Item Deleted from Cart'),
//         backgroundColor: Colors.red,
//         duration: Duration(seconds: 1),
//       ),
//     );
//
//     fetchProducts();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.green,
//       appBar: AppBar(
//         backgroundColor: Colors.amber,
//         title: Text('Cart Details'),
//       ),
//       body: SafeArea(
//         child: ItemList.isEmpty
//             ? Center(child: Text('No Items in Cart'))
//             : ListView.separated(
//                 itemCount: ItemList.length,
//                 separatorBuilder: (context, index) {
//                   return Divider();
//                 },
//                 itemBuilder: (context, index) {
//                   var doc = ItemList[index];
//                   return InkWell(
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => CartOrderConfirmationScreen(
//                           itemName: doc["Proudct Name"],
//                           itemImage: doc["Product Image"],
//                           itemPrice: doc["Product Price"],
//                           itemQuantity: '${doc["Product Quantity"].toString()}',
//                         peoductDesc: doc['Product Desc'].toString(), quantity: '${doc["quantity"].toString()}', productId: doc.id,),),);
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   Container(
//                                     child: Column(
//                                       children: [
//                                         Image.asset(
//                                           doc["Product Image"],
//                                           // child: Image.asset(
//                                           //   'assets/cartImage.png',
//                                           width: 100,
//                                           height: 100,
//                                           fit: BoxFit.cover,
//                                         ),
//
//                                         Text(
//                                             ' Qty: ${doc["quantity"].toString()}'),
//                                       ],
//                                     ),
//                                   ),
//                                   Column(
//                                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Text(
//                                             doc["Proudct Name"],
//                                             style: TextStyle(
//                                               fontSize: 20,
//                                             ),
//                                           ),
//                                           Text(
//                                             " (${doc["Product Quantity"].toString()} )",
//                                             style: TextStyle(
//                                               fontSize: 20,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Text(
//                                         '₹ ${doc["Product Price"]}',
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                       Container(
//                                         width: 200,
//                                         child: Text('${doc['Product Desc']}',
//                                         overflow: TextOverflow.ellipsis,
//                                           maxLines: 3,
//                                         ),
//                                       ),
//
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   IconButton(
//                                       onPressed: () {
//                                         DeleteProduct(doc.id);
//                                       },
//                                       icon: Icon(Icons.delete)),
//                                   SizedBox(
//                                     height: 50,
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }),
//       ),
//     );
//   }
// }

import 'package:bulk_basket/controller/location_controller.dart';
import 'package:bulk_basket/views/cart/cart_order_confirmation_screen.dart';
import 'package:bulk_basket/views/common/primary_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../home/new_cart_order_address_screen.dart';

class CartScreen extends StatefulWidget {
  final String userId;
  const CartScreen({super.key, required this.userId});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var ItemList = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  final currentUserId = GetStorage().read('userId');

  void fetchProducts() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Cart')
        .doc(currentUserId)
        .collection('Cart-Items')
        .get();

    setState(() {
      ItemList = snapshot.docs;
    });

    for (var doc in snapshot.docs) {
      print(doc["Product Name"]);
    }
  }

  void DeleteProduct(String productId) async {
    await FirebaseFirestore.instance
        .collection('Cart')
        .doc(currentUserId)
        .collection('Cart-Items')
        .doc(productId)
        .delete();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('1 Item Deleted from Cart'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ),
    );

    fetchProducts();
  }

  void updateQuantity(String productId, int newQuantity) async {
    await FirebaseFirestore.instance
        .collection('Cart')
        .doc(currentUserId)
        .collection('Cart-Items')
        .doc(productId)
        .update({
      'quantity': newQuantity,
    });

    // Refresh the product list to reflect the updated quantity
    fetchProducts();
    calculateTotals();
  }

  double subTotal = 0;
  double gstAmount = 0;
  double totalAmount = 0;

  void calculateTotals() {
    subTotal = 0;
    for (var doc in ItemList) {
      double price = double.tryParse(doc["Product Price"].toString()) ?? 0;
      int qty = doc["quantity"] ?? 1;
      subTotal += price * qty;
    }

    gstAmount = subTotal * 0.18; // 18% GST (change rate if needed)
    totalAmount = subTotal + gstAmount;
  }

  final locationController = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Cart Details'),
      ),
      body: SafeArea(
        child: ItemList.isEmpty
            ? Center(child: Text('No Items in Cart'))
            : Stack(
                children: [
                  ListView.separated(
                    itemCount: ItemList.length,
                    separatorBuilder: (context, index) {
                      return SizedBox();
                    },
                    itemBuilder: (context, index) {
                      var doc = ItemList[index];
                      int quantity = doc["quantity"];

                      return InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => CartOrderConfirmationScreen(
                          //       itemName: doc["Product Name"],
                          //       itemImage: doc["Product Image"],
                          //       itemPrice: doc["Product Price"],
                          //       itemQuantity: '${doc["Product Quantity"]}',
                          //       peoductDesc: doc['Product Desc'].toString(),
                          //       quantity: '$quantity',
                          //       productId: doc.id,
                          //       userId: currentUserId,
                          //     ),
                          //   ),
                          // );
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
                                                  doc["Product Image"],
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.contain,
                                                ),
                                                Text(
                                                    'Qty: ${doc["quantity"].toString()}'),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  // Text(doc.id),
                                                  SizedBox(
                                                    width: 120.w,
                                                    child: Text(
                                                      doc["Product Name"],
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        overflow: TextOverflow.ellipsis,
                                                        
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    " (${doc["Product Quantity"]})",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                '₹ ${doc["Product Price"]}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Container(
                                                width: 200,
                                                child: Text(
                                                  '${doc['Product Desc']}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                              DeleteProduct(doc.id);
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            if (quantity > 1) {
                                              setState(() {
                                                quantity--;
                                              });
                                              updateQuantity(doc.id, quantity);
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
                                            updateQuantity(doc.id, quantity);
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 35),
                      child: Obx(
                         () => PrimaryButton(
                            title: 'Confirm & Proceed',
                            bgColor: Colors.orange,
                            isLoading: locationController.isCheckingLocation.value,
                            ontTap: () async{
                              await locationController.getCurrentLocation();
                              //GPS
                              if (locationController.isCheckingLocation.value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Checking your location... Please wait")),
                                  );
                                  // return;
                                }
                        
                                if (!locationController
                                    .isServiceAvailable.value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Service not available in your area. Coming soon!",style: TextStyle(
                                            fontSize: 15
                                          ),),
                                          backgroundColor: Colors.red,
                                    ),
                                  );
                                  // return;
                                }
                                if (locationController.isCheckingLocation.value ==
                                        false &&
                                    locationController.isServiceAvailable.value ==
                                        true) {
                                  calculateTotals();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewCartOrderAddressScreen(
                                    userId: currentUserId,
                                    cartItems: ItemList.map((doc) => {
                                          "Product Name": doc["Product Name"],
                                          "Product Image": doc["Product Image"],
                                          "Product Quantity":
                                              doc["Product Quantity"],
                                          "Quantity": doc["quantity"],
                                          "Product Price": doc["Product Price"],
                                          "Product Desc": doc["Product Desc"],
                                        }).toList(),
                                    // subTotal: "1000", // calculate from cart
                                    // GSTAmount: "100", // calculate from cart
                                    // totalPrice: "1100", // calculate from cart
                        
                                    subTotal: subTotal.toStringAsFixed(2),
                                    GSTAmount: gstAmount.toStringAsFixed(2),
                                    totalPrice: totalAmount.toStringAsFixed(2),
                                  ),
                                ),
                              );
                                }
                              //GPS
                              
                            }),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
