// import 'package:bulk_basket/product/quantity_bloc.dart';
// import 'package:bulk_basket/product/quantity_event.dart';
// import 'package:bulk_basket/product/quantity_state.dart';
import 'package:bulk_basket/views/common/primary_button.dart';
import 'package:bulk_basket/views/home/order_confirmation_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

import '../../controller/location_controller.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String userID;
  final String itemName;
  final String itemImage;
  final String itemPrice;
  final String itemQuantity;
  final String productDesc;
  const ProductDetailsScreen(
      {super.key,
      required this.itemName,
      required this.itemImage,
      required this.itemPrice,
      required this.itemQuantity,
      required this.productDesc,
      required this.userID});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;

  //OLD -- START
  // void addToCart() async {
  //   await FirebaseFirestore.instance
  //       .collection('Cart')
  //       .doc(widget.userID)
  //       .collection('Cart-Items')
  //       .add({
  //     'Product Name': widget.itemName,
  //     'Product Image': widget.itemImage,
  //     'Product Price': widget.itemPrice,
  //     'Product Quantity': widget.itemQuantity,
  //     'Product Desc': widget.productDesc,
  //     'quantity': quantity
  //   });

  //   setState(() {
  //     quantity = 1;
  //   });

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('Item added in your cart'),
  //       backgroundColor: Colors.green,
  //       duration: Duration(seconds: 1),
  //     ),
  //   );
  // }

  //OLD -- END

  //NEW

  RxBool isLoading = false.obs;

  void addToCart() async {
    isLoading.value = true;

    final userId = GetStorage().read('userId');

    final cartRef = FirebaseFirestore.instance
        .collection('Cart')
        // .doc(widget.userID)
        .doc(userId)
        .collection('Cart-Items');

    // 🔍 Check if product already exists
    final existingItem = await cartRef
        .where('Product Name', isEqualTo: widget.itemName)
        .where('Product Quantity', isEqualTo: widget.itemQuantity)
        .limit(1)
        .get();

    if (existingItem.docs.isNotEmpty) {
      // ⚠️ Already exists
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item already added in your cart'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 1),
        ),
      );
      isLoading.value = false;
      return;
    }

    // 🛒 Add new item
    await cartRef.add({
      'Product Name': widget.itemName,
      'Product Image': widget.itemImage,
      'Product Price': widget.itemPrice,
      'Product Quantity': widget.itemQuantity,
      'Product Desc': widget.productDesc,
      'quantity': quantity,
      'Created At': DateTime.now(),
    });

    setState(() {
      quantity = 1;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item added in your cart'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );

    isLoading.value = false;
  }

  final locationController = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: Obx(
          () => Stack(
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    widget.itemImage,
                    height: 300,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.itemName,
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '  (${widget.itemQuantity})',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          widget.productDesc,
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '₹ ${widget.itemPrice}',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              height: 35.h,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Center(
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          // context
                                          // .read<QuantityBloc>()
                                          // .add(DecrementQuantity());
                                          //hard code
                                          setState(() {
                                            if (quantity > 1) {
                                              quantity--;
                                            }
                                          });
                                        },
                                        icon: Icon(Icons.remove)),
                                    Text(quantity.toString()),
                                    // BlocBuilder<QuantityBloc, QuantityState>(
                                    //     builder: (context, state) {
                                    //   return Text(state.quantity.toString());
                                    // }),
                                    IconButton(
                                        onPressed: () {
                                          // context
                                          //     .read<QuantityBloc>()
                                          //     .add(IncrementQuantity());
                                          //hard code
                                          setState(
                                            () {
                                              quantity++;
                                            },
                                          );
                                        },
                                        icon: Icon(Icons.add)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        PrimaryButton(
                            title: 'Add to cart',
                            textColor: Colors.black,
                            bgColor: Colors.amberAccent,
                            isLoading: locationController.isCheckingLocation.value,
                            ontTap: () async {
                            await locationController.getCurrentLocation();
                              if (locationController.isCheckingLocation.value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Checking your location... Please wait")),
                                );
                                return;
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
                                return;
                              }
                              if (locationController.isCheckingLocation.value ==
                                      false &&
                                  locationController.isServiceAvailable.value ==
                                      true) {
                                addToCart();
                              }
                            }),
                        SizedBox(
                          height: 15.h,
                        ),
                        // PrimaryButton(
                        //     textColor: Colors.black,
                        //     bgColor: Colors.orangeAccent,
                        //     title: 'Buy Now',
                        //     ontTap: () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => OrderConfirmationScreen(
                        //             itemName: widget.itemName,
                        //             itemImage: widget.itemImage,
                        //             itemPrice: widget.itemPrice,
                        //             itemQuantity: widget.itemQuantity,
                        //             peoductDesc: widget.productDesc,
                        //             quantity: quantity.toString(),
                        //             userId: widget.userID,
                        //           ),
                        //         ),
                        //       );
                        //     })
                      ],
                    ),
                  ),
                  Center(child: Text('')),
                ],
              ),
              if (isLoading.value)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ));
  }
}

