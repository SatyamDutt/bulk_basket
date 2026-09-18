// import 'package:bulk_basket/resources/app_strings.dart';
// import 'package:bulk_basket/views/common/input_label.dart';
// import 'package:bulk_basket/views/common/primary_button.dart';
// import 'package:bulk_basket/views/common/primary_textField.dart';
// import 'package:bulk_basket/views/home/product_home_screen.dart';
// import 'package:bulk_basket/views/auth/register_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   void signIn() async {
//     String email = emailController.text.toString();
//     String password = passwordController.text.toString();

//     if (email.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Email and Password are required',
//           ),
//           backgroundColor: Colors.red,
//         ),
//       );

//       return;
//     }
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);

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
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 25.w),
//           child: ListView(
//             children: [
//               Text(
//                 AppStrings.loginScreenTagline,
//                 textAlign: TextAlign.start,
//                 style: TextStyle(
//                   fontSize: 22.sp,
//                 ),
//               ),
//               // SizedBox(
//               //   height: 250.h,
//               // ),
//               Image.asset(
//                 'assets/onBoardingImage.png',
//                 // height: 300,
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               InputLabel(title: 'Enter Email'),
//               SizedBox(
//                 height: 10.h,
//               ),
//               PrimaryTextfield(
//                   inputValue: emailController, hintText: 'abcd@gmail.com'),
//               SizedBox(
//                 height: 15.h,
//               ),
//               InputLabel(title: 'Enter Password'),
//               SizedBox(
//                 height: 15.h,
//               ),
//               PrimaryTextfield(
//                   inputValue: passwordController, hintText: 'fadsxxxx'),
//               SizedBox(
//                 height: 40.h,
//               ),
//               PrimaryButton(
//                 title: 'Login',
//                 ontTap: () {
//                   signIn();
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
//                     "Don't have an Account ",
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => RegisterScreen(),
//                         ),
//                       );
//                     },
//                     child: Text(
//                       'Create Now',
//                       style: TextStyle(
//                         color: Color(0xff53B175),
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//with bloc

// import 'package:bulk_basket/bloc/login/login_bloc.dart';
// import 'package:bulk_basket/bloc/login/login_event.dart';
// import 'package:bulk_basket/bloc/login/login_state.dart';
// import 'package:bulk_basket/resources/app_strings.dart';
// import 'package:bulk_basket/views/common/input_label.dart';
// import 'package:bulk_basket/views/common/primary_button.dart';
// import 'package:bulk_basket/views/common/primary_textField.dart';
// import 'package:bulk_basket/views/home/product_home_screen.dart';
// import 'package:bulk_basket/views/auth/register_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   // void signIn() async {
//   //   String email = emailController.text.toString();
//   //   String password = passwordController.text.toString();

//   //   if (email.isEmpty || password.isEmpty) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: Text(
//   //           'Email and Password are required',
//   //         ),
//   //         backgroundColor: Colors.red,
//   //       ),
//   //     );

//   //     return;
//   //   }
//   //   try {
//   //     UserCredential userCredential = await FirebaseAuth.instance
//   //         .signInWithEmailAndPassword(email: email, password: password);

