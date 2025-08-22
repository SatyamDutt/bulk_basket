// import 'package:bulk_basket/views/home/home_screen.dart';
// import 'package:bulk_basket/views/home/product_home_screen.dart';
// import 'package:bulk_basket/views/home/profile_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// class PaymentScreen extends StatefulWidget {
//   final double totalAmount;
//   final String itemName;
//   final String itemImage;
//   final String itemPrice;
//   final String itemQuantity;

//   const PaymentScreen({
//     super.key,
//     required this.totalAmount,
//     required this.itemName,
//     required this.itemImage,
//     required this.itemPrice,
//     required this.itemQuantity,
//   });

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   late Razorpay _razorpay;

//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//   }

//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Payment Successful: ${response.paymentId}")),
//     );
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ProductScreen(),
//       ),
//     );
//     // Navigate to Order Success Page or Update Order in Firestore
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Payment Failed: ${response.message}")),
//     );
//   }

//   void _openCheckout() {
//     var options = {
//       'key': 'rzp_test_VJxuQHz7BdSF7I', // Replace with your Razorpay Key ID
//       'amount': (widget.totalAmount * 100).toInt(), // Convert to paise
//       'name': widget.itemName,
//       'description': "Payment for ${widget.itemName}",
//       'prefill': {
//         'contact': '9999999999', // Replace with actual user contact
//         'email': 'user@example.com',
//       },
//       'theme': {'color': '#FF9800'},
//     };

//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       print("Error: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Payment")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Total Amount: ₹${widget.totalAmount}",
//                 style: TextStyle(fontSize: 22)),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _openCheckout,
//               child: Text("Proceed to Pay"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
