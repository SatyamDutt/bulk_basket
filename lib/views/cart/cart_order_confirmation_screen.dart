// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../resources/app_style.dart';
// import '../common/input_label.dart';
// import '../common/primary_button.dart';
// import '../common/primary_textField.dart';
// import '../home/home_screen.dart';
//
// class CartOrderConfirmationScreen extends StatefulWidget {
//   final String itemName;
//   final String itemImage;
//   final String itemPrice;
//   final String itemQuantity;
//   final String peoductDesc;
//   final String quantity;
//   final String productId;
//   const CartOrderConfirmationScreen({super.key,
//     required this.itemName,
//     required this.itemImage,
//     required this.itemPrice,
//     required this.itemQuantity,
//     required this.peoductDesc,
//     required this.quantity,
//     required this.productId
//   });
//
//   @override
//   State<CartOrderConfirmationScreen> createState() => _CartOrderConfirmationScreenState();
// }
//
// class _CartOrderConfirmationScreenState extends State<CartOrderConfirmationScreen> {
//
//   TextEditingController deliveryAddress = TextEditingController();
//
//
//   void PurchaseItem(double total, double subTotal, double gstAmount) async {
//     final String DeliveryAddress = deliveryAddress.text.toString();
//
//     if (DeliveryAddress.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Delivery Address is required',
//           ),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } else {
//       try {
//         await FirebaseFirestore.instance.collection('New Order').add({
//           'Product Name': widget.itemName,
//           'Product Image': widget.itemImage,
//           'Product Quantiyt': widget.itemQuantity,
//           'Quantity': widget.quantity,
//           'Product Price': widget.itemPrice,
//           'SubTotal': subTotal.toString(),
//           'GST Amount': gstAmount.toString(),
//           'Total Amount': total.toString(),
//           'Delivery Address': DeliveryAddress,
//           'Created At': DateTime.now(),
//         });
//
//         await FirebaseFirestore.instance.collection('Cart').doc(widget.productId).delete();
//
//         showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 backgroundColor: Colors.white,
//                 actions: [
//                   MaterialButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => HomeScreen(),
//                         ),
//                       );
//                     },
//                     child: Text('Done'),
//                     // child: Icon(Icons.clear),
//                   )
//                 ],
//                 content: Container(
//                   height: 150,
//                   width: double.maxFinite,
//                   child: Column(
//                     children: [
//                       // SizedBox(height: 10.h,),
//                       Image.asset(
//                         'assets/successLogo.png',
//                         height: 100,
//                         width: 100,
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Text(
//                         'Your order successfully placed!',
//                         style: AppStyle.smallFont,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Order Placed Successfully'),
//             backgroundColor: Colors.green,
//             duration: Duration(seconds: 1),
//           ),
//         );
//       } catch (e) {
//         print('Error in order ');
//       }
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     double subTotal =
//         double.parse(widget.itemPrice) * double.parse(widget.quantity);
//
//     double gstAmount = subTotal * 0.18;
//     double Total = subTotal + gstAmount;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.amber,
//         title: Text('Order Confirmation'),
//       ),
//       body: SafeArea(
//         child: ListView(
//           children: [
//             SizedBox(
//               height: 15.h,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   children: [
//                     Image.asset(
//                       widget.itemImage,
//                       height: 100,
//                       width: 100,
//                     ),
//                     SizedBox(
//                       height: 5.h,
//                     ),
//                     Text('Qty: ${widget.quantity}'),
//                   ],
//                 ),
//                 SizedBox(
//                   width: 10.w,
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           widget.itemName,
//                           // widget.productId,
//                           style: TextStyle(
//                             fontSize: 20.sp,
//                           ),
//                         ),
//                         Text(
//                           '  (${widget.itemQuantity} )',
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text(
//                           '₹ ${widget.itemPrice}',
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 6.h,
//                     ),
//                     Container(
//                       width: 270,
//                       child: Text(
//                         widget.peoductDesc,
//                         textAlign: TextAlign.justify,
//                         maxLines: 2,
//                         style: TextStyle(
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             Divider(),
//             SizedBox(
//               height: 10.h,
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         'Payment Summary',
//                         style: TextStyle(
//                           fontSize: 20.sp,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Subtotal',
//                         style: AppStyle.smallFont,
//                       ),
//                       Text(
//                         '${widget.quantity}  x  ₹${widget.itemPrice.toString()}',
//                         style: AppStyle.smallFont,
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'GST (18%)',
//                         style: AppStyle.smallgreyFont,
//                       ),
//                       Text(
//                         '₹ ${gstAmount.toString()}',
//                         style: AppStyle.smallgreyFont,
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Delivery Charge',
//                         style: AppStyle.smallgreyFont,
//                       ),
//                       Text(
//                         '₹ 0',
//                         style: AppStyle.smallgreyFont,
//                       ),
//                     ],
//                   ),
//                   Divider(),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Total',
//                         style: AppStyle.smallBoldFont,
//                       ),
//                       Text(
//                         '₹ ${Total.toString()}',
//                         style: AppStyle.smallBoldFont,
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 15.h,
//                   ),
//                   InputLabel(title: 'Enter Delivery Address'),
//
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   PrimaryTextfield(
//                       inputValue: deliveryAddress,
//                       hintText: 'Jammu Colony Ludhiana...'),
//                   SizedBox(
//                     height: 100.h,
//                   ),
//                   PrimaryButton(
//                       bgColor: Colors.orangeAccent,
//                       textColor: Colors.white,
//                       title: 'Procced to Pay',
//                       ontTap: () {
//                         PurchaseItem(Total, subTotal, gstAmount);
//
//                         // Navigator.pop(context);
//                       }),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:bulk_basket/views/cart/cart_order_address_screen.dart';
import 'package:bulk_basket/views/home/product_home_screen.dart';
import 'package:bulk_basket/views/home/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/app_style.dart';
import '../common/input_label.dart';
import '../common/primary_button.dart';
import '../common/primary_textField.dart';
import '../home/home_screen.dart';

class CartOrderConfirmationScreen extends StatefulWidget {
  final String userId;
  final String itemName;
  final String itemImage;
  final String itemPrice;
  final String itemQuantity;
  final String peoductDesc;
  final String quantity;
  final String productId;

  const CartOrderConfirmationScreen({
    super.key,
    required this.itemName,
    required this.itemImage,
    required this.itemPrice,
    required this.itemQuantity,
    required this.peoductDesc,
    required this.quantity,
    required this.productId,
    required this.userId
  });

  @override
  State<CartOrderConfirmationScreen> createState() =>
      _CartOrderConfirmationScreenState();
}

class _CartOrderConfirmationScreenState
    extends State<CartOrderConfirmationScreen> {
  TextEditingController deliveryAddress = TextEditingController();
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = int.parse(widget.quantity); // Initialize quantity from widget
  }

  void PurchaseItem(double total, double subTotal, double gstAmount) async {
    final String DeliveryAddress = deliveryAddress.text.toString();

    if (DeliveryAddress.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Delivery Address is required',
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      try {
        await FirebaseFirestore.instance.collection('New Order').add({
          'Product Name': widget.itemName,
          'Product Image': widget.itemImage,
          'Product Quantity': widget.itemQuantity,
          'Quantity': quantity.toString(),
          'Product Price': widget.itemPrice,
          'SubTotal': subTotal.toString(),
          'GST Amount': gstAmount.toString(),
          'Total Amount': total.toString(),
          'Delivery Address': DeliveryAddress,
          'Created At': DateTime.now(),
        });

        await FirebaseFirestore.instance.collection('Order History').add({
          'Product Name': widget.itemName,
          'Product Image': widget.itemImage,
          'Product Quantity': widget.itemQuantity,
          'Quantity': quantity.toString(),
          'Product Price': widget.itemPrice,
          'SubTotal': subTotal.toString(),
          'GST Amount': gstAmount.toString(),
          'Total Amount': total.toString(),
          'Delivery Address': DeliveryAddress,
          'Created At': DateTime.now(),
        });

        await FirebaseFirestore.instance
            .collection('Cart')
            .doc(widget.productId)
            .delete();

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(),
                      ),
                    );
                  },
                  child: Text('Done'),
                ),
              ],
              content: Container(
                height: 150,
                width: double.maxFinite,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/successLogo.png',
                      height: 100,
                      width: 100,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Your order successfully placed!',
                      style: AppStyle.smallFont,
                    ),
                  ],
                ),
              ),
            );
          },
        );

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Order Placed Successfully'),
        //     backgroundColor: Colors.green,
        //     duration: Duration(seconds: 1),
        //   ),
        // );
      } catch (e) {
        print('Error in order');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double subTotal = double.parse(widget.itemPrice) * quantity;
    double gstAmount = subTotal * 0.18;
    double Total = subTotal + gstAmount;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Order Confirmation'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Image.network(
                      widget.itemImage,
                      height: 100,
                      width: 100,
                    ),
                    SizedBox(height: 5.h),
                    Text('Qty: $quantity'), // Displaying updated quantity
                  ],
                ),
                SizedBox(width: 10.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.itemName,
                          style: TextStyle(
                            fontSize: 20.sp,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '₹ ${widget.itemPrice}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      width: 270,
                      child: Text(
                        widget.peoductDesc,
                        textAlign: TextAlign.justify,
                        maxLines: 2,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      height: 35.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (quantity > 1) {
                                    quantity--;
                                  }
                                });
                              },
                              icon: Icon(Icons.remove),
                            ),
                            Text(quantity.toString()), // Displaying quantity
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Divider(),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Payment Summary',
                        style: TextStyle(
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal',
                        style: AppStyle.smallFont,
                      ),
                      Text(
                        '$quantity  x  ₹${widget.itemPrice.toString()}',
                        style: AppStyle.smallFont,
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'GST (18%)',
                        style: AppStyle.smallgreyFont,
                      ),
                      Text(
                        '₹ ${gstAmount.toString()}',
                        style: AppStyle.smallgreyFont,
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  // Text(widget.productId),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Charge',
                        style: AppStyle.smallgreyFont,
                      ),
                      Text(
                        '₹ 0',
                        style: AppStyle.smallgreyFont,
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: AppStyle.smallBoldFont,
                      ),
                      Text(
                        '₹ ${Total.toString()}',
                        style: AppStyle.smallBoldFont,
                      ),
                    ],
                  ),
                  // SizedBox(height: 15.h),
                  // InputLabel(title: 'Enter Delivery Address'),
                  // SizedBox(height: 10.h),
                  // PrimaryTextfield(
                  //   inputValue: deliveryAddress,
                  //   hintText: 'Jammu Colony Ludhiana...',
                  // ),
                  SizedBox(height: 100.h),
                  PrimaryButton(
                    bgColor: Colors.orangeAccent,
                    textColor: Colors.white,
                    title: 'Proceed to Pay',
                    ontTap: () {
                      // PurchaseItem(Total, subTotal, gstAmount);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartOrderAddressScreen(
                            itemName: widget.itemName,
                            itemImage: widget.itemImage,
                            itemPrice: widget.itemPrice,
                            itemQuantity: widget.itemQuantity,
                            peoductDesc: widget.peoductDesc,
                            quantity: quantity.toString(),
                            productId: '${widget.productId}',
                            GSTAmount: gstAmount.toString(),
                            totalPrice: Total.toString(),
                            subTotal: subTotal.toString(),
                            userId: widget.userId,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