//   //     Navigator.pushReplacement(
//   //       context,
//   //       MaterialPageRoute(
//   //         builder: (context) => ProductScreen(
//   //           userId: userCredential.user!.uid,
//   //         ),
//   //       ),
//   //     );
//   //   } on FirebaseAuthException catch (e) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: Text(
//   //           '${e.message}',
//   //         ),
//   //         backgroundColor: Colors.red,
//   //       ),
//   //     );
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => LoginBloc(),
//         // ..add(LoginButtonPressed(
//         //     email: emailController.text.trim(),
//         //     password: passwordController.text.trim())),
//       child: Scaffold(
//         body: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 25.w),
//             child: BlocListener<LoginBloc, LoginState>(
//               listener: (context, state) {
//                 if (state is LoginFailure) {
//                   ScaffoldMessenger.of(context)
//                       .showSnackBar(SnackBar(content: Text(state.error),backgroundColor: Colors.red,));
//                 } else if (state is LoginSuccess) {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => ProductScreen(userId: state.userId,)));
//                 }
//               },
//               child: ListView(
//                 children: [
//                   Text(
//                     AppStrings.loginScreenTagline,
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                       fontSize: 22.sp,
//                     ),
//                   ),
//                   // SizedBox(
//                   //   height: 250.h,
//                   // ),
//                   Image.asset(
//                     'assets/onBoardingImage.png',
//                     // height: 300,
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   InputLabel(title: 'Enter Email'),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   PrimaryTextfield(
//                       inputValue: emailController, hintText: 'abcd@gmail.com'),
//                   SizedBox(
//                     height: 15.h,
//                   ),
//                   InputLabel(title: 'Enter Password'),
//                   SizedBox(
//                     height: 15.h,
//                   ),
//                   PrimaryTextfield(
//                       inputValue: passwordController, hintText: 'fadsxxxx'),
//                   SizedBox(
//                     height: 40.h,
//                   ),
//                   BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
//                     if (state is LoginLoading) {
//                       return Center(
//                         child: CircularProgressIndicator(
//                           color: Colors.yellowAccent,
//                         ),
//                       );
//                     }
//                     return PrimaryButton(
//                       title: 'Login',
//                       ontTap: () {
//                         context.read<LoginBloc>().add(LoginButtonPressed(
//                             email: emailController.text.trim(),
//                             password: passwordController.text.trim()));
//                       },
//                     );
//                   }),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   Divider(),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Don't have an Account ",
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => RegisterScreen(),
//                             ),
//                           );
//                         },
//                         child: Text(
//                           'Create Now',
//                           style: TextStyle(
//                             color: Color(0xff53B175),
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//test

import 'package:bulk_basket/bloc/login/login_bloc.dart';
import 'package:bulk_basket/bloc/login/login_event.dart';
import 'package:bulk_basket/bloc/login/login_state.dart';
import 'package:bulk_basket/resources/app_strings.dart';
import 'package:bulk_basket/resources/app_validators.dart';
import 'package:bulk_basket/views/common/input_label.dart';
import 'package:bulk_basket/views/common/primary_button.dart';
import 'package:bulk_basket/views/common/primary_textField.dart';
import 'package:bulk_basket/views/home/product_home_screen.dart';
import 'package:bulk_basket/views/auth/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // void signIn() async {
  //   String email = emailController.text.toString();
  //   String password = passwordController.text.toString();

  //   if (email.isEmpty || password.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           'Email and Password are required',
  //         ),
  //         backgroundColor: Colors.red,
  //       ),
  //     );

  //     return;
  //   }
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);

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
  //       ),
  //     );
  //   }
  // }

  bool passwordHide = true;

  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.error),
                        backgroundColor: Colors.red,
                      ));
                    } else 
                    if (state is LoginSuccess) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductScreen(
                                    userId: state.userId,
                                  )));
                    }
                  },
                  child: ListView(
                    children: [
                      Text(
                        AppStrings.loginScreenTagline,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      // SizedBox(
                      //   height: 250.h,
                      // ),
                      Image.asset(
                        'assets/onBoardingImage.png',
                        // height: 300,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InputLabel(title: 'Enter Email'),
                      SizedBox(
                        height: 10.h,
                      ),
                      PrimaryTextfield(
                          inputValue: emailController,
                          hintText: 'abcd@gmail.com',
                          // validator: (value) =>  AppValidators.gmail(value),
                          ),
                      SizedBox(
                        height: 15.h,
                      ),
                      InputLabel(title: 'Enter Password'),
                      SizedBox(
                        height: 15.h,
                      ),
                      // PrimaryTextfield(
                      //     inputValue: passwordController, hintText: 'fadsxxxx', ),
            
                      TextFormField(
                        controller: passwordController,
                        obscureText: passwordHide,
                        // validator: (value) => AppValidators.password(value),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                          hintText: 'usdfxxxx',
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
                        height: 40.h,
                      ),
                      BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                        // if (state is LoginLoading) {
                        //   return Center(
                        //     child: CircularProgressIndicator(),
                        //   );
                        // }
                        return PrimaryButton(
                          title: 'Login',
                          isLoading: state is LoginLoading ? true : false,
                          ontTap: () {
                            if(_formKey.currentState!.validate()) {
                              context.read<LoginBloc>().add(LoginButtonPressed(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim()));
                            }
                          },
                        );
                      }),
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
                            "Don't have an Account ",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Create Now',
                              style: TextStyle(
                                color: Color(0xff53B175),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
