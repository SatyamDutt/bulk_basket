// import 'package:bulk_basket/models/product_model.dart';
// import 'package:bulk_basket/services/product_service.dart';
// import 'package:bulk_basket/views/common/temp1.dart';
// import 'package:bulk_basket/views/home/order_history_screen.dart';
// import 'package:bulk_basket/views/home/product_details_screen.dart';
// import 'package:bulk_basket/views/home/profile_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class Temp2 extends StatefulWidget {
//   final String? userId;
//   const Temp2({super.key, this.userId});

//   @override
//   State<Temp2> createState() => _Temp2State();
// }

// class _Temp2State extends State<Temp2> {
//   final ProductService _productService = ProductService();

//   TextEditingController searchController = TextEditingController();

//   List<ProductModel> snacksAndBiscuitsCategoryItems = [];
//   List<ProductModel> riceAndFlourCategoryItems = [];
//   List<ProductModel> dryFruitsCategoryItems = [];
//   List<ProductModel> cerealsCategoryItems = [];
//   List<ProductModel> spicesCategoryItems = [];
//   List<ProductModel> skinCareCategoryItems = [];
//   List<ProductModel> groomingItems = [];

//   List<ProductModel> filteredProducts = [];
//   bool isSearching = false;

//   void fetchSnacksAndBiscuitsCategoryItems() async {
//     snacksAndBiscuitsCategoryItems =
//         await _productService.getSnacksAndBiscuitsCategoryItems();

//     setState(() {});
//   }

//   void fetchRiceAndFlourCategoryItems() async {
//     riceAndFlourCategoryItems =
//         await _productService.getRiceAndFlourCategoryItems();
//     setState(() {});
//   }

//   void fetchDryFruitsCategoryItems() async {
//     dryFruitsCategoryItems = await _productService.getDryFruitsCategoryItems();
//     setState(() {});
//   }

//   void fetchCerealsCategoryItems() async {
//     cerealsCategoryItems = await _productService.getCerealsCategoryItems();
//     setState(() {});
//   }

//   void fetchSpicesCategoryItems() async {
//     spicesCategoryItems = await _productService.getSpicesCategoryItems();
//     setState(() {});
//   }

//   void fetchSkinCareCategoryItems() async {
//     skinCareCategoryItems = await _productService.getSkinCareCategoryItems();
//     setState(() {});
//   }

//   void fetchGroomingItems() async {
//     groomingItems = await _productService.getGroomingItemCategory();
//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchSnacksAndBiscuitsCategoryItems();
//     fetchRiceAndFlourCategoryItems();
//     fetchDryFruitsCategoryItems();
//     fetchCerealsCategoryItems();
//     fetchSpicesCategoryItems();
//     fetchGroomingItems();
//     fetchSkinCareCategoryItems();
//   }

//   void fetchFilteredProducts(String query) {
//     if (query.isEmpty) {
//       setState(() {
//         isSearching = false;
//       filteredProducts = [];
//       });
//     } else {
//       List<ProductModel> allProducts = [
//         ...snacksAndBiscuitsCategoryItems,
//         ...riceAndFlourCategoryItems,
//         ...dryFruitsCategoryItems,
//         ...cerealsCategoryItems,
//         ...spicesCategoryItems,
//         ...skinCareCategoryItems,
//         ...groomingItems,
//       ];

//       List<ProductModel> searchResults = allProducts
//           .where((product) =>
//               product.productName.toLowerCase().contains(query.toLowerCase()))
//           .toList();

//       setState(() {
//         filteredProducts = searchResults;
//         isSearching = searchResults.isNotEmpty;
//       });
//     }
//   }

