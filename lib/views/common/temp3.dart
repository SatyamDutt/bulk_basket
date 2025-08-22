
// import 'package:bulk_basket/models/product_model.dart';
// import 'package:bulk_basket/services/product_service.dart';
// import 'package:bulk_basket/views/home/product_details_screen.dart';
// import 'package:flutter/material.dart';

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

//   @override
//   void initState() {
//     super.initState();
//     fetchAllCategories();
//   }

//   void fetchAllCategories() {
//     fetchSnacksAndBiscuitsCategoryItems();
//     fetchRiceAndFlourCategoryItems();
//     fetchDryFruitsCategoryItems();
//     fetchCerealsCategoryItems();
//     fetchSpicesCategoryItems();
//     fetchGroomingItems();
//     fetchSkinCareCategoryItems();
//   }

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

//   void fetchFilteredProducts(String query) {
//     if (query.isEmpty) {
//       setState(() {
//         isSearching = false;
//         filteredProducts = [];
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
//         isSearching = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: ListView(
//           scrollDirection: Axis.vertical,
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 25.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 15),
//                   TextField(
//                     controller: searchController,
//                     onChanged: fetchFilteredProducts,
//                     decoration: InputDecoration(
//                       hintText: 'Search Products',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 15),

//                   if (isSearching) ...[
//                     sectionTile('Search Results'),
//                     filteredProducts.isEmpty
//                         ? Center(child: Text('No Products found'))
//                         : buildHorizontalItemList(filteredProducts),
//                   ] else ...[
//                     sectionTile('Rice and Flour'),
//                     SizedBox(height: 25),
//                     buildHorizontalItemList(snacksAndBiscuitsCategoryItems),
//                     SizedBox(height: 15),
//                     buildHorizontalItemList(riceAndFlourCategoryItems),
//                     SizedBox(height: 15),
//                     buildHorizontalItemList(dryFruitsCategoryItems),
//                     SizedBox(height: 15),
//                   ]
//                 ],
//               ),
//             ),
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

//   Widget buildHorizontalItemList(List<ProductModel> itemList) {
//     return SizedBox(
//       height: 180,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ProductDetailsScreen(
//                     itemName: itemList[index].productName,
//                     itemImage: itemList[index].productImage,
//                     itemPrice: itemList[index].productPrice.toString(),
//                     itemQuantity: itemList[index].productQuantity,
//                     productDesc: itemList[index].productDesc,
//                     userID: widget.userId ?? '',
//                   ),
//                 ),
//               );
//             },
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.network(
//                   itemList[index].productImage,
//                   height: 100,
//                   width: 100,
//                 ),
//                 Text(
//                   itemList[index].productName,
//                   style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
//                 ),
//                 Text('(${itemList[index].productQuantity})'),
//                 Text(
//                   '₹ ${itemList[index].productPrice}',
//                   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//                 ),
//               ],
//             ),
//           );
//         },
//         separatorBuilder: (context, index) => SizedBox(width: 20),
//         itemCount: itemList.length,
//       ),
//     );
//   }
// }
