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


//PRODUCTION LEVEL CODE
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final double totalAmount;
  final String itemName;

  const PaymentScreen({
    super.key,
    required this.totalAmount,
    required this.itemName,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay _razorpay;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  // ✅ OPEN PAYMENT
  void _openCheckout() {
    if (isLoading) return;

    setState(() => isLoading = true);

    var options = {
      'key': 'rzp_test_VJxuQHz7BdSF7I', // 🔴 Replace in production
      'amount': (widget.totalAmount * 100).toInt(),
      'name': widget.itemName,
      'description': "Order Payment",
      'prefill': {
        'contact': '9999999999',
        'email': 'user@example.com',
      },
      'theme': {'color': '#53B175'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      setState(() => isLoading = false);
      _showSnack("Error opening payment");
    }
  }

  // ✅ SUCCESS HANDLER
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    setState(() => isLoading = true);

    // 🔥 IMPORTANT: call backend here to verify payment
    bool isVerified = await _fakeVerifyPayment(response);

    if (isVerified) {
      _showSnack("Payment Successful ✅");

      Navigator.pop(context, true); // return success
    } else {
      _showSnack("Payment verification failed ❌");
    }

    setState(() => isLoading = false);
  }

  // ✅ ERROR HANDLER
  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() => isLoading = false);

    _showSnack(response.message ?? "Payment failed");
  }

  // ✅ WALLET HANDLER
  void _handleExternalWallet(ExternalWalletResponse response) {
    _showSnack("External wallet selected");
  }

  // ✅ SNACKBAR
  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  // 🔥 TEMP VERIFY (REPLACE WITH BACKEND)
  Future<bool> _fakeVerifyPayment(PaymentSuccessResponse response) async {
    await Future.delayed(const Duration(seconds: 1));
    return true; // ❗ always true (replace with API)
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !isLoading, // 🚫 block back during payment
      child: Scaffold(
        appBar: AppBar(title: const Text("Payment")),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total Amount",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "₹${widget.totalAmount}",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: isLoading ? null : _openCheckout,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 55),
                      backgroundColor: Colors.green,
                    ),
                    child: Text("Proceed to Pay"),
                  ),
                ],
              ),
            ),

            // 🔥 FULL SCREEN LOADER
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.4),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}