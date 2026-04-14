import 'package:bulk_basket/firebase_options.dart';
import 'package:bulk_basket/views/auth/login_screen.dart';
import 'package:bulk_basket/on_boarding_screen.dart';
import 'package:bulk_basket/bloc/product/quantity_bloc.dart';
import 'package:bulk_basket/views/common/temp1.dart';
import 'package:bulk_basket/views/home/home_screen.dart';
import 'package:bulk_basket/views/home/product_home_screen.dart';
import 'package:bulk_basket/views/home/profile_screen.dart';
import 'package:bulk_basket/views/home/temp2.dart';
import 'package:bulk_basket/views/auth/register_screen.dart';
import 'package:bulk_basket/views/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controller/location_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(LocationController()); // ✅ Make it global
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp(DevicePreview(enabled: true, builder: (context) => MyApp()));
  // runApp( MyApp());
    await GetStorage.init(); // must be initialized before runApp

  runApp(
    DevicePreview(
      enabled: true, //false
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return BlocProvider(
          create: (_) => QuantityBloc(),
          child: MaterialApp(
            useInheritedMediaQuery: true, //start
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder, // end
            debugShowCheckedModeBanner: false,
            // home: Temp2(),
            // home: (FirebaseAuth.instance.currentUser != null)
            //     ? ProductScreen(
            //         userId: FirebaseAuth.instance.currentUser!.uid,
            //       )
            //     : RegisterScreen(),
            home: SplashScreen(),
            // home: NewYearMegaCelebrationScreen(),
          ),
        );
      },
    );
  }
}