// //working bloc code

// import 'package:bulk_basket/models/cart_model.dart';
// import 'package:bulk_basket/bloc/product/quantity_bloc.dart';
// import 'package:bulk_basket/bloc/product/quantity_event.dart';
// import 'package:bulk_basket/bloc/product/quantity_state.dart';
// import 'package:bulk_basket/services/cart_services.dart';
// import 'package:bulk_basket/views/common/primary_button.dart';
// import 'package:bulk_basket/views/home/order_confirmation_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ProductDetailsScreen extends StatelessWidget {
//   final String userID;
//   final String itemName;
//   final String itemImage;
//   final String itemPrice;
//   final String itemQuantity;
//   final String productDesc;
//   ProductDetailsScreen({
//     super.key,
//     required this.itemName,
//     required this.itemImage,
//     required this.itemPrice,
//     required this.itemQuantity,
//     required this.productDesc,
//     required this.userID,
//   });

//   // int quantity = 1;
//   // void addToCart(BuildContext context, int quantity) async {
//   //   await FirebaseFirestore.instance
//   //       .collection('Cart')
//   //       .doc(userID)
//   //       .collection('Cart-Items')
//   //       .add({
//   //     'Product Name': itemName,
//   //     'Product Image': itemImage,
//   //     'Product Price': itemPrice,
//   //     'Product Quantity': itemQuantity,
//   //     'Product Desc': productDesc,
//   //     'quantity': quantity
//   //   });

//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     SnackBar(
//   //       content: Text('Item added in your cart'),
//   //       backgroundColor: Colors.green,
//   //       duration: Duration(seconds: 1),
//   //     ),
//   //   );
//   // }

//   late CartServices _cartServices = CartServices(userId: userID);

//   void addToCart(BuildContext context, int quantity) async {
//     CartModel newCartItem = CartModel(
//         productName: itemName,
//         productPrice: itemPrice,
//         productImage: itemImage,
//         productQuantity: itemQuantity,
//         productDesc: productDesc,
//         quantity: quantity, productId: '', );

//     await _cartServices.addCartItem(newCartItem);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         context.read<QuantityBloc>().add(ResetQuantity());
//         return true;
//       },