//   int num = 0;
//   void fetchCartItem() {
//     FirebaseFirestore.instance
//         .collection('Cart').doc(widget.userId).collection('Cart-Items')
//         .snapshots()
//         .listen((snapshot) {
//       setState(() {
//         num = snapshot.docs.length;
//       });
//     });
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             ListView(scrollDirection: Axis.vertical, children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 25.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       children: [
//                         TextField(
//                           controller: searchController,
//                           onChanged:fetchFilteredProducts,
//                           decoration: InputDecoration(
//                               hintText: 'Search Products',
//                               border: OutlineInputBorder()),
//                         ),
                        
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     if (isSearching) ...[
//                       sectionTile('Search Results'),
//                       filteredProducts.isEmpty
//                           ? Center(
//                               child: Text('No Products found'),
//                             )
//                           : buidHorintalItemList(filteredProducts)
//                     ] else ...[
//                       sectionTile('Rice and Flour'),
//                       SizedBox(
//                         height: 25,
//                       ),
//                       buidHorintalItemList(snacksAndBiscuitsCategoryItems),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       buidHorintalItemList(riceAndFlourCategoryItems),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       buidHorintalItemList(dryFruitsCategoryItems),
//                       SizedBox(
//                         height: 15,
//                       ),
//                     ]
//                   ],
//                 ),
//               ),
//             ]),
         
//             Align(
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             height: 50.h,
//             color: Colors.white,
//             child: Row(
//               children: [
//                 Expanded(
//                     child: MaterialButton(
//                   height: double.maxFinite,
//                   onPressed: () {},
//                   child: Icon(Icons.home_outlined, size: 30.r
//                       // weight: 2,
//                       ),
//                 )),
//                 Expanded(
//                     child: MaterialButton(
//                   height: double.maxFinite,
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         // builder: (context) => CartScreen(userId: widget.userId.toString(),),
//                         builder: (context) => Temp1(userId: widget.userId.toString(),),
//                       ),
//                     );
//                   },
//                   child: Stack(
//                     clipBehavior: Clip.none, // Allows overflow for positioning
//                     children: [
//                       Icon(Icons.shopping_cart_outlined, size: 30), // Cart icon

//                       // Badge for the cart count
//                       Positioned(
//                         right: -8, // Adjust position to fit properly
//                         top: -8,
//                         child: Container(
//                           padding:
//                               EdgeInsets.all(4), // Padding inside the badge
//                           decoration: BoxDecoration(
//                             color: Colors.red, // Background color for badge
//                             shape: BoxShape.circle, // Makes it a circle
//                           ),
//                           constraints: BoxConstraints(
//                             minWidth: 20,
//                             minHeight: 20,
//                           ),
//                           child: Center(
//                             child: Text(
//                               '$num',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   // child: Stack(
//                   //   children: [
//                   //     Align(
//                   //       alignment: Alignment.center,
//                   //       child: Icon(Icons.shopping_cart_outlined,
//                   //       size: 32,
//                   //       )),
//                   //     Align(
//                   //       alignment: Alignment.topRight,
//                   //       child: Text('${num}')),
//                   //   ],
//                   // ),
//                 )),
//                 Expanded(
//                     child: MaterialButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ProfileScreen(
//                           userId: widget.userId.toString(),
//                         ),
//                       ),
//                     );
//                     // fetchCartItem();
//                   },
//                   height: double.maxFinite,
//                   child: Icon(Icons.person),
//                 )),
//                 Expanded(
//                     child: MaterialButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => OrderHistoryScreen(userId: widget.userId.toString(),),
//                       ),
//                     );
//                   },
//                   height: double.maxFinite,
//                   child: Icon(Icons.category_outlined),
//                 ))
//               ],
//             ),
//           ),
//         )
    
//           ],
//         ),
//       ),
//     );
//   }

//   Widget sectionTile(String title) {
//     return Text(
//       title,
//       style: TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.w600,
//       ),
//     );
//   }

//   Widget buidHorintalItemList(List<ProductModel> itemList) {
//     return SizedBox(
//       height: 180,
//       child: ListView.separated(
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (context, index) {
//             return InkWell(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ProductDetailsScreen(
//                           itemName: itemList[index].productName,
//                           itemImage: itemList[index].productImage,
//                           itemPrice: itemList[index].productPrice.toString(),
//                           itemQuantity: itemList[index].productQuantity,
//                           productDesc: itemList[index].productDesc,
//                           userID: '')),
//                 );
//               },
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Image.network(
//                     itemList[index].productImage,
//                     height: 100,
//                     width: 100,
//                   ),
//                   Text(
//                     itemList[index].productName,
//                     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
//                   ),
//                   Text('(${itemList[index].productQuantity})'),
//                   Text(
//                     '₹ ${itemList[index].productPrice}',
//                     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//                   )
//                 ],
//               ),
//             );
//           },
//           separatorBuilder: (context, index) {
//             return SizedBox(
//               width: 20,
//             );
//           },
//           itemCount: itemList.length),
//     );
//   }
// }


