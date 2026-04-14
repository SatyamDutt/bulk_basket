import 'package:bulk_basket/controller/location_controller.dart';
import 'package:bulk_basket/views/auth/login_screen.dart';
import 'package:bulk_basket/views/cart/cart_screen.dart';
import 'package:bulk_basket/views/home/location_screen.dart';
import 'package:bulk_basket/views/home/order_history_screen.dart';
import 'package:bulk_basket/views/home/product_details_screen.dart';
import 'package:bulk_basket/views/home/profile_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'new_order_history_screen.dart';

class ProductScreen extends StatefulWidget {
  final String? userId;

  const ProductScreen({super.key, this.userId});
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> productList = [];
  List<Map<String, dynamic>> riceAndFlourList = [];
  List<Map<String, dynamic>> dryFruitsList = [];
  List<Map<String, dynamic>> cerealsList = [];
  // List<Map<String, dynamic>> snacksBiscuitsList = [];
  List<Map<String, dynamic>> spicesList = [];
  List<Map<String, dynamic>> skinCareProductList = [];
  List<Map<String, dynamic>> groomingItemsList = [];
  List<Map<String, dynamic>> filteredProducts = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    fetchProduct();
    riceAndFlour();
    dryFruitsCategory();
    fetchCartItem();
    cerealsCategory();
    spicesCategory();
    skinCareCategory();
    groomingItemsCategory();
  }

  /// Fetch Snacks & Biscuits from Firestore
  Future<void> fetchProduct() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('New Product')
          .doc('Category')
          .collection('Snacks & Biscuits')
          .where('approvalStatus', isEqualTo: 'approved')
          .get();

      setState(() {
        productList = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        filteredProducts = productList; // Initialize search list
      });
    } catch (e) {
      print("Error fetching Snacks & Biscuits: $e");
    }
  }

  /// Fetch Rice & Flour from Firestore
  Future<void> riceAndFlour() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('New Product')
          .doc('Category')
          .collection('Rice and floor')
          .where('approvalStatus', isEqualTo: 'approved')
          .get();

      setState(() {
        riceAndFlourList = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      print("Error fetching Rice & Flour: $e");
    }
  }

  /// Fetch Dry Fruits from Firestore
  Future<void> dryFruitsCategory() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('New Product')
          .doc('Category')
          .collection('Dry Fruits')
          .where('approvalStatus', isEqualTo: 'approved')
          .get();

      setState(() {
        dryFruitsList = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      print("Error fetching Dry Fruits: $e");
    }
  }

  //fetch cereals category data
  Future<void> cerealsCategory() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('New Product')
          .doc('Category')
          .collection('Cereals')
          .where('approvalStatus', isEqualTo: 'approved')
          .get();

      setState(() {
        cerealsList = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      print("Error fetching cereals: $e");
    }
  }

  //spices
  Future<void> spicesCategory() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('New Product')
          .doc('Category')
          .collection('Spices')
          .where('approvalStatus', isEqualTo: 'approved')
          .get();

      setState(() {
        spicesList = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      print("Error fetching cereals: $e");
    }
  }

  //skin care category
  Future<void> skinCareCategory() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('New Product')
          .doc('Category')
          .collection('Skin Care')
          .where('approvalStatus', isEqualTo: 'approved')
          .get();

      setState(() {
        skinCareProductList = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      print("Error fetching skin Care: $e");
    }
  }

