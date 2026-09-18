// import 'package:bulk_basket/views/auth/login_screen.dart';
// import 'package:bulk_basket/resources/app_strings.dart';
// import 'package:bulk_basket/views/common/input_label.dart';
// import 'package:bulk_basket/views/common/primary_button.dart';
// import 'package:bulk_basket/views/common/primary_textField.dart';
// import 'package:bulk_basket/views/home/product_home_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController addressController = TextEditingController();

//   void createAccount() async {
//     String email = emailController.text.toString();
//     String password = passwordController.text.toString();
//     String name = nameController.text.trim();
//     String address = addressController.text.trim();

//     if (email.isEmpty || password.isEmpty || name.isEmpty || address.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'All Details are required',
//           ),
//           backgroundColor: Colors.red,
//           duration: Duration(seconds: 1),
//         ),
//       );

//       return;
//     }
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);

//       await FirebaseFirestore.instance
//           .collection('Users')
//           .doc(userCredential.user!.uid)
//           .set({'Name': name, 'Address': address});

//           ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Your account created Successfully',
//           ),
//           backgroundColor: Colors.green,
//           duration: Duration(seconds: 1),
//         ),
//       );

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ProductScreen(
//             userId: userCredential.user!.uid,
//           ),
//         ),
//       );
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             '${e.message}',
//           ),
//           backgroundColor: Colors.red,
//           duration: Duration(seconds: 1),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 25.h),
//           child: ListView(
//             children: [
//               SizedBox(
//                 height: 10.h,
//               ),
//               Text(
//                 AppStrings.registerScreenTagline,
//                 style: TextStyle(
//                   fontSize: 20.sp,
//                 ),
//               ),
//               Image.asset(
//                 'assets/onBoardingImage.png',
//                 height: 350,
//               ),

//               // SizedBox(
//               //   height: 250.h,
//               // ),
//               InputLabel(title: 'Enter Name'),
//               SizedBox(
//                 height: 10.h,
//               ),
//               PrimaryTextfield(
//                   inputValue: nameController,
//                   hintText: 'Shivam Kumar'),
//               SizedBox(
//                 height: 15.h,
//               ),
//               InputLabel(title: 'Enter Address'),
//               SizedBox(
//                 height: 10.h,
//               ),
//               PrimaryTextfield(
//                 inputValue: addressController,
//                   hintText: 'jammu colony Ludhiana (125411), Punjab'),
//               SizedBox(
//                 height: 10.h,
//               ),
//               InputLabel(title: 'Enter email'),
//               SizedBox(
//                 height: 10,
//               ),
//               PrimaryTextfield(
//                   inputValue: emailController, hintText: 'abcdxx12@gmail.com'),
//               SizedBox(
//                 height: 10,
//               ),
//               InputLabel(title: 'Enter password'),
//               SizedBox(
//                 height: 10,
//               ),
//               PrimaryTextfield(
//                   inputValue: passwordController, hintText: 'afjds@xxxx'),
//               SizedBox(
//                 height: 15.h,
//               ),
//               PrimaryButton(
//                 title: 'Register',
//                 ontTap: () {
//                   createAccount();
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //     builder: (context) => HomeScreen(),
//                   //   ),
//                   // );
//                 },
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               Divider(),
//               SizedBox(
//                 height: 10.h,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Already having an account ',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => LoginScreen(),
//                         ),
//                       );
//                     },
//                     child: Text(
//                       'Login Now',
//                       style: TextStyle(
//                         color: Color(0xff53B175),
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(height: 50,),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//with bloc

import 'package:bulk_basket/bloc/login/login_bloc.dart';
import 'package:bulk_basket/bloc/register/register_bloc.dart';
import 'package:bulk_basket/bloc/register/register_event.dart';
import 'package:bulk_basket/bloc/register/register_state.dart';
import 'package:bulk_basket/resources/app_validators.dart';
import 'package:bulk_basket/views/auth/login_screen.dart';
import 'package:bulk_basket/resources/app_strings.dart';
import 'package:bulk_basket/views/common/input_label.dart';
import 'package:bulk_basket/views/common/primary_button.dart';
import 'package:bulk_basket/views/common/primary_textField.dart';
import 'package:bulk_basket/views/home/product_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  // void createAccount() async {
  //   String email = emailController.text.toString();
  //   String password = passwordController.text.toString();
  //   String name = nameController.text.trim();
  //   String address = addressController.text.trim();

  //   if (email.isEmpty || password.isEmpty || name.isEmpty || address.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           'All Details are required',
  //         ),
  //         backgroundColor: Colors.red,
  //         duration: Duration(seconds: 1),
  //       ),
  //     );

  //     return;
  //   }
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: email, password: password);

  //     await FirebaseFirestore.instance
  //         .collection('Users')
  //         .doc(userCredential.user!.uid)
  //         .set({'Name': name, 'Address': address});

  //         ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           'Your account created Successfully',
  //         ),
  //         backgroundColor: Colors.green,
  //         duration: Duration(seconds: 1),
  //       ),
  //     );

  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => ProductScreen(
  //           userId: userCredential.user!.uid,
  //         ),
  //       ),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           '${e.message}',
  //         ),
  //         backgroundColor: Colors.red,
  //         duration: Duration(seconds: 1),
  //       ),
  //     );
  //   }
  // }

    bool passwordHide = true;
    final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(),
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.h),
                child: BlocListener<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.error),
                        backgroundColor: Colors.red,
                      ));
                    } else if (state is RegisterSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductScreen(userId: state.userId,),
                        ),
                      );  
                    }
                  },
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        AppStrings.registerScreenTagline,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Image.asset(
                        'assets/onBoardingImage.png',
                        height: 350,
                      ),
            
                      // SizedBox(
                      //   height: 250.h,
                      // ),
                      InputLabel(title: 'Enter Name'),
                      SizedBox(
                        height: 10.h,
                      ),
                      PrimaryTextfield(
                          inputValue: nameController, hintText: 'Shivam Kumar',
                          validator: (value) => AppValidators.name(value),
                          ),
                      SizedBox(
                        height: 15.h,
                      ),
                      InputLabel(title: 'Enter Address'),
                      SizedBox(
                        height: 10.h,
                      ),
                      PrimaryTextfield(
                          inputValue: addressController,
                          hintText: 'jammu colony Ludhiana (125411), Punjab',
                          validator: (value) => AppValidators.address(value),
                          ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InputLabel(title: 'Enter email'),
                      SizedBox(
                        height: 10,
                      ),
                      PrimaryTextfield(
                          inputValue: emailController,
                          hintText: 'abcdxx12@gmail.com',
                          validator: (value) => AppValidators.gmail(value),
                          ),
                      SizedBox(
                        height: 10,
                      ),
                      InputLabel(title: 'Enter password'),
                      SizedBox(
                        height: 10,
                      ),
                      // PrimaryTextfield(
                      //     inputValue: passwordController, hintText: 'afjds@xxxx'),
                      TextFormField(
                        controller: passwordController,
                        obscureText: passwordHide,
                        validator: (value) => AppValidators.password(value),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                          hintText: 'aerhxxxx',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordHide = !passwordHide;
                                });
                              },
                              icon: passwordHide ? Icon(Icons.visibility_off) : Icon(Icons.visibility)),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    
                      SizedBox(
                        height: 15.h,
                      ),
                      BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                          if (state is RegisterLoading) {
                            Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return PrimaryButton(
                            title: 'Register',
                            ontTap: () {
                              if(_formKey.currentState!.validate()) {
                                context.read<RegisterBloc>().add(
                                  RegisterButtonPresssed(
                                      email: emailController.text,
                                      password: passwordController.text.trim(),
                                      name: nameController.text,
                                      address: addressController.text));
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Divider(),   
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already having an account ',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Login Now',
                              style: TextStyle(
                                color: Color(0xff53B175),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
