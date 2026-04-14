import 'dart:math';
import 'package:bulk_basket/views/common/input_label.dart';
import 'package:bulk_basket/views/common/primary_button.dart';
import 'package:bulk_basket/views/common/primary_textField.dart';
import 'package:bulk_basket/views/home/product_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

class NewCartOrderAddressScreen extends StatefulWidget {
  // final String userId;
  // final String itemName;
  // final String itemImage;
  // final String itemPrice;
  // final String itemQuantity;
  // final String peoductDesc;
  // final String quantity;
  // final String subTotal;
  // final String GSTAmount;
  // final String totalPrice;

  final String userId;
  final List<Map<String, dynamic>> cartItems; // <-- multiple products
  final String subTotal;
  final String GSTAmount;
  final String totalPrice;
  const NewCartOrderAddressScreen({
    super.key,
    // required this.itemName,
    // required this.itemImage,
    // required this.itemPrice,
    // required this.itemQuantity,
    // required this.peoductDesc,
    // required this.quantity,
    // required this.GSTAmount,
    // required this.totalPrice,
    // required this.subTotal,
    // required this.userId
    required this.userId,
    required this.cartItems,
    required this.subTotal,
    required this.GSTAmount,
    required this.totalPrice,
  });

  @override
  State<NewCartOrderAddressScreen> createState() =>
      _NewCartOrderAddressScreenState();
}

class _NewCartOrderAddressScreenState extends State<NewCartOrderAddressScreen> {
  TextEditingController deliveryAddress = TextEditingController();

  TextEditingController villageNameController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController stateNameController = TextEditingController();

  RxBool isLoading = false.obs;

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

//   void PurchaseItem() async {

//     String orderId = await generateUniqueOrderId();

//     final String villageName = villageNameController.text.trim();
//     final String landmark = landmarkController.text.trim();
//     final String cityName = cityNameController.text.trim();
//     final String postalCode = postalCodeController.text.trim();
//     final String stateName = stateNameController.text.trim();

//     if (villageName.isEmpty ||
//         landmark.isEmpty ||
//         cityName.isEmpty ||
//         postalCode.isEmpty ||
//         stateName.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Complete Delivery Address is required',
//           ),
//           backgroundColor: Colors.red,
//           duration: Duration(seconds: 1),
//         ),
//       );
//     } else {
//       try {
//         await FirebaseFirestore.instance
//             .collection('New Order')
//             .doc(orderId)
//             // .collection('Order-Items')
//             .set({
//           'Product Name': widget.itemName,
//           'Product Image': widget.itemImage,
//           'Product Quantity': widget.itemQuantity,
//           'Quantity': widget.quantity,
//           'Product Price': widget.itemPrice,
//           'SubTotal': widget.subTotal,
//           'GST Amount': widget.GSTAmount,
//           'Total Amount': widget.totalPrice,
//           'Delivery Address':
//               '${villageName}, ${landmark}, ${cityName}, ${postalCode}, ${stateName} ',
//           'Created At': DateTime.now(),
//           'UserId': widget.userId,
//           'OrderStatus': 'Order Placed',
//           'OrderId':orderId
//         });

//         await FirebaseFirestore.instance
//             .collection('All Order')
//             .doc(orderId)
//             // .collection('Order-Items')
//             .set({
//           'Product Name': widget.itemName,
//           'Product Image': widget.itemImage,
//           'Product Quantity': widget.itemQuantity,
//           'Quantity': widget.quantity,
//           'Product Price': widget.itemPrice,
//           'SubTotal': widget.subTotal,
//           'GST Amount': widget.GSTAmount,
//           'Total Amount': widget.totalPrice,
//           'Delivery Address':
//               '${villageName}, ${landmark}, ${cityName}, ${postalCode}, ${stateName} ',
//           'Created At': DateTime.now(),
//           // 'UserId': widget.userId,
//           'UserId': GetStorage().read('userId'),
//           'OrderStatus': 'Order Placed',
//           'OrderId':orderId
//         });

//         await FirebaseFirestore.instance
//             .collection('Order History')
//             .doc(widget.userId)
//             .collection('Order-Items')
//             .doc(orderId)
//             .set({
//           'Product Name': widget.itemName,
//           'Product Image': widget.itemImage,
//           'Product Quantity': widget.itemQuantity,
//           'Quantity': widget.quantity,
//           'Product Price': widget.itemPrice,
//           'SubTotal': widget.subTotal,
//           'GST Amount': widget.GSTAmount,
//           'Total Amount': widget.totalPrice,
//           'Delivery Address':
//               '${villageName}, ${landmark}, ${cityName}, ${postalCode}, ${stateName} ',
//           'Created At': DateTime.now(),
//           'OrderStatus': 'Order Placed',
//           'OrderId':orderId
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Order Placed Successfully'),
//             backgroundColor: Colors.green,
//             duration: Duration(seconds: 1),
//           ),
//         );

//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductScreen()));
//       } catch (e) {
//         print('Error in order ');
//       }
//     }
//   }

