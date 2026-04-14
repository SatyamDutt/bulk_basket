import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;
  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection("All Order")
            .doc(orderId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var order = snapshot.data!;
          List products = order["Products"];

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text("Order ID: ${order["OrderId"]}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              Text("Status: ${order["OrderStatus"]}"),
              Text("Delivery Address: ${order["Delivery Address"]}"),
              Text("Placed on: ${order["Created At"].toDate()}"),

              const Divider(height: 20),

              /// Products List
              ...products.map((p) => ListTile(
                    leading: Image.network(p["Product Image"], width: 50),
                    title: Text(p["Product Name"]),
                    subtitle:
                        Text("Qty: ${p["Quantity"]} | Price: ₹${p["Product Price"]}"),
                    trailing: Text(
                      "₹ ${(double.tryParse(p["Product Price"].toString()) ?? 0) * (p["Quantity"] ?? 1)}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )),

              const Divider(height: 20),

              /// Price Summary
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Subtotal:"),
                  Text("₹ ${order["SubTotal"]}"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("GST:"),
                  Text("₹ ${order["GST Amount"]}"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Delivery:"),
                  Text("₹ 0"),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("₹ ${order["Total Amount"]}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
