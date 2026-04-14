import 'dart:developer';

import 'package:bulk_basket/views/home/order_tracking_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class OrderHistoryScreen extends StatefulWidget {
  final String userId;
  const OrderHistoryScreen({super.key,
  required this.userId
  });

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
    fetchOrderHistory();
    fetchAllOrder();
  }

  List historyItems = [];
  void fetchOrderHistory() async {
    // QuerySnapshot snapshot =
    // await FirebaseFirestore.instance
    //     .collection('Order History')
    //     .doc(widget.userId)
    //     .collection('Order-Items')
    //     .snapshots()
    //     .listen((snapshot) {
    //   setState(() {
    //     historyItems = snapshot.docs;
    //   });
    // });
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('All Order').get();

    setState(() {
      historyItems = snapshot.docs;
    });
    
  }

  List allOrdersList = [];
  Future<void> fetchAllOrder() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('All Order').get();

    setState(() {
      allOrdersList = snapshot.docs;
    });
  }

  final currentUserId = GetStorage().read('userId');

  @override
  Widget build(BuildContext context) {
    return
    //old code
    //  Scaffold(
    //     appBar: AppBar(
    //       backgroundColor: Colors.amber,
    //       title: Text('Order history'),
    //     ),
    //     body: SafeArea(
    //       child: historyItems.isEmpty
    //           ? Center(
    //               child: Text('No history Items'),
    //             )
    //           : ListView.separated(
    //               separatorBuilder: (context, index) {
    //                 return Divider();
    //               },
    //               itemCount: historyItems.length,
    //               itemBuilder: (context, index) {
    //                 var Items = historyItems[index];
    //                 return Container(
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     children: [
    //                       Image.network(
    //                         Items['Product Image'],
    //                         height: 100,
    //                         width: 100,
    //                       ),
    //                       Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Row(
    //                             children: [
    //                               Text(
    //                                 '${Items['Product Name']}',
    //                                 style: TextStyle(
    //                                   fontSize: 18.sp,
    //                                 ),
    //                               ),
    //                               Text(' (${Items['Product Quantity']} )'),
    //                             ],
    //                           ),
    //                           Text(
    //                             '₹ ${Items['Total Amount']}',
    //                             style: TextStyle(
    //                               fontSize: 16.sp,
    //                               fontWeight: FontWeight.w600,
    //                             ),
    //                           ),
    //                           Text('Qty: ${Items['Quantity']}'),
    //                         ],
    //                       )
    //                     ],
    //                   ),
    //                 );
    //               }),
    //     ));
 
    //end old code
 
 RefreshIndicator.adaptive(
  onRefresh: fetchAllOrder,
   child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text('Order History'),
        ),
        body: SafeArea(
          child: allOrdersList.isEmpty
              ? const Center(
                  child: Text(
                    'No Orders Yet',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: allOrdersList.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    var order = allOrdersList[index];
                    log(widget.userId);
                    log(order['UserId'],name: 'Current id');
                    log(currentUserId.toString(),name: 'saved Id');
   
                    return order['UserId'] != currentUserId ? SizedBox() : Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Order Header (ID + Date/Time + Status)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Order ID: ${order['OrderId']}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      DateFormat('dd MMM yyyy')
                                          .format(DateTime.now()),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      DateFormat('hh:mm a')
                                          .format(DateTime.now()),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
   
                            const SizedBox(height: 8),
   
                            /// Product Row
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    order['Product Image'] ?? "",
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        order['Product Name'] ?? "",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "(${order['Product Quantity']})",
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Qty: ${order['Quantity']}",
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "₹ ${order['SubTotal']}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
   
                            const Divider(height: 20),
   
                            /// Charges
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("GST"),
                                Text("₹ ${order['GST Amount']}"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Delivery Charges"),
                                Text("₹ 0"),
                              ],
                            ),
   
                            const Divider(height: 20),
   
                            /// Total
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total Amount",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "₹ ${order['Total Amount']}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
   
                            const SizedBox(height: 12),
   
                            /// Address
                            Text(
                              "Delivery Address:",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              order['Delivery Address'] ?? "",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
   
                            const SizedBox(height: 12),
   
                            /// Order Status
                            Align(
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
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => OrderTrackingUIScreen(orderStatus:order['OrderStatus'],orderId:order['OrderId'] , )));
                                  }, child: Text('Track Now'))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
 );
  }
}