  void PurchaseItem() async {
   
   isLoading.value = true;

    String orderId = await generateUniqueOrderId();

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
          content: Text('Complete Delivery Address is required'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    try {
      
      final code = (1000 + Random().nextInt(9000)).toString();

      final deliveryAddress =
          '$villageName, $landmark, $cityName, $postalCode, $stateName';

      // Prepare order data
      final orderData = {
        'OrderId': orderId,
        'UserId': widget.userId,
        'Products': widget.cartItems, // <-- Store all cart items here
        'SubTotal': widget.subTotal,
        'GST Amount': widget.GSTAmount,
        'Total Amount': widget.totalPrice,
        'Delivery Address': deliveryAddress,
        'Created At': DateTime.now(),
        'OrderStatus': 'Order Placed',
        'deliveryCode':code
      };

      // Save in New Order
      // await FirebaseFirestore.instance
      //     .collection('New Order')
      //     .doc(orderId)
      //     .set(orderData);

      // Save in All Order
      await FirebaseFirestore.instance
          .collection('All Order')
          .doc(orderId)
          .set(orderData);

      deleteCartData();

      // // Save in Order History
      // await FirebaseFirestore.instance
      //     .collection('Order History')
      //     .doc(widget.userId)
      //     .collection('Order-Items')
      //     .doc(orderId)
      //     .set(orderData);

      await saveRecentAddress(deliveryAddress);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order Placed Successfully'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ProductScreen()));
          // isLoading.value = false;
    } catch (e) {
      print('Error in order $e');
    } finally {
      isLoading(false);
    }


  }

//delete cart
  final String currentUserId = GetStorage().read('userId');
  Future<void> deleteCartData() async {
    final cartRef = FirebaseFirestore.instance
        .collection('Cart')
        .doc(currentUserId)
        .collection('Cart-Items');

    final snapshot = await cartRef.get();

    for (var doc in snapshot.docs) {
      await cartRef.doc(doc.id).delete();
    }

    // Optionally also delete parent Cart doc if you want
    await FirebaseFirestore.instance
        .collection('Cart')
        .doc(currentUserId)
        .delete();


        
  }

//SAVE ADDRESS

  Future<void> saveRecentAddress(String address) async {
    final addressRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUserId)
        .collection('SavedAddresses');

    // Add new address
    await addressRef.add({
      'address': address,
      'createdAt': DateTime.now(),
    });

    // Fetch all addresses sorted by newest
    final snapshot =
        await addressRef.orderBy('createdAt', descending: true).get();

    // Keep only the latest 2
    if (snapshot.docs.length > 2) {
      final extraDocs = snapshot.docs.skip(2); // Keep first 2, remove rest
      for (var doc in extraDocs) {
        await addressRef.doc(doc.id).delete();
      }
    }
  }

  Future<List<String>> fetchRecentAddresses() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.userId)
        .collection('SavedAddresses')
        .orderBy('createdAt', descending: true)
        .limit(2)
        .get();

    return snapshot.docs.map((doc) => doc['address'] as String).toList();
  }

  void showAddressSuggestionsBottomSheet() async {
    final addresses = await fetchRecentAddresses();

    if (addresses.isEmpty) return; // do nothing if no saved address

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Text(
                'Select a saved delivery address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              ...addresses.map((addr) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    fillAddressFields(addr);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.blue,
                      ),
                    ),
                    child: Text(
                      addr,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  void fillAddressFields(String address) {
    final parts = address.split(',');
    if (parts.length >= 5) {
      villageNameController.text = parts[0].trim();
      landmarkController.text = parts[1].trim();
      cityNameController.text = parts[2].trim();
      postalCodeController.text = parts[3].trim();
      stateNameController.text = parts[4].trim();
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAddressSuggestionsBottomSheet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Address details'),
      ),
      body: Obx( () =>Stack(
        children: [
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
          
                InputLabel(title: 'House No. Building Name'),
                SizedBox(
                  height: 6,
                ),
                PrimaryTextfield(
                    inputValue: villageNameController, hintText: 'Enter address'),
                SizedBox(
                  height: 10,
                ),
                // Text(widget.userId),
                InputLabel(title: 'Landmark'),
                SizedBox(
                  height: 6,
                ),
                PrimaryTextfield(
                    inputValue: landmarkController,
                    hintText: 'Reliance Petrol Pump'),
                SizedBox(
                  height: 10,
                ),
                InputLabel(title: 'City name'),
                SizedBox(
                  height: 6,
                ),
                PrimaryTextfield(inputValue: cityNameController, hintText: 'Patna'),
          
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          InputLabel(title: 'Postal code'),
                          SizedBox(
                            height: 6,
                          ),
                          PrimaryTextfield(
                            inputValue: postalCodeController,
                            hintText: '562102',
                            inputType: TextInputType.phone,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          InputLabel(title: 'State'),
                          SizedBox(
                            height: 6,
                          ),
                          PrimaryTextfield(
                              inputValue: stateNameController, hintText: 'Bihar'),
                        ],
                      ),
                    ),
                  ],
                ),
          
                SizedBox(
                  height: 18,
                ),
               
          
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ---- Payment Options ----
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Payment Option',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.green.shade400),
                            ),
                            child: const Text(
                              'Cash On Delivery',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
          
                      const SizedBox(height: 12),
                      const Divider(thickness: 1.2, color: Colors.grey),
          
                      const SizedBox(height: 10),
          
                      // ---- Subtotal ----
                      _buildPriceRow('Sub Total', '₹ ${widget.subTotal}'),
          
                      const SizedBox(height: 8),
          
                      // ---- GST ----
                      _buildPriceRow('GST Charges', '₹ ${widget.GSTAmount}'),
          
                      const SizedBox(height: 12),
                      const Divider(thickness: 1.2, color: Colors.grey),
          
                      const SizedBox(height: 12),
          
                      // ---- Total ----
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Amount',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '₹ ${widget.totalPrice}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
          
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Inclusive of all taxes',
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey.shade600),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
          
                PrimaryButton(
                  bgColor: Colors.green,
                  textColor: Colors.white,
                  title: 'Place Order',
                  ontTap: () {
                    PurchaseItem();
                  },
                ),
              ],
            ),
          ),

          if(isLoading.value == true) 
          Container(
            color: Colors.black.withOpacity(0.3),
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          )
        ],
      ),)
    );
  }

  // helper widget for price row
  Widget _buildPriceRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
