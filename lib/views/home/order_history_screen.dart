import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  }

  List historyItems = [];
  void fetchOrderHistory() async {
    // QuerySnapshot snapshot =
    await FirebaseFirestore.instance
        .collection('Order History')
        .doc(widget.userId)
        .collection('Order-Items')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        historyItems = snapshot.docs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text('Order history'),
        ),
        body: SafeArea(
          child: historyItems.isEmpty
              ? Center(
                  child: Text('No history Items'),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: historyItems.length,
                  itemBuilder: (context, index) {
                    var Items = historyItems[index];
                    return Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.network(
                            Items['Product Image'],
                            height: 100,
                            width: 100,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${Items['Product Name']}',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  Text(' (${Items['Product Quantity']} )'),
                                ],
                              ),
                              Text(
                                '₹ ${Items['Total Amount']}',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text('Qty: ${Items['Quantity']}'),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
        ));
  }
}
