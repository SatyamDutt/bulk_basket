// abstract class LoginEvent {}

// class LoginButtonPressed extends LoginEvent {
//   final String email;
//   final String password;

//   LoginButtonPressed({required this.email, required this.password});
// }


// state
// abstract class LoginState {}

// class LoginInitial extends LoginState {}

// class LoginLoading extends LoginState {}

// class LoginSuccess extends LoginState {
//   final String userId;

//   LoginSuccess(this.userId);
// }

// class LoginFailure extends LoginState {
//   final String error;

//   LoginFailure(this.error);
// }


//bloc
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'login_event.dart';
// import 'login_state.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   LoginBloc() : super(LoginInitial()) {
//     on<LoginButtonPressed>((event, emit) async {
//       emit(LoginLoading());

//       if (event.email.isEmpty || event.password.isEmpty)
//         emit(LoginFailure("Email and Password are required"));
//         return;
//       }

//       try {
//         final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: event.email,
//           password: event.password,
//         );

//         emit(LoginSuccess(userCredential.user!.uid));
//       } on FirebaseAuthException catch (e) {
//         emit(LoginFailure(e.message ?? "Login failed"));
//       }
//     });
//   }
// }


// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bulk_basket/bloc/login/login_bloc.dart';
// import 'package:bulk_basket/bloc/login/login_event.dart';
// import 'package:bulk_basket/bloc/login/login_state.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => LoginBloc(),
//       child: Scaffold(
//         body: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 25.w),
//             child: BlocListener<LoginBloc, LoginState>(
//               listener: (context, state) {
//                 if (state is LoginFailure) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text(state.error), backgroundColor: Colors.red),
//                   );
//                 } else if (state is LoginSuccess) {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ProductScreen(userId: state.userId),
//                     ),
//                   );
//                 }
//               },
//               child: ListView(
//                 children: [
//                   Text(
//                     AppStrings.loginScreenTagline,
//                     style: TextStyle(fontSize: 22.sp),
//                   ),
//                   Image.asset('assets/onBoardingImage.png'),
//                   SizedBox(height: 15),
//                   InputLabel(title: 'Enter Email'),
//                   SizedBox(height: 10.h),
//                   PrimaryTextfield(inputValue: emailController, hintText: 'abcd@gmail.com'),
//                   SizedBox(height: 15.h),
//                   InputLabel(title: 'Enter Password'),
//                   SizedBox(height: 15.h),
//                   PrimaryTextfield(inputValue: passwordController, hintText: 'fadsxxxx'),
//                   SizedBox(height: 40.h),
//                   BlocBuilder<LoginBloc, LoginState>(
//                     builder: (context, state) {
//                       if (state is LoginLoading) {
//                         return Center(child: CircularProgressIndicator());
//                       }
//                       return PrimaryButton(
//                         title: 'Login',
//                         ontTap: () {
//                           context.read<LoginBloc>().add(LoginButtonPressed(
//                                 email: emailController.text,
//                                 password: passwordController.text,
//                               ));
//                         },
//                       );
//                     },
//                   ),
//                   SizedBox(height: 10.h),
//                   Divider(),
//                   SizedBox(height: 10.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("Don't have an Account ", style: TextStyle(fontSize: 14.sp)),
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
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
