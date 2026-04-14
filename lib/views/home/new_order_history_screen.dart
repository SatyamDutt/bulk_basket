import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'order_tracking_screen.dart';

class CartOrderHistoryScreen extends StatefulWidget {
  final String userId;
  const CartOrderHistoryScreen({super.key, required this.userId});

  @override
  State<CartOrderHistoryScreen> createState() => _CartOrderHistoryScreenState();
}

class _CartOrderHistoryScreenState extends State<CartOrderHistoryScreen> {
  List<Map<String, dynamic>> allOrdersList = [];
  final currentUserId = GetStorage().read('userId');

  @override
  void initState() {
    super.initState();
    fetchAllOrder();
  }

  Future<void> fetchAllOrder() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('All Order')
        // .where("UserId", isEqualTo: currentUserId) // ✅ filter by logged in user
        .orderBy("Created At", descending: true)
        .get();

    // setState(() {
    //   allOrdersList =
    //       snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    // });

      setState(() {
    allOrdersList = snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .where((order) => order['UserId'] == currentUserId) // ✅ filter here
        .toList();
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        backgroundColor: Colors.amber,
      ),
      body: allOrdersList.isEmpty
          ? const Center(child: Text("No orders found"))
          : RefreshIndicator.adaptive(
            onRefresh: fetchAllOrder,
            child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: allOrdersList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  var order = allOrdersList[index];
                  List<dynamic> products = order["Products"] ?? [];
            
                  return 
                  // order['UserId'] != GetStorage().read('userId') ? SizedBox() :  
                  
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      tilePadding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order #${order["OrderId"]}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                             /// Order Status
                              Transform.scale(
                                      scale: 0.8,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: order['OrderStatus'] == "Order Delivered"
                                              ? Colors.green
                                              : Colors.orange,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          order['OrderStatus'] ?? "Pending",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    
                                      TextButton(onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderTrackingUIScreen(orderStatus:order['OrderStatus'], orderId: order['OrderId'], )));
                                      }, child: Text('Track Now'))
                                    ],
                                  ),
                                ),
                              )
                           
                        ],
                      ),
                      subtitle: Text(
                        "Total: ₹${order["Total Amount"]}\nStatus: ${order["OrderStatus"]}",
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Address
                              Text(
                                "Delivery Address:",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[700]),
                              ),
                              Text(order["Delivery Address"] ?? ""),
                              const SizedBox(height: 10),
            
                              /// Subtotal & GST
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Subtotal"),
                                  Text("₹ ${order["SubTotal"] ?? 0}"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("GST"),
                                  Text("₹ ${order["GST Amount"] ?? 0}"),
                                ],
                              ),
                              const Divider(),
            
                              /// Products List
                              Column(
                                children: products.map((product) {
                                  return ListTile(
                                    leading: Image.network(
                                      product["Product Image"],
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                    title: Text(product["Product Name"] ?? ""),
                                    subtitle: Text(
                                        "Qty: ${product["Quantity"] ?? 0} | Price: ₹${product["Product Price"] ?? 0}"),
                                    trailing: Text(
                                      "₹ ${(double.tryParse(product["Product Price"].toString()) ?? 0) * (product["Quantity"] ?? 1)}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  );
                                }).toList(),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
          ),
    );
  }
}
