// import 'package:bulk_basket/views/common/primary_button.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class ProfileScreen extends StatefulWidget {
//   final String userId;
//   const ProfileScreen({super.key, required this.userId});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetchUserDetails();
//   }

//   var userDetails;

//   Future<void> fetchUserDetails() async {
//     DocumentSnapshot snapshot = await FirebaseFirestore.instance
//         .collection('Users')
//         .doc(widget.userId)
//         .get();

//     setState(() {
//       userDetails = snapshot;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('${userDetails['Name']}'),
//           Text('${userDetails['Address']}'),
//           Text('Profile detials'),
//           SizedBox(
//             height: 50,
//           ),
//           PrimaryButton(
//               title: 'Fetch data',
//               ontTap: () {
//                 fetchUserDetails();
//               })
//         ],
//       )),
//     );
//   }
// }


import 'package:bulk_basket/views/auth/login_screen.dart';
import 'package:bulk_basket/views/home/about_screen.dart';
import 'package:bulk_basket/views/home/help_screen.dart';
import 'package:bulk_basket/views/home/order_history_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;
  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.userId)
          .get();

      setState(() {
        userDetails = snapshot.data() as Map<String, dynamic>?;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching user details: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  var screens = [
    OrderHistoryScreen(userId: FirebaseAuth.instance.currentUser!.uid),
    HelpScreen(),
    AboutScreen()
  ];

  List buttonList = ["Order History", "Help", "About"];

  Future<void> logOut() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: isLoading
                  ? CircularProgressIndicator()
                  : userDetails != null
                      ? Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              child: ListTile(
                                title: Text(
                                  userDetails!['Name'] ?? "N/A",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  'Address: ${userDetails!['Address'] ?? "N/A"}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),

                            SizedBox(height: 30),
                            // PrimaryButton(
                            //   title: 'Refresh Data',
                            //   ontTap: fetchUserDetails,
                            // ),
                          ],
                        )
                      : Text(
                          'No User Data Found',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
            ),
            Divider(),
            Container(
              height: 200,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => screens[index],
                              ),
                            );
                          },
                          child: Container(
                              height: 40,
                              // color: Colors.grey,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${buttonList[index]}',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Icon(Icons.arrow_forward_ios_outlined)
                                  ],
                                ),
                              )),
                        ),
                        Divider(),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: 3),
            ),
            // Divider(),
            //  InkWell(
            //   child: Container(

            //   ),
            //  ),
            SizedBox(
              height: 250,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: MaterialButton(
                elevation: 0,
                minWidth: double.maxFinite,
                height: 55,
                color: Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  logOut();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      color: Colors.orange,
                    ),
                    Spacer(),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Log Out',
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