//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(),
//         body: Column(
//           // mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.network(
//               itemImage,
//               height: 300,
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         itemName,
//                         style: TextStyle(
//                           fontSize: 22.sp,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       Text(
//                         '  (${itemQuantity})',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     productDesc,
//                     textAlign: TextAlign.justify,
//                   ),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         '₹ ${itemPrice}',
//                         style: TextStyle(
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Container(
//                         height: 35.h,
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                               color: Colors.grey,
//                             ),
//                             borderRadius: BorderRadius.circular(10.r)),
//                         child: Center(
//                           child: Row(
//                             children: [
//                               IconButton(
//                                   onPressed: () {
//                                     context
//                                         .read<QuantityBloc>()
//                                         .add(DecrementQuantity());
//                                     //hard code
//                                     // setState(() {
//                                     //   if (quantity > 1) {
//                                     //     quantity--;
//                                     //   }
//                                     // }
//                                     // );
//                                   },
//                                   icon: Icon(Icons.remove)),
//                               // Text(quantity.toString()),
//                               BlocBuilder<QuantityBloc, QuantityState>(
//                                   builder: (context, state) {
//                                 return Text(state.quantity.toString());
//                               }),
//                               IconButton(
//                                   onPressed: () {
//                                     context
//                                         .read<QuantityBloc>()
//                                         .add(IncrementQuantity());
//                                     //hard code
//                                     // setState(() {
//                                     //   quantity++;
//                                     // });
//                                   },
//                                   icon: Icon(Icons.add)),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   PrimaryButton(
//                       title: 'Add to cart',
//                       textColor: Colors.black,
//                       bgColor: Colors.amberAccent,
//                       ontTap: () async {
//                         final quantity =
//                             context.read<QuantityBloc>().state.quantity.toInt();
//                         addToCart(context, quantity);
//                         context.read<QuantityBloc>().add(ResetQuantity());
//                       }),
//                   SizedBox(
//                     height: 15.h,
//                   ),
//                   PrimaryButton(
//                       textColor: Colors.black,
//                       bgColor: Colors.orangeAccent,
//                       title: 'Buy Now',
//                       ontTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => OrderConfirmationScreen(
//                               itemName: itemName,
//                               itemImage: itemImage,
//                               itemPrice: itemPrice,
//                               itemQuantity: itemQuantity,
//                               peoductDesc: productDesc,
//                               quantity: context
//                                   .read<QuantityBloc>()
//                                   .state
//                                   .quantity
//                                   .toString(),
//                               userId: userID,
//                             ),
//                           ),
//                         );
//                       })
//                 ],
//               ),
//             ),
//             Center(child: Text('')),
//           ],
//         ),
//       ),
//     );
//   }
// }

// with model
// import 'package:bulk_basket/product/quantity_bloc.dart';
// import 'package:bulk_basket/product/quantity_event.dart';
// import 'package:bulk_basket/product/quantity_state.dart';
// import 'package:bulk_basket/views/common/primary_button.dart';
// import 'package:bulk_basket/views/home/order_confirmation_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ProductDetailsScreen extends StatefulWidget {
//   final String userID;
//   final String itemName;
//   final String itemImage;
//   final String itemPrice;
//   final String itemQuantity;
//   final String productDesc;
//   const ProductDetailsScreen(
//       {super.key,
//       required this.itemName,
//       required this.itemImage,
//       required this.itemPrice,
//       required this.itemQuantity,
//       required this.productDesc,
//       required this.userID});

//   @override
//   State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
// }

// class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
//   int quantity = 1;
//   void addToCart() async {
//     await FirebaseFirestore.instance
//         .collection('Cart')
//         .doc(widget.userID)
//         .collection('Cart-Items')
//         .add({
//       'Product Name': widget.itemName,
//       'Product Image': widget.itemImage,
//       'Product Price': widget.itemPrice,
//       'Product Quantity': widget.itemQuantity,
//       'Product Desc': widget.productDesc,
//       'quantity': quantity
//     });

//     setState(() {
//       quantity = 1;
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Item added in your cart'),
//         backgroundColor: Colors.green,
//         duration: Duration(seconds: 1),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(),
//       body: Column(
//         // mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Image.network(
//             widget.itemImage,
//             height: 300,
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       widget.itemName,
//                       style: TextStyle(
//                         fontSize: 22.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Text(
//                       '  (${widget.itemQuantity})',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Text(
//                   widget.productDesc,
//                   textAlign: TextAlign.justify,
//                 ),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '₹ ${widget.itemPrice}',
//                       style: TextStyle(
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     Container(
//                       height: 35.h,
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.grey,
//                           ),
//                           borderRadius: BorderRadius.circular(10.r)),
//                       child: Center(
//                         child: Row(
//                           children: [
//                             IconButton(
//                                 onPressed: () {
//                                   context
//                                       .read<QuantityBloc>()
//                                       .add(DecrementQuantity());
//                                   //hard code
//                                   // setState(() {
//                                   //   if (quantity > 1) {
//                                   //     quantity--;
//                                   //   }
//                                   // }
//                                   // );
//                                 },
//                                 icon: Icon(Icons.remove)),
//                             // Text(quantity.toString()),
//                             BlocBuilder<QuantityBloc, QuantityState>(
//                                 builder: (context, state) {
//                               return Text(state.quantity.toString());
//                             }),
//                             IconButton(
//                                 onPressed: () {
//                                   context
//                                       .read<QuantityBloc>()
//                                       .add(IncrementQuantity());
//                                   //hard code
//                                   // setState(() {
//                                   //   quantity++;
//                                   // });
//                                 },
//                                 icon: Icon(Icons.add)),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 PrimaryButton(
//                     title: 'Add to cart',
//                     textColor: Colors.black,
//                     bgColor: Colors.amberAccent,
//                     ontTap: () {
//                       addToCart();
//                     }),
//                 SizedBox(
//                   height: 15.h,
//                 ),
//                 PrimaryButton(
//                     textColor: Colors.black,
//                     bgColor: Colors.orangeAccent,
//                     title: 'Buy Now',
//                     ontTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => OrderConfirmationScreen(
//                             itemName: widget.itemName,
//                             itemImage: widget.itemImage,
//                             itemPrice: widget.itemPrice,
//                             itemQuantity: widget.itemQuantity,
//                             peoductDesc: widget.productDesc,
//                             quantity: quantity.toString(),
//                             userId: widget.userID,
//                           ),
//                         ),
//                       );
//                     })
//               ],
//             ),
//           ),
//           Center(child: Text('')),
//         ],
//       ),
//     );
//   }
// }

// bloc code

// import 'package:bulk_basket/models/cart_model.dart';
// import 'package:bulk_basket/bloc/product/quantity_bloc.dart';
// import 'package:bulk_basket/bloc/product/quantity_event.dart';
// import 'package:bulk_basket/bloc/product/quantity_state.dart';
// import 'package:bulk_basket/models/product_model.dart';
// import 'package:bulk_basket/services/cart_services.dart';
// import 'package:bulk_basket/views/common/primary_button.dart';
// import 'package:bulk_basket/views/home/order_confirmation_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ProductDetailsScreen extends StatelessWidget {
//   final ProductModel productModel;
//   // final String userID;
//   // final String itemName;
//   // final String itemImage;
//   // final String itemPrice;
//   // final String itemQuantity;
//   // final String productDesc;
//   ProductDetailsScreen({
//     super.key,
//     required this.productModel
//     // required this.itemName,
//     // required this.itemImage,
//     // required this.itemPrice,
//     // required this.itemQuantity,
//     // required this.productDesc,
//     // required this.userID,
//   });

//   // int quantity = 1;
//   // void addToCart(BuildContext context, int quantity) async {
//   //   await FirebaseFirestore.instance
//   //       .collection('Cart')
//   //       .doc(userID)
//   //       .collection('Cart-Items')
//   //       .add({
//   //     'Product Name': itemName,
//   //     'Product Image': itemImage,
//   //     'Product Price': itemPrice,
//   //     'Product Quantity': itemQuantity,
//   //     'Product Desc': productDesc,
//   //     'quantity': quantity
//   //   });

//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     SnackBar(
//   //       content: Text('Item added in your cart'),
//   //       backgroundColor: Colors.green,
//   //       duration: Duration(seconds: 1),
//   //     ),
//   //   );
//   // }

//   late CartServices _cartServices = CartServices(userId: FirebaseAuth.instance.currentUser!.uid);

//   void addToCart(BuildContext context, int quantity) async {
//     CartModel newCartItem = CartModel(
//       productName: productModel.productName,
//       productPrice: productModel.productPrice.toString(),
//       productImage: productModel.productImage,
//       productQuantity: productModel.productQuantity,
//       productDesc: productModel.productDesc,
//       quantity: quantity,
//       productId: '',
//     );

//     await _cartServices.addCartItem(newCartItem);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         context.read<QuantityBloc>().add(ResetQuantity());
//         return true;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(),
//         body: Column(
//           // mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.network(
//               productModel.productImage,
//               height: 300,
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         productModel.productName,
//                         style: TextStyle(
//                           fontSize: 22.sp,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       Text(
//                         '  (${productModel.productQuantity})',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     productModel.productDesc,
//                     textAlign: TextAlign.justify,
//                   ),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         '₹ ${productModel.productPrice}',
//                         style: TextStyle(
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Container(
//                         height: 35.h,
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                               color: Colors.grey,
//                             ),
//                             borderRadius: BorderRadius.circular(10.r)),
//                         child: Center(
//                           child: Row(
//                             children: [
//                               IconButton(
//                                   onPressed: () {
//                                     context
//                                         .read<QuantityBloc>()
//                                         .add(DecrementQuantity());
//                                     //hard code
//                                     // setState(() {
//                                     //   if (quantity > 1) {
//                                     //     quantity--;
//                                     //   }
//                                     // }
//                                     // );
//                                   },
//                                   icon: Icon(Icons.remove)),
//                               // Text(quantity.toString()),
//                               BlocBuilder<QuantityBloc, QuantityState>(
//                                   builder: (context, state) {
//                                 return Text(state.quantity.toString());
//                               }),
//                               IconButton(
//                                   onPressed: () {
//                                     context
//                                         .read<QuantityBloc>()
//                                         .add(IncrementQuantity());
//                                     //hard code
//                                     // setState(() {
//                                     //   quantity++;
//                                     // });
//                                   },
//                                   icon: Icon(Icons.add)),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   PrimaryButton(
//                       title: 'Add to cart',
//                       textColor: Colors.black,
//                       bgColor: Colors.amberAccent,
//                       ontTap: () async {
//                         final quantity =
//                             context.read<QuantityBloc>().state.quantity.toInt();
//                         addToCart(context, quantity);
//                         context.read<QuantityBloc>().add(ResetQuantity());
//                       }),
//                   SizedBox(
//                     height: 15.h,
//                   ),
//                   PrimaryButton(
//                       textColor: Colors.black,
//                       bgColor: Colors.orangeAccent,
//                       title: 'Buy Now',
//                       ontTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => OrderConfirmationScreen(
//                               itemName: productModel.productName,
//                               itemImage: productModel.productImage,
//                               itemPrice: productModel.productPrice.toString(),
//                               itemQuantity: productModel.productQuantity,
//                               peoductDesc: productModel.productDesc,
//                               quantity: context
//                                   .read<QuantityBloc>()
//                                   .state
//                                   .quantity
//                                   .toString(),
//                               userId: FirebaseAuth.instance.currentUser!.uid,
//                             ),
//                           ),
//                         );
//                       })
//                 ],
//               ),
//             ),
//             Center(child: Text('')),
//           ],
//         ),
//       ),
//     );
//   }
// }
