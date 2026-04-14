import 'dart:async';
import 'package:bulk_basket/views/auth/register_screen.dart';
import 'package:bulk_basket/views/home/product_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import '../controller/location_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// final locationController =  Get.find<LocationController>();

class _SplashScreenState extends State<SplashScreen> {
    @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  (FirebaseAuth.instance.currentUser != null)
                ? ProductScreen(
                    userId: FirebaseAuth.instance.currentUser!.uid,
                  )
                : RegisterScreen(),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: Color(0xff01bf61),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/wlinkit.png',
            height: 300,    
            width: 300,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(25.0),
          //   child: PrimaryButton(title: 'Get Started', ontTap: () {}),
          // )
        ],
      ),
    );
  }
}


//NEW

// import 'dart:math';
// import 'package:flutter/material.dart';

// class NewYearMegaCelebrationScreen extends StatefulWidget {
//   const NewYearMegaCelebrationScreen({super.key});

//   @override
//   State<NewYearMegaCelebrationScreen> createState() =>
//       _NewYearMegaCelebrationScreenState();
// }

// class _NewYearMegaCelebrationScreenState
//     extends State<NewYearMegaCelebrationScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   final Random _random = Random();

//   final List<_FallingItem> _sparkles = [];
//   final List<_FallingItem> _flowers = [];
//   final List<_FallingItem> _confetti = [];
//   final List<_Firework> _fireworks = [];

//   static const double speedFactor = 2.5; // 🌟 GLOBAL SPEED CONTROL

//   @override
//   void initState() {
//     super.initState();
//     splashActions();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 6),
//     )
//       ..addListener(_update)
//       ..repeat();

//     _initItems();
//   }

//   void splashActions(){
//     Timer(Duration(seconds: 5), () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) =>  (FirebaseAuth.instance.currentUser != null)
//                 ? ProductScreen(
//                     userId: FirebaseAuth.instance.currentUser!.uid,
//                   )
//                 : RegisterScreen(),
//         ),
//       );
//     });
//   }

//   void _initItems() {
//     for (int i = 0; i < 120; i++) {
//       _sparkles.add(_FallingItem.random(_random));
//     }
//     for (int i = 0; i < 30; i++) {
//       _flowers.add(_FallingItem.random(_random, isFlower: true));
//     }
//     for (int i = 0; i < 40; i++) {
//       _confetti.add(_FallingItem.random(_random, isConfetti: true));
//     }

//     for (int i = 0; i < 4; i++) {
//       _fireworks.add(
//         _Firework(
//           Offset(_random.nextDouble() * 400, 120 + _random.nextDouble() * 200),
//           _random.nextDouble(),
//         ),
//       );
//     }
//   }

//   void _update() {
//     final size = MediaQuery.of(context).size;

//     void updateList(List<_FallingItem> list) {
//       for (final item in list) {
//         item.position = Offset(
//           item.position.dx,
//           item.position.dy + item.speed * speedFactor,
//         );
//         if (item.position.dy > size.height) {
//           item.reset(size, _random);
//         }
//       }
//     }

//     updateList(_sparkles);
//     updateList(_flowers);
//     updateList(_confetti);

//     for (final fw in _fireworks) {
//       fw.progress += 0.008;
//       if (fw.progress > 1) {
//         fw.progress = 0;
//         fw.center = Offset(
//           _random.nextDouble() * size.width,
//           120 + _random.nextDouble() * 200,
//         );
//       }
//     }

//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFF1B1B2F),
//               Color(0xFF162447),
//               Color(0xFF0F0F0F),
//             ],
//           ),
//         ),
//         child: Stack(
//           children: [
//             CustomPaint(
//               painter: HangingGoldPainter(_controller),
//               size: Size.infinite,
//             ),

//             CustomPaint(
//               painter: FireworkPainter(_fireworks),
//               size: Size.infinite,
//             ),

//             CustomPaint(
//               painter: FallingPainter(_sparkles, type: FallingType.sparkle),
//               size: Size.infinite,
//             ),

//             CustomPaint(
//               painter: FallingPainter(_flowers, type: FallingType.flower),
//               size: Size.infinite,
//             ),

//             CustomPaint(
//               painter: FallingPainter(_confetti, type: FallingType.confetti),
//               size: Size.infinite,
//             ),

//             // 🎉 CONTENT
//             Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // 🏢 LOGO AREA
//                   Container(
//                     height: 70,
//                     width: 160,
//                     margin: const EdgeInsets.only(bottom: 18),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.08),
//                       // color: Color(0xff01bf61),
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.white24),
//                     ),
//                     alignment: Alignment.center,
//                     child: 
//                     // const Text(
//                     //   "WLINKIT LOGO",
//                     //   style: TextStyle(
//                     //     color: Colors.white54,
//                     //     letterSpacing: 1,
//                     //     fontSize: 12,
//                     //   ),
//                     // ),

//                     RichText(
//   text: TextSpan(
//     children: [
//       TextSpan(
//         text: 'Wlink',
//         style: TextStyle(
//           // color: Colors.blue,
//           color: Color(0xff01bf61),
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       TextSpan(
//         text: 'It',
//         style: TextStyle(
//           // color: Colors.orange,
//           color: Colors.white,
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     ],
//   ),
// )

