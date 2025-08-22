// import 'package:bulk_basket/resources/app_strings.dart';
// import 'package:bulk_basket/views/cart/cart_screen.dart';
// import 'package:bulk_basket/views/home/order_history_screen.dart';
// import 'package:bulk_basket/views/home/product_details_screen.dart';
// import 'package:bulk_basket/views/home/profile_screen.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   TextEditingController searchItem = TextEditingController();



//   //end of search
//   IconData? clearIcon = null;

//   var categoryImages = [];

//   var purchaseItemsNames = [
//     "Ashirwad wheat",
//     "Basmati Rice",
//     "Fresh Sugar",
//     "Mustard Oil",
//     "Ring Cereal"
//   ];

//   var purchaseItemsImages = [
//     "assets/aashirvaad-wheat-flour.jpg",
//     "assets/basmatiRice.png",
//     "assets/jsagdfaghj.png",
//     "assets/61A1MNF8b2L.jpg",
//     "assets/cereal.jpg"
//   ];

//   int quantity = 0;

//   var purchaseItemPrice = ["225.0", "525.0", "165.0", "155.0", "329.0"];

//   var purchaseItemQuatity = ["5 kg", "5 kg", "2kg", "1 Ltr.", "750 g"];

//   var productDesc = [
//     AppStrings.ashirwadWeight,
//     AppStrings.basmatiRice,
//     AppStrings.freshSugar,
//     AppStrings.mustardOil,
//     AppStrings.ringCerelacDesc
//   ];

//   Future AddProducts(
//       String itemName, ItemImage, itemQuantity, itemPrice) async {
//     await FirebaseFirestore.instance.collection('Products').add({
//       'Productname': itemName,
//       'Product Image': ItemImage,
//       'Product Quantity': itemQuantity,
//       'Product Price': itemPrice
//     });
//   }

//   var sliderImage = [
//     'assets/banner1.jpg',
//     'assets/banner2.jpg',
//     'assets/banner3.jpg',
//     'assets/banner4.jpg'
//   ];

//   int activeIndex = 0;

//   int num = 0;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetchProduct();
//     riceAndFlour();
//     fetchCartItem();
//     dryFruitsCategory();
//   }

//   void fetchCartItem() {
//     FirebaseFirestore.instance
//         .collection('Cart')
//         .snapshots()
//         .listen((snapshot) {
//       setState(() {
//         num = snapshot.docs.length;
//       });
//     });
//   }

//   //for Snacks and biscuits
//   // String name = 'Product';
//   // String? imagePath;

//   List productList = [];

//   void fetchProduct() async {
//     try {
//       QuerySnapshot snapshot = await FirebaseFirestore.instance
//           .collection('New Product')
//           .doc('Category')
//           .collection('Snacks & Biscuits')
//           .get();

//       setState(() {
//         productList = snapshot.docs;
//       });

//       for (var doc in snapshot.docs) {
//         print(doc.data().toString());
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

// //for Rice and flour
//   List riceAndFlourList = [];
//   void riceAndFlour() async {
//     try {
//       QuerySnapshot snapshot = await FirebaseFirestore.instance
//           .collection('New Product')
//           .doc('Category')
//           .collection('Rice and floor')
//           .get();

//       setState(() {
//         riceAndFlourList = snapshot.docs;
//       });

//       for (var doc in snapshot.docs) {
//         print(doc.data().toString());
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   //for dry fruits
//   List dryFruitsList = [];
//   void dryFruitsCategory() async {
//     try {
//       QuerySnapshot snapshot = await FirebaseFirestore.instance
//           .collection('New Product')
//           .doc('Category')
//           .collection('Dry Fruits')
//           .get();

//       setState(() {
//         dryFruitsList = snapshot.docs;
//       });

