import 'package:bulk_basket/views/common/input_label.dart';
import 'package:bulk_basket/views/common/primary_button.dart';
import 'package:bulk_basket/views/common/primary_textField.dart';
import 'package:bulk_basket/views/home/product_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class OrderAddressScreen extends StatefulWidget {
  final String userId;
  final String itemName;
  final String itemImage;
  final String itemPrice;
  final String itemQuantity;
  final String peoductDesc;
  final String quantity;
  final String subTotal;
  final String GSTAmount;
  final String totalPrice;
  const OrderAddressScreen(
      {super.key,
      required this.itemName,
      required this.itemImage,
      required this.itemPrice,
      required this.itemQuantity,
      required this.peoductDesc,
      required this.quantity,
      required this.GSTAmount,
      required this.totalPrice,
      required this.subTotal,
      required this.userId
      });

  @override
  State<OrderAddressScreen> createState() => _OrderAddressScreenState();
}

class _OrderAddressScreenState extends State<OrderAddressScreen> {
  //  late int quantity;
  // @override
  // void initState() {
  //   super.initState();
  //   quantity = int.parse(widget.quantity);
  // }

  //payment
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Successful: ${response.paymentId}")),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProductScreen(userId: widget.userId,),
      ),
    );
    // Navigate to Order Success Page or Update Order in Firestore
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Failed: ${response.message}")),
    );
  }

  void _openCheckout() {
    double totalAmount = double.tryParse(widget.totalPrice) ?? 0;
    var options = {
      'key': 'rzp_test_VJxuQHz7BdSF7I', // Replace with your Razorpay Key ID
      'amount': (totalAmount * 100).toInt(), // Convert to paise
      'name': widget.itemName,
      'description': "Payment for ${widget.itemName}",
      'prefill': {
        'contact': '9999999999', // Replace with actual user contact
        'email': 'user@example.com',
      },
      'theme': {'color': '#FF9800'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error: $e");
    }
  }
  //end payment

  TextEditingController deliveryAddress = TextEditingController();

  TextEditingController villageNameController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController stateNameController = TextEditingController();

  void PurchaseItem() async {
    final String DeliveryAddress = deliveryAddress.text.toString();

    final String villageName = villageNameController.text.trim();
    final String landmark = landmarkController.text.trim();
    final String cityName = cityNameController.text.trim();
    final String postalCode = postalCodeController.text.trim();
    final String stateName = stateNameController.text.trim();

    if (villageName.isEmpty ||
        landmark.isEmpty ||
        cityName.isEmpty ||
        postalCode.isEmpty ||
        stateName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Complete Delivery Address is required',
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      try {
        // _openCheckout;
        double totalAmount = double.tryParse(widget.totalPrice) ?? 0;
        var options = {
          'key': 'rzp_test_VJxuQHz7BdSF7I', // Replace with your Razorpay Key ID
          'amount': (totalAmount * 100).toInt(), // Convert to paise
          'name': widget.itemName,
          'description': "Payment for ${widget.itemName}",
          'prefill': {
            'contact': '9999999999', // Replace with actual user contact
            'email': 'user@example.com',
          },
          'theme': {'color': '#FF9800'},
        };

        try {
          _razorpay.open(options);
        } catch (e) {
          print("Error: $e");
        }

        await FirebaseFirestore.instance
            .collection('New Order')
            // .doc(widget.userId)
            // .collection('Order-Items')
            .add({
          'Product Name': widget.itemName,
          'Product Image': widget.itemImage,
          'Product Quantity': widget.itemQuantity,
          'Quantity': widget.quantity,
          'Product Price': widget.itemPrice,
          'SubTotal': widget.subTotal,
          'GST Amount': widget.GSTAmount,
          'Total Amount': widget.totalPrice,
          'Delivery Address':
              '${villageName}, ${landmark}, ${cityName}, ${postalCode}, ${stateName} ',
          'Created At': DateTime.now(),
          'UserId':widget.userId
        });

        await FirebaseFirestore.instance.collection('Order History').doc(widget.userId).collection('Order-Items').add({
          'Product Name': widget.itemName,
          'Product Image': widget.itemImage,
          'Product Quantity': widget.itemQuantity,
          'Quantity': widget.quantity,
          'Product Price': widget.itemPrice,
          'SubTotal': widget.subTotal,
          'GST Amount': widget.GSTAmount,
          'Total Amount': widget.totalPrice,
          'Delivery Address':
              '${villageName}, ${landmark}, ${cityName}, ${postalCode}, ${stateName} ',
          'Created At': DateTime.now(),
        });

        // showDialog(
        //     context: context,
        //     builder: (context) {
        //       return AlertDialog(
        //         backgroundColor: Colors.white,
        //         actions: [
        //           MaterialButton(
        //             onPressed: () {
        //               Navigator.pop(context);
        //               Navigator.pushReplacement(
        //                 context,
        //                 MaterialPageRoute(
        //                   builder: (context) => HomeScreen(),
        //                 ),
        //               );
        //             },
        //             child: Text('Done'),
        //             // child: Icon(Icons.clear),
        //           )
        //         ],
        //         content: Container(
        //           height: 150,
        //           width: double.maxFinite,
        //           child: Column(
        //             children: [
        //               // SizedBox(height: 10.h,),
        //               Image.asset(
        //                 'assets/successLogo.png',
        //                 height: 100,
        //                 width: 100,
        //               ),
        //               SizedBox(
        //                 height: 10.h,
        //               ),
        //               Text(
        //                 'Your order successfully placed!',
        //                 style: AppStyle.smallFont,
        //               ),
        //             ],
        //           ),
        //         ),
        //       );
        //     });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Order Placed Successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );
      } catch (e) {
        print('Error in order ');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Address details'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            InputLabel(title: 'Village Name'),
            SizedBox(
              height: 10,
            ),
            PrimaryTextfield(
                inputValue: villageNameController, hintText: 'Enter address'),
            SizedBox(
              height: 15,
            ),
            // Text(widget.userId),
            InputLabel(title: 'Landmark'),
            SizedBox(
              height: 10,
            ),
            PrimaryTextfield(
                inputValue: landmarkController,
                hintText: 'Reliance Petrol Pump'),
            SizedBox(
              height: 15,
            ),
            InputLabel(title: 'City name'),
            SizedBox(
              height: 10,
            ),
            PrimaryTextfield(inputValue: cityNameController, hintText: 'Patna'),
            SizedBox(
              height: 15,
            ),
            InputLabel(title: 'Postal code'),
            SizedBox(
              height: 10,
            ),
            PrimaryTextfield(
                inputValue: postalCodeController, hintText: '562102'),
            SizedBox(
              height: 15,
            ),
            InputLabel(title: 'State'),
            SizedBox(
              height: 10,
            ),
            PrimaryTextfield(
                inputValue: stateNameController, hintText: 'Bihar'),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  '₹ ${widget.totalPrice}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            PrimaryButton(
              bgColor: Colors.orangeAccent,
              textColor: Colors.white,
              title: 'Proceed to Payment',
              ontTap: () {
                PurchaseItem();
                _openCheckout;

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PaymentScreen(
                //       totalAmount: double.tryParse(widget.totalPrice) ?? 0,
                //       itemName: widget.itemName,
                //       itemImage: widget.itemImage,
                //       itemPrice: widget.itemPrice,
                //       itemQuantity: widget.itemQuantity,
                //     ),
                //   ),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