//                   ),
//                   // 🎆 YEAR
//                   ShaderMask(
//                     shaderCallback: (bounds) => const LinearGradient(
//                       colors: [
//                         Color(0xFFFFD700),
//                         Color(0xFFFFA500),
//                         Color(0xFFFFD700),
//                       ],
//                     ).createShader(bounds),
//                     child: const Text(
//                       "2026",
//                       style: TextStyle(
//                         fontSize: 88,
//                         fontWeight: FontWeight.w900,
//                         color: Colors.white,
//                         shadows: [
//                           Shadow(
//                             blurRadius: 30,
//                             color: Colors.black,
//                             offset: Offset(0, 12),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 12),

//                   // HAPPY STRIP
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 28, vertical: 6),
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [
//                           Color(0xFFFFD700),
//                           Color(0xFFFFA500),
//                         ],
//                       ),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: const Text(
//                       "HAPPY",
//                       style: TextStyle(
//                         letterSpacing: 4,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 8),

//                   const Text(
//                     "NEW YEAR",
//                     style: TextStyle(
//                       fontSize: 28,
//                       letterSpacing: 6,
//                       color: Colors.white70,
//                     ),
//                   ),

//                   const SizedBox(height: 24),

//                   // MESSAGE
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 30),
//                     padding: const EdgeInsets.all(18),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.white30),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Text(
//                       "May every day of the New Year shine with\n"
//                       "good cheers, happiness, prosperity\n"
//                       "and success for you and your family.\n\n"
//                       "— Team Wlinkit",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white70,
//                         height: 1.5,
//                       ),
//                     ),
                   
//                   ),

//                   const SizedBox(height: 20),

//                   const Text(
//                     "Wlinkit • Fastest Grocery Delivery",
//                     style: TextStyle(
//                       color: Colors.white54,
//                       letterSpacing: 1,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

// /* =======================
//    MODELS
//    ======================= */

// enum FallingType { sparkle, flower, confetti }

// class _FallingItem {
//   Offset position;
//   double speed;
//   double size;
//   double rotation;

//   _FallingItem(this.position, this.speed, this.size, this.rotation);

//   factory _FallingItem.random(Random r,
//       {bool isFlower = false, bool isConfetti = false}) {
//     return _FallingItem(
//       Offset(r.nextDouble() * 400, r.nextDouble() * 800),
//       isFlower
//           ? 0.2 + r.nextDouble() * 0.4
//           : isConfetti
//               ? 0.4 + r.nextDouble() * 0.6
//               : 0.15 + r.nextDouble() * 0.3,
//       isFlower ? 6 + r.nextDouble() * 6 : 3 + r.nextDouble() * 4,
//       r.nextDouble() * pi,
//     );
//   }

//   void reset(Size size, Random r) {
//     position = Offset(r.nextDouble() * size.width, -20);
//   }
// }

// class _Firework {
//   Offset center;
//   double progress;

//   _Firework(this.center, this.progress);
// }

// /* =======================
//    PAINTERS
//    ======================= */

// class FallingPainter extends CustomPainter {
//   final List<_FallingItem> items;
//   final FallingType type;

//   FallingPainter(this.items, {required this.type});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint();

//     for (final item in items) {
//       switch (type) {
//         case FallingType.sparkle:
//           paint.color = Colors.white.withOpacity(0.6);
//           canvas.drawCircle(item.position, item.size / 2, paint);
//           canvas.drawCircle(
//               item.position, item.size, paint..color = Colors.white24);
//           break;

//         case FallingType.flower:
//           paint.color = Colors.pinkAccent.withOpacity(0.75);
//           canvas.drawCircle(item.position, item.size, paint);
//           break;

//         case FallingType.confetti:
//           paint.color = Colors.amberAccent.withOpacity(0.9);
//           canvas.save();
//           canvas.translate(item.position.dx, item.position.dy);
//           canvas.rotate(item.rotation);
//           canvas.drawRect(
//             Rect.fromCenter(
//               center: Offset.zero,
//               width: item.size,
//               height: item.size,
//             ),
//             paint,
//           );
//           canvas.restore();
//           break;
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(_) => true;
// }

// class HangingGoldPainter extends CustomPainter {
//   final Animation<double> animation;

//   HangingGoldPainter(this.animation) : super(repaint: animation);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.amber.withOpacity(0.5)
//       ..strokeWidth = 2;

//     for (int i = 0; i < 14; i++) {
//       final x = size.width * (i / 14);
//       final sway = sin(animation.value * pi + i) * 4;

//       canvas.drawLine(
//         Offset(x, 0),
//         Offset(x + sway, 140),
//         paint,
//       );
//       canvas.drawCircle(
//         Offset(x + sway, 150),
//         4,
//         paint,
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(_) => true;
// }

// class FireworkPainter extends CustomPainter {
//   final List<_Firework> fireworks;

//   FireworkPainter(this.fireworks);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..strokeWidth = 2;

//     for (final fw in fireworks) {
//       for (int i = 0; i < 12; i++) {
//         final angle = (2 * pi / 12) * i;
//         final radius = fw.progress * 60;

//         paint.color = Colors.amberAccent.withOpacity(1 - fw.progress);

//         canvas.drawLine(
//           fw.center,
//           fw.center + Offset(cos(angle), sin(angle)) * radius,
//           paint,
//         );
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(_) => true;
// }
