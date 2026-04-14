import 'dart:math';

import 'package:bulk_basket/views/common/input_label.dart';
import 'package:bulk_basket/views/common/primary_button.dart';
import 'package:bulk_basket/views/common/primary_textField.dart';
import 'package:bulk_basket/views/home/product_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

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
      required this.userId});

  @override
  State<OrderAddressScreen> createState() => _OrderAddressScreenState();
}

class _OrderAddressScreenState extends State<OrderAddressScreen> {
  TextEditingController deliveryAddress = TextEditingController();

  TextEditingController villageNameController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController stateNameController = TextEditingController();


/// Generate a unique order ID like ORDR1234567
Future<String> generateUniqueOrderId() async {
  final random = Random();
  String orderId = '';

  bool exists = true;

  while (exists) {
    // Generate 7 digit random number
    int randomNumber = 1000000 + random.nextInt(9000000);
    orderId = "ORDR$randomNumber";

    // Check in Firestore if this order ID already exists
    final querySnapshot = await FirebaseFirestore.instance
        .collection('New Order')
        .where('OrderId', isEqualTo: orderId)
        .get();

    exists = querySnapshot.docs.isNotEmpty;
  }

  return orderId;
}


  void PurchaseItem() async {

    String orderId = await generateUniqueOrderId();

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
        await FirebaseFirestore.instance
            .collection('New Order')
            .doc(orderId)
            // .collection('Order-Items')
            .set({
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
          'UserId': widget.userId,
          'OrderStatus': 'Order Placed',
          'OrderId':orderId
        });

        await FirebaseFirestore.instance
            .collection('All Order')
            .doc(orderId)
            // .collection('Order-Items')
            .set({
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
          // 'UserId': widget.userId,
          'UserId': GetStorage().read('userId'),
          'OrderStatus': 'Order Placed',
          'OrderId':orderId
        });

        await FirebaseFirestore.instance
            .collection('Order History')
            .doc(widget.userId)
            .collection('Order-Items')
            .doc(orderId)
            .set({
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
          'OrderStatus': 'Order Placed',
          'OrderId':orderId
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Order Placed Successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductScreen()));
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
