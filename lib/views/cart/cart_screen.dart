// import 'package:bulk_basket/views/cart/cart_order_confirmation_screen.dart';
// import 'package:bulk_basket/views/cart/cart_product_details_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});
//
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//   }
//
//   var ItemList = [];
//
//   void fetchProducts() async {
//     QuerySnapshot snapshot =
//         await FirebaseFirestore.instance.collection('Cart').get();
//
//     setState(() {
//       ItemList = snapshot.docs;
//     });
//
//     for (var doc in snapshot.docs) {
//       print(doc["ProductName"]);
//     }
//     // print(snapshot.docs.length);
//     // print('Product length');
//     print('helo');
//     print(ItemList.length);
//
//     for (var doc in ItemList) {
//       print('Item List');
//       print(doc["Product Name"]);
//     }
//   }
//
//   void DeleteProduct(String productId) async {
//     await FirebaseFirestore.instance.collection('Cart').doc(productId).delete();
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('1 Item Deleted from Cart'),
//         backgroundColor: Colors.red,
//         duration: Duration(seconds: 1),
//       ),
//     );
//
//     fetchProducts();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.green,
//       appBar: AppBar(
//         backgroundColor: Colors.amber,
//         title: Text('Cart Details'),
//       ),
//       body: SafeArea(
//         child: ItemList.isEmpty
//             ? Center(child: Text('No Items in Cart'))
//             : ListView.separated(
//                 itemCount: ItemList.length,
//                 separatorBuilder: (context, index) {
//                   return Divider();
//                 },
//                 itemBuilder: (context, index) {
//                   var doc = ItemList[index];
//                   return InkWell(
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => CartOrderConfirmationScreen(
//                           itemName: doc["Proudct Name"],
//                           itemImage: doc["Product Image"],
//                           itemPrice: doc["Product Price"],
//                           itemQuantity: '${doc["Product Quantity"].toString()}',
//                         peoductDesc: doc['Product Desc'].toString(), quantity: '${doc["quantity"].toString()}', productId: doc.id,),),);
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   Container(
//                                     child: Column(
//                                       children: [
//                                         Image.asset(
//                                           doc["Product Image"],
//                                           // child: Image.asset(
//                                           //   'assets/cartImage.png',
//                                           width: 100,
//                                           height: 100,
//                                           fit: BoxFit.cover,
//                                         ),
//
//                                         Text(
//                                             ' Qty: ${doc["quantity"].toString()}'),
//                                       ],
//                                     ),
//                                   ),
//                                   Column(
//                                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Text(
//                                             doc["Proudct Name"],
//                                             style: TextStyle(
//                                               fontSize: 20,
//                                             ),
//                                           ),
//                                           Text(
//                                             " (${doc["Product Quantity"].toString()} )",
//                                             style: TextStyle(
//                                               fontSize: 20,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Text(
//                                         '₹ ${doc["Product Price"]}',
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                       Container(
//                                         width: 200,
//                                         child: Text('${doc['Product Desc']}',
//                                         overflow: TextOverflow.ellipsis,
//                                           maxLines: 3,
//                                         ),
//                                       ),
//
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   IconButton(
//                                       onPressed: () {
//                                         DeleteProduct(doc.id);
//                                       },
//                                       icon: Icon(Icons.delete)),
//                                   SizedBox(
//                                     height: 50,
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }),
//       ),
//     );
//   }
// }

import 'package:bulk_basket/views/cart/cart_order_confirmation_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  final String userId;
  const CartScreen({super.key,
  required this.userId
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var ItemList = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Cart').doc(widget.userId).collection('Cart-Items').get();

    setState(() {
      ItemList = snapshot.docs;
    });

    for (var doc in snapshot.docs) {
      print(doc["Product Name"]);
    }
  }

  void DeleteProduct(String productId) async {
    await FirebaseFirestore.instance.collection('Cart').doc(widget.userId).collection('Cart-Items').doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('1 Item Deleted from Cart'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ),
    );

    fetchProducts();
  }

  void updateQuantity(String productId, int newQuantity) async {
    await FirebaseFirestore.instance.collection('Cart').doc(widget.userId).collection('Cart-Items').doc(productId).update({
      'quantity': newQuantity,
    });

    // Refresh the product list to reflect the updated quantity
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Cart Details'),
      ),
      body: SafeArea(
        child: ItemList.isEmpty
            ? Center(child: Text('No Items in Cart'))
            : ListView.separated(
                itemCount: ItemList.length,
                separatorBuilder: (context, index) {
                  return SizedBox();
                },
                itemBuilder: (context, index) {
                  var doc = ItemList[index];
                  int quantity = doc["quantity"];

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartOrderConfirmationScreen(
                            itemName: doc["Product Name"],
                            itemImage: doc["Product Image"],
                            itemPrice: doc["Product Price"],
                            itemQuantity: '${doc["Product Quantity"]}',
                            peoductDesc: doc['Product Desc'].toString(),
                            quantity: '$quantity',
                            productId: doc.id, userId: widget.userId,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Image.network(
                                              doc["Product Image"],
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                            Text(
                                                'Qty: ${doc["quantity"].toString()}'),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              // Text(doc.id),
                                              Text(
                                                doc["Product Name"],
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Text(
                                                " (${doc["Product Quantity"]})",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '₹ ${doc["Product Price"]}',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Container(
                                            width: 200,
                                            child: Text(
                                              '${doc['Product Desc']}',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          DeleteProduct(doc.id);
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                      SizedBox(height: 50),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              // Increment/Decrement Quantity Row
                              Container(
                                height: 35.h,
                                width: 110,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (quantity > 1) {
                                          setState(() {
                                            quantity--;
                                          });
                                          updateQuantity(doc.id, quantity);
                                        }
                                      },
                                      icon: Icon(Icons.remove),
                                    ),
                                    Text(
                                      quantity.toString(),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          quantity++;
                                        });
                                        updateQuantity(doc.id, quantity);
                                      },
                                      icon: Icon(Icons.add),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider()
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