// grooming items
  Future<void> groomingItemsCategory() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('New Product')
          .doc('Category')
          .collection('Grooming Items')
          .where('approvalStatus', isEqualTo: 'approved')
          .get();

      setState(() {
        groomingItemsList = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      print("Error fetching grooming items: $e");
    }
  }

  Future<void> refreshAll() async {
    await fetchProduct();
    await riceAndFlour();
    await dryFruitsCategory();
    await cerealsCategory();
    await spicesCategory();
    await skinCareCategory();
    await groomingItemsCategory();

    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.white,
      
      content: Text("Products refreshed", textAlign: TextAlign.center,style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600),),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: 80, left: 100, right: 100),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      duration: Duration(seconds: 2),
    ),
  );

  }

  /// **Search Functionality Across All Categories**
  void filterProducts(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredProducts = productList;
        isSearching = false;
      });
    } else {
      List<Map<String, dynamic>> allProducts = [
        ...productList,
        ...riceAndFlourList,
        ...dryFruitsList,
        ...cerealsList,
        ...spicesList,
        ...skinCareProductList,
        ...groomingItemsList,
      ];

      List<Map<String, dynamic>> searchResults = allProducts
          .where((product) => product['productName']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();

      setState(() {
        filteredProducts = searchResults;
        isSearching = searchResults.isNotEmpty;
      });
    }
  }

  //slider
  int activeIndex = 0;
  var sliderImage = [
    'assets/banner1.jpg',
    'assets/banner2.jpg',
    'assets/banner3.jpg',
    'assets/banner4.jpg'
  ];

  int num = 0;
  void fetchCartItem() {
    final userId = GetStorage().read('userId');
    FirebaseFirestore.instance
        .collection('Cart')
        .doc(userId)
        .collection('Cart-Items')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        num = snapshot.docs.length;
      });
    });
  }

  Future<void> logOut() async {
    GetStorage().erase();
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You have logged out'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ),
    );
  }

  final locationController = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(
              Icons.location_on_sharp,
              size: 30,
              color: Colors.red,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wlinkit',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                    width: 300,
                    child: Text(locationController.address.value,
                        maxLines: 2, style: TextStyle(fontSize: 8)))
              ],
            ),
          ],
        ),
        // leading: ,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.green, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 10.0),
        //     child: IconButton(
        //         onPressed: () {
        //           // logOut();
        //           Navigator.push(context, MaterialPageRoute(builder: (context) => LocationScreen(),),);
        //         },
        //         icon: Icon(Icons.logout_outlined)),
        //   )
        // ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) => filterProducts(value),
              decoration: InputDecoration(
                hintText: 'Search for products...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Stack(children: [
        productList.isEmpty && riceAndFlourList.isEmpty && dryFruitsList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(10),
                child: RefreshIndicator(
                  onRefresh: refreshAll,
                  child: ListView(
                    children: [
                      SizedBox(height: 10),
                      isSearching
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                sectionTitle("Search Results"),
                                filteredProducts.isEmpty
                                    ? Center(child: Text("No products found"))
                                    : buildHorizontalList(filteredProducts),
                                SizedBox(height: 20),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CarouselSlider.builder(
                                  itemBuilder: (contex, index, realIdnex) {
                                    return Image.asset(sliderImage[index]);
                                  },
                                  itemCount: 4,
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    viewportFraction: 1,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        activeIndex = index;
                                      });
                                    },
                                  ),
                                ),
                                Center(
                                  child: Transform.scale(
                                    scale: 0.5,
                                    child: AnimatedSmoothIndicator(
                                        activeIndex: activeIndex,
                                        count: sliderImage.length),
                                  ),
                                ),
                                sectionTitle("Snacks & Biscuits"),
                                productList.isEmpty
                                    ? Center(
                                        child: Text("No products available"))
                                    : buildHorizontalList(productList),
                                SizedBox(height: 8),
                                sectionTitle("Rice and Flour"),
                                riceAndFlourList.isEmpty
                                    ? Center(
                                        child: Text("No products available"))
                                    : buildHorizontalList(riceAndFlourList),
                                SizedBox(height: 8),
                                sectionTitle("Dry Fruits"),
                                dryFruitsList.isEmpty
                                    ? Center(
                                        child: Text("No products available"))
                                    : buildHorizontalList(dryFruitsList),
                                SizedBox(height: 8), // add
                                sectionTitle("Cereals"),
                                cerealsList.isEmpty
                                    ? Center(
                                        child: Text("No products available"))
                                    : buildHorizontalList(cerealsList),
                                SizedBox(height: 8),
                                sectionTitle("Spices"),
                                spicesList.isEmpty
                                    ? Center(
                                        child: Text("No products available"))
                                    : buildHorizontalList(spicesList),
                                SizedBox(height: 8),
                                sectionTitle("Skin Care"),
                                skinCareProductList.isEmpty
                                    ? Center(
                                        child: Text("No products available"))
                                    : buildHorizontalList(skinCareProductList),
                                SizedBox(height: 8),
                                sectionTitle("Grooming Items"),
                                groomingItemsList.isEmpty
                                    ? Center(
                                        child: Text("No products available"))
                                    : buildHorizontalList(groomingItemsList),
                              ],
                            ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 50.h,
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                    child: MaterialButton(
                  height: double.maxFinite,
                  onPressed: () {},
                  child: Icon(Icons.home_outlined, size: 30.r
                      // weight: 2,
                      ),
                )),
                Expanded(
                    child: MaterialButton(
                  height: double.maxFinite,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(
                          userId: widget.userId.toString(),
                        ),
                        // builder: (context) => Temp1(
                        // userId: widget.userId.toString(),
                        // ),
                      ),
                    );
                  },
                  child: Stack(
                    clipBehavior: Clip.none, // Allows overflow for positioning
                    children: [
                      Icon(Icons.shopping_cart_outlined, size: 30), // Cart icon

                      // Badge for the cart count
                      Positioned(
                        right: -8, // Adjust position to fit properly
                        top: -8,
                        child: Container(
                          padding:
                              EdgeInsets.all(4), // Padding inside the badge
                          decoration: BoxDecoration(
                            color: Colors.red, // Background color for badge
                            shape: BoxShape.circle, // Makes it a circle
                          ),
                          constraints: BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          child: Center(
                            child: Text(
                              '$num',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // child: Stack(
                  //   children: [
                  //     Align(
                  //       alignment: Alignment.center,
                  //       child: Icon(Icons.shopping_cart_outlined,
                  //       size: 32,
                  //       )),
                  //     Align(
                  //       alignment: Alignment.topRight,
                  //       child: Text('${num}')),
                  //   ],
                  // ),
                )),
                Expanded(
                    child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          userId: widget.userId.toString(),
                        ),
                      ),
                    );
                    // fetchCartItem();
                  },
                  height: double.maxFinite,
                  child: Icon(Icons.person),
                )),
                Expanded(
                    child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // builder: (context) => OrderHistoryScreen(
                        builder: (context) => CartOrderHistoryScreen(
                          userId: widget.userId.toString(),
                        ),
                      ),
                    );
                  },
                  height: double.maxFinite,
                  child: Icon(Icons.category_outlined),
                ))
              ],
            ),
          ),
        )
      ]),
    );
  }

  /// Helper function to build section titles
  Widget sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    );
  }

  /// Helper function to build horizontal product lists
  Widget buildHorizontalList(List<Map<String, dynamic>> products) {
    return Container(
      height: 180,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 25),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          var product = products[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    itemName: product['productName'].toString(),
                    itemImage: product['productImage'],
                    itemPrice: product['productPrice'].toString(),
                    itemQuantity: product['productQuantity'].toString(),
                    productDesc: product['productDesc'],
                    userID: widget.userId.toString(),
                  ),
                ),
              );
            },
            child: Column(
              children: [
                Image.network(
                  product['productImage'],
                  width: 100,
                  height: 100,
                ),
                Container(
                  width: 110,
                  child: Text(
                    product['productName'].toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                Text('(${product['productQuantity']})'),
                Text(
                  '₹ ${product['productPrice']}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