//       for (var doc in snapshot.docs) {
//         print(doc.data().toString());
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('BulkBasket'),
//         actions: [
//           Padding(
//             padding: EdgeInsets.only(right: 10.0),
//             child: IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.logout_outlined,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               child: ListView(
//                 children: [
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   TextField(
//                     controller: searchItem,
//                     onChanged: (value) {
//                       // if(searchItem.text == value){
//                       //   purchaseItemsNames.first =
//                       // }
//                       setState(() {
//                         searchItem.text.isEmpty
//                             ? clearIcon = null
//                             : clearIcon = Icons.clear;
//                       });
//                     },
//                     decoration: InputDecoration(
//                       hintText: 'Search Products',
//                       hintStyle: TextStyle(
//                         color: Colors.grey,
//                       ),

//                       suffixIcon: searchItem.text.isEmpty
//                           ? null
//                           : IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   searchItem.clear();
//                                   clearIcon = null;
//                                 });
//                               },
//                               icon: Icon(clearIcon)),
//                       // searchItem.text.isEmpty ? null : Icon(Icons.clear),
//                       border: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.black,
//                           ),
//                           borderRadius: BorderRadius.circular(5.r)),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   CarouselSlider.builder(
//                     itemBuilder: (contex, index, realIdnex) {
//                       return Image.asset(sliderImage[index]);
//                     },
//                     itemCount: 4,
//                     options: CarouselOptions(
//                       autoPlay: true,
//                       viewportFraction: 1,
//                       onPageChanged: (index, reason) {
//                         setState(() {
//                           activeIndex = index;
//                         });
//                       },
//                     ),
//                   ),
//                   Center(
//                     child: Transform.scale(
//                       scale: 0.5,
//                       child: AnimatedSmoothIndicator(
//                           activeIndex: activeIndex, count: sliderImage.length),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         'Explore Groceries',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   Container(
//                     height: 125,
//                     child: ListView(
//                       scrollDirection: Axis.horizontal,
//                       children: [
//                         Column(
//                           children: [
//                             Image.asset(
//                               'assets/flourRice.png',
//                               // height: 100.h,
//                               width: 110.w,
//                             ),
//                             Text('Flour,Rice etc')
//                           ],
//                         ),
//                         SizedBox(
//                           width: 20.w,
//                         ),
//                         Column(
//                           children: [
//                             Image.asset(
//                               'assets/dryFruits.png',
//                               // height: 100.h,
//                               width: 90.w,
//                             ),
//                             Text('Dry Fruits')
//                           ],
//                         ),
//                         SizedBox(
//                           width: 15.w,
//                         ),
//                         Column(
//                           children: [
//                             Image.asset(
//                               'assets/cereals.png',
//                               // height: 100.h,
//                               width: 80.w,
//                             ),
//                             Text('Cereals')
//                           ],
//                         ),
//                         SizedBox(
//                           width: 10.w,
//                         ),
//                         Column(
//                           children: [
//                             Image.asset(
//                               'assets/spices.jpg',
//                               // height: 100.h,
//                               width: 100.w,
//                             ),
//                             Text('Spices')
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     width: 5.w,
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         'Trending fashion',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     height: 125,
//                     child: ListView(
//                       scrollDirection: Axis.horizontal,
//                       children: [
//                         Column(
//                           children: [
//                             Image.asset(
//                               'assets/groomingItems.jpg',
//                               // height: 100.h,
//                               width: 85.w,
//                             ),
//                             Text('Grooming Items')
//                           ],
//                         ),
//                         SizedBox(
//                           width: 10.w,
//                         ),
//                         Column(
//                           children: [
//                             Image.asset(
//                               'assets/skinCareItems.png',
//                               // height: 100.h,
//                               width: 125.w,
//                             ),
//                             Text('Skin Care')
//                           ],
//                         ),
//                         SizedBox(
//                           width: 10.w,
//                         ),
//                         Column(
//                           children: [
//                             Image.asset(
//                               'assets/electronics.png',
//                               // height: 100.h,
//                               width: 100.w,
//                             ),
//                             Text('Electronics Gadgets')
//                           ],
//                         ),
//                         SizedBox(
//                           width: 10.w,
//                         ),
//                         Column(
//                           children: [
//                             Image.asset(
//                               'assets/fashionItems.png',
//                               // height: 100.h,
//                               width: 100.w,
//                             ),
//                             Text('Fashion Items')
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         'Purchase Now',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 12.h,
//                   ),
//                   Container(
//                     height: 180,
//                     child: ListView.separated(
//                         separatorBuilder: (context, index) {
//                           return SizedBox(
//                             width: 25,
//                           );
//                         },
//                         scrollDirection: Axis.horizontal,
//                         itemCount: productList.length,
//                         itemBuilder: (context, index) {
//                           var product = productList[index];
//                           return InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ProductDetailsScreen(
//                                       itemName:
//                                           '${product['productName'].toString()}',
//                                       itemImage: '${product['productImage']}',
//                                       itemPrice: '${product['productPrice']}',
//                                       itemQuantity:
//                                           '${product['productQuantity']}',
//                                       productDesc: '${product['productDesc']}'),
//                                 ),
//                               );
//                             },
//                             child: Column(
//                               children: [
//                                 Image.network(
//                                   product['productImage'],
//                                   width: 100,
//                                   height: 100,
//                                 ),
//                                 Container(
//                                     width: 90,
//                                     child: Text(
//                                       '${product['productName'].toString()}',
//                                       style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w500),
//                                       overflow: TextOverflow.ellipsis,
//                                       textAlign: TextAlign.start,
//                                     )),
//                                 Text('(${product['productQuantity']})'),
//                                 Text(
//                                   '₹ ${product['productPrice']}',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),

//                                 // Text('${product['productDesc']}'),
//                               ],
//                             ),
//                           );
//                         }),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     'Rice and Flour',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),

//                   // rice and flour
//                   Container(
//                     height: 180,
//                     child: ListView.separated(
//                         separatorBuilder: (context, index) {
//                           return SizedBox(
//                             width: 25,
//                           );
//                         },
//                         scrollDirection: Axis.horizontal,
//                         itemCount: riceAndFlourList.length,
//                         itemBuilder: (context, index) {
//                           var product = riceAndFlourList[index];
//                           return InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ProductDetailsScreen(
//                                       itemName:
//                                           '${product['productName'].toString()}',
//                                       itemImage: '${product['productImage']}',
//                                       itemPrice: '${product['productPrice']}',
//                                       itemQuantity:
//                                           '${product['productQuantity']}',
//                                       productDesc: '${product['productDesc']}'),
//                                 ),
//                               );
//                             },
//                             child: Column(
//                               children: [
//                                 Image.network(
//                                   product['productImage'],
//                                   width: 100,
//                                   height: 100,
//                                 ),
//                                 Container(
//                                     width: 110,
//                                     child: Text(
//                                       '${product['productName'].toString()}',
//                                       style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w500),
//                                       overflow: TextOverflow.ellipsis,
//                                       textAlign: TextAlign.start,
//                                     )),
//                                 Text('(${product['productQuantity']})'),
//                                 Text(
//                                   '₹ ${product['productPrice']}',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),

//                                 // Text('${product['productDesc']}'),
//                               ],
//                             ),
//                           );
//                         }),
//                   ),

//                   SizedBox(
//                     height: 20,
//                   ),
//                   //dry fruits
//                   Text('Dry Fruits'),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     height: 180,
//                     child: ListView.separated(
//                         separatorBuilder: (context, index) {
//                           return SizedBox(
//                             width: 25,
//                           );
//                         },
//                         scrollDirection: Axis.horizontal,
//                         itemCount: dryFruitsList.length,
//                         itemBuilder: (context, index) {
//                           var product = dryFruitsList[index];
//                           return InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ProductDetailsScreen(
//                                       itemName:
//                                           '${product['productName'].toString()}',
//                                       itemImage: '${product['productImage']}',
//                                       itemPrice: '${product['productPrice']}',
//                                       itemQuantity:
//                                           '${product['productQuantity']}',
//                                       productDesc: '${product['productDesc']}'),
//                                 ),
//                               );
//                             },
//                             child: Column(
//                               children: [
//                                 Image.network(
//                                   product['productImage'],
//                                   width: 100,
//                                   height: 100,
//                                 ),
//                                 Container(
//                                     width: 110,
//                                     child: Text(
//                                       '${product['productName'].toString()}',
//                                       style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w500),
//                                       overflow: TextOverflow.ellipsis,
//                                       textAlign: TextAlign.start,
//                                     )),
//                                 Text('(${product['productQuantity']})'),
//                                 Text(
//                                   '₹ ${product['productPrice']}',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),

//                                 // Text('${product['productDesc']}'),
//                               ],
//                             ),
//                           );
//                         }),
//                   ),

//                   SizedBox(
//                     height: 100,
//                   ),
//                   // Container(
//                   //   height: 270,
//                   //   child: ListView.builder(
//                   //       scrollDirection: Axis.horizontal,
//                   //       itemCount: 5,
//                   //       itemBuilder: (context, index) {
//                   //         return Row(
//                   //           children: [
//                   //             InkWell(
//                   //               onTap: () {
//                   //                 Navigator.push(
//                   //                   context,
//                   //                   MaterialPageRoute(
//                   //                     builder: (context) =>
//                   //                         ProductDetailsScreen(
//                   //                       itemName: purchaseItemsNames[index],
//                   //                       itemImage: purchaseItemsImages[index],
//                   //                       itemPrice: purchaseItemPrice[index],
//                   //                       itemQuantity:
//                   //                           purchaseItemQuatity[index],
//                   //                       productDesc: productDesc[index],
//                   //                     ),
//                   //                   ),
//                   //                 );
//                   //               },
//                   //               child: Container(
//                   //                 width: 160,
//                   //                 decoration: BoxDecoration(
//                   //                   color: Colors.transparent,
//                   //                   borderRadius: BorderRadius.circular(10.r),
//                   //                   // border: Border.all(
//                   //                   //   color: Colors.grey,
//                   //                   // ),
//                   //                 ),
//                   //                 child: Padding(
//                   //                   padding: EdgeInsets.symmetric(
//                   //                       horizontal: 15.0, vertical: 15),
//                   //                   child: Column(
//                   //                     children: [
//                   //                       Image.asset(
//                   //                         '${purchaseItemsImages[index]}',
//                   //                         // 'assets/aashirvaad-wheat-flour.jpg',
//                   //                         height: 125,
//                   //                       ),
//                   //                       Row(
//                   //                         children: [
//                   //                           Text(
//                   //                             '${purchaseItemsNames[index]}',
//                   //                             style: TextStyle(
//                   //                                 fontSize: 16,
//                   //                                 fontWeight: FontWeight.w600),
//                   //                           ),
//                   //                         ],
//                   //                       ),
//                   //                       Row(
//                   //                         mainAxisAlignment:
//                   //                             MainAxisAlignment.spaceBetween,
//                   //                         children: [
//                   //                           Text(purchaseItemQuatity[index]),
//                   //                           Text(
//                   //                             '₹ ${purchaseItemPrice[index]}',
//                   //                             style: TextStyle(
//                   //                                 fontSize: 16,
//                   //                                 fontWeight: FontWeight.w600),
//                   //                           ),
//                   //                         ],
//                   //                       ),
//                   //                       // Row(
//                   //                       //   mainAxisAlignment:
//                   //                       //       MainAxisAlignment.center,
//                   //                       //   children: [
//                   //                       //     InkWell(
//                   //                       //       onTap: () {
//                   //                       //         setState(() {
//                   //                       //           quantity++;
//                   //                       //         });
//                   //                       //         //   AddProducts(
//                   //                       //         //       purchaseItemsNames[index],
//                   //                       //         //       purchaseItemsImages[index],
//                   //                       //         //       quantity,
//                   //                       //         //       purchaseItemPrice[index]);
//                   //                       //       },
//                   //                       //       child: Container(
//                   //                       //         decoration: BoxDecoration(
//                   //                       //             // borderRadius: BorderRadius.circular(100),
//                   //                       //             border: Border.all(
//                   //                       //           width: 1.2,
//                   //                       //           color: Color(0xff53B175),
//                   //                       //         )),
//                   //                       //         child: Padding(
//                   //                       //           padding:
//                   //                       //               const EdgeInsets.all(2.0),
//                   //                       //           child: Icon(
//                   //                       //             Icons.add,
//                   //                       //             color: Colors.green,
//                   //                       //           ),
//                   //                       //         ),
//                   //                       //       ),
//                   //                       //     ),
//                   //                       //     Text('${quantity}'),
//                   //                       //     InkWell(
//                   //                       //       onTap: () {
//                   //                       //         quantity++;
//                   //                       //         AddProducts(
//                   //                       //             purchaseItemsNames[index],
//                   //                       //             purchaseItemsImages[index],
//                   //                       //             quantity,
//                   //                       //             purchaseItemPrice[index]);
//                   //                       //       },
//                   //                       //       child: Container(
//                   //                       //         decoration: BoxDecoration(
//                   //                       //             // borderRadius: BorderRadius.circular(100),
//                   //                       //             border: Border.all(
//                   //                       //           width: 1.2,
//                   //                       //           color: Color(0xff53B175),
//                   //                       //         )),
//                   //                       //         child: Padding(
//                   //                       //           padding:
//                   //                       //               const EdgeInsets.all(2.0),
//                   //                       //           child: Icon(
//                   //                       //             Icons.add,
//                   //                       //             color: Colors.green,
//                   //                       //           ),
//                   //                       //         ),
//                   //                       //       ),
//                   //                       //     ),
//                   //                       //   ],
//                   //                       // ),
//                   //                     ],
//                   //                   ),
//                   //                 ),
//                   //               ),
//                   //             ),
//                   //             SizedBox(
//                   //               width: 15.w,
//                   //             ),
//                   //           ],
//                   //         );
//                   //       }),
//                   // ),
//                   // SizedBox(
//                   //   height: 15,
//                   // ),
//                   // Text('Essential Groceries'),
//                   // SizedBox(
//                   //   height: 50,
//                   // ),
//                   // // Container(
//                   // //   height: 350,
//                   // //   child: ListView.builder(
//                   // //           itemCount: productList.length,
//                   // //           itemBuilder: (context, index) {
//                   // //             var product = productList[index];
//                   // //           return Column(
//                   // //             children: [
//                   // //               Image.network(product['productImage'],
//                   // //               height: 150,
//                   // //               width: 150,
//                   // //               ),
//                   // //               Text('${product['productName'].toString()}'),
//                   // //               Text('${product['productPrice']}'),
//                   // //               Text('${product['productQuantity']}'),
//                   // //               Text('${product['productDesc']}'),

//                   // //             ],
//                   // //           );
//                   // //         }),
//                   // // ),
//                   // // SizedBox(height: 100,),
//                 ],
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 height: 50.h,
//                 color: Colors.white,
//                 child: Row(
//                   children: [
//                     Expanded(
//                         child: MaterialButton(
//                       height: double.maxFinite,
//                       onPressed: () {},
//                       child: Icon(Icons.home_outlined, size: 30.r
//                           // weight: 2,
//                           ),
//                     )),
//                     Expanded(
//                         child: MaterialButton(
//                       height: double.maxFinite,
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => CartScreen(),
//                           ),
//                         );
//                       },
//                       child: Stack(
//                         clipBehavior:
//                             Clip.none, // Allows overflow for positioning
//                         children: [
//                           Icon(Icons.shopping_cart_outlined,
//                               size: 30), // Cart icon

//                           // Badge for the cart count
//                           Positioned(
//                             right: -8, // Adjust position to fit properly
//                             top: -8,
//                             child: Container(
//                               padding:
//                                   EdgeInsets.all(4), // Padding inside the badge
//                               decoration: BoxDecoration(
//                                 color: Colors.red, // Background color for badge
//                                 shape: BoxShape.circle, // Makes it a circle
//                               ),
//                               constraints: BoxConstraints(
//                                 minWidth: 20,
//                                 minHeight: 20,
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   '$num',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),

//                       // child: Stack(
//                       //   children: [
//                       //     Align(
//                       //       alignment: Alignment.center,
//                       //       child: Icon(Icons.shopping_cart_outlined,
//                       //       size: 32,
//                       //       )),
//                       //     Align(
//                       //       alignment: Alignment.topRight,
//                       //       child: Text('${num}')),
//                       //   ],
//                       // ),
//                     )),
//                     Expanded(
//                         child: MaterialButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ProductScreen(),
//                           ),
//                         );
//                         // fetchCartItem();
//                       },
//                       height: double.maxFinite,
//                       child: Icon(Icons.person),
//                     )),
//                     Expanded(
//                         child: MaterialButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => OrderHistoryScreen(),
//                           ),
//                         );
//                       },
//                       height: double.maxFinite,
//                       child: Icon(Icons.category_outlined),
//                     ))
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
