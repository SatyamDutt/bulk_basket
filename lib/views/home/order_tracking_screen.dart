import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class OrderTrackingUIScreen extends StatefulWidget {
  final String orderStatus;
  final String orderId;
  const OrderTrackingUIScreen({super.key, required this.orderStatus, required this.orderId});

  @override
  State<OrderTrackingUIScreen> createState() => _OrderTrackingUIScreenState();
}

class _OrderTrackingUIScreenState extends State<OrderTrackingUIScreen> {

  final List<String> orderStatusList = [
      "Order Placed",
      "Order Packed",
      "Order Shipped",
      "Out for Delivery",
      "Order Delivered"
    ];
    

   int currentStep = 0; // Change this to highlight progress (0-3)

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadStatus();
    loadOrderDetails();
  }

  var deliveryData = {};
  var deliveryCode = "";


  void loadOrderDetails() async {
    final userId = await GetStorage().read("userId");

    log("UserIDdd: ${userId} && ${widget.orderId}",name: "USERID");

    final snapshot = await FirebaseFirestore.instance.collection("All Order").doc(widget.orderId).get();
if (!snapshot.exists) {
    debugPrint("Delivery boy document does not exist");
    return;
  }
  setState(() {
    
  });
    final data = snapshot.data()!;
    // if(data['UserId'] == userId) {
    //   deliveryData = data['deliveryBoyDetails'];
    // }

      if (data['UserId'] == userId &&
      data['deliveryBoyDetails'] != null &&
      data['deliveryBoyDetails'] is Map) {
    setState(() {
      deliveryCode = data['deliveryCode'];
      deliveryData =
          Map<String, dynamic>.from(data['deliveryBoyDetails']);
    });
  } else {
    debugPrint("deliveryBoyDetails is null or invalid");
  }
    
  }

  void loadStatus() {
    if(widget.orderStatus == 'Order Placed'){
      currentStep = 0; 
    } else if(widget.orderStatus == 'Order Packed'){
      currentStep = 1;
    } else if(widget.orderStatus == 'Order Shipped'){
      currentStep = 2;
    } else if(widget.orderStatus == 'Out for delivery') {
      currentStep = 3;
    } else if(widget.orderStatus == 'Order Delivered'){
      currentStep = 4;
    }
  }
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Track Your Order",
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.deepOrange),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // if(deliveryData.isNotEmpty)
            if(currentStep == 3)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Delivery Code",
                style: TextStyle(fontWeight: FontWeight.w600,
                fontSize: 15,
                ),
                ),
                Text('$deliveryCode',
                style: TextStyle(fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Colors.deepOrange
                ),
                )
              ],
            ),
            SizedBox(height: 10,),
            // if(deliveryData.isNotEmpty)
            if(currentStep == 3)
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: orderStatusList.length,
                itemBuilder: (context, index) {
                  final bool isActive = index <= currentStep;
                  final bool isLast = index == orderStatusList.length - 1;
              
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Icon(
                                isActive
                                    ? Icons.check_circle
                                    : Icons.radio_button_off_outlined,
                                color: isActive ? Colors.green : Colors.grey,
                                size: 28,
                              ),
                              if (!isLast)
                                Container(
                                  height: 50,
                                  width: 2,
                                  color:isActive ? Colors.green : Colors.grey.shade300,
                                ),
                            ],
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  orderStatusList[index],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        isActive ? Colors.black : Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "2025-05-01 10:00 AM", // Dummy timestamp
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 10,),
            if(currentStep >= 3)
            _buildDeliveryPartnerCard(),
          ],
        ),
      ),
    );

    
  }

  Widget _buildDeliveryPartnerCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      gradient: const LinearGradient(
        // colors: [Color(0xFF1FA2FF), Color(0xFF12D8FA), Color(0xFFA6FFCB)],
        colors: [Colors.green,Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 10,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      children: [
        // Profile Image
        Container(
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: const CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage("assets/delivery_boy.jpg",),
          ),
        ),

        const SizedBox(width: 14),

        // Name & phone
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Delivery Partner",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 4),
              Text(
                deliveryData?['fullName'] ?? "",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
               deliveryData?['phone'] ?? "",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        // Call Button
        GestureDetector(
          onTap: () {
            // call action
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 6,
                )
              ],
            ),
            child: const Icon(
              Icons.call,
              color: Colors.green,
              size: 24,
            ),
          ),
        ),
      ],
    ),
  );
}

}


