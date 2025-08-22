// import 'package:bulk_basket/views/cart/cart_order_confirmation_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../common/primary_button.dart';

// class CartProductDetailsScreen extends StatefulWidget {final String itemName;
// final String itemImage;
// final String itemPrice;
// final String itemQuantity;
// final String productDesc;
// final String quantity;
// final String  productId;
//   const CartProductDetailsScreen({super.key,
//     required this.itemName,
//     required this.itemImage,
//     required this.itemPrice,
//     required this.itemQuantity,
//     required this.productDesc,
//     required this.quantity,
//     required this.productId
//   });

//   @override
//   State<CartProductDetailsScreen> createState() => _CartProductDetailsScreenState();
// }

// class _CartProductDetailsScreenState extends State<CartProductDetailsScreen> {


//   late int quantity;


// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//      quantity = int.tryParse(widget.quantity) ?? 1;
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
//           Image.asset(
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
//                       // widget.productId,
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
//                                   setState(() {
//                                     if (quantity > 1) {
//                                       quantity--;
//                                     }
//                                   });
//                                 },
//                                 icon: Icon(Icons.remove)),
//                             Text(quantity.toString()),
//                             IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     quantity++;
//                                   });
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
//                 // PrimaryButton(
//                 //     title: 'Go to cart',
//                 //     textColor: Colors.black,
//                 //     bgColor: Colors.amberAccent,
//                 //     ontTap: () {
//                 //       Navigator.pop(context);
//                 //     }),
//                 // SizedBox(
//                 //   height: 15.h,
//                 // ),
//                 PrimaryButton(
//                     textColor: Colors.black,
//                     bgColor: Colors.orangeAccent,
//                     title: 'Buy Now',
//                     ontTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CartOrderConfirmationScreen(itemName: widget.itemName, itemImage: widget.itemImage, itemPrice: widget.itemPrice, itemQuantity:widget.itemQuantity, peoductDesc: widget.productDesc, quantity: quantity.toString(), productId: widget.productId,),
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
