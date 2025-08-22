import 'package:bulk_basket/views/auth/login_screen.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final String title;
  final Function()? ontTap;
  final Color? textColor;
  final Color? bgColor ;
  const PrimaryButton({super.key, required this.title, required this.ontTap,
  this.textColor = Colors.white,
  this.bgColor  = Colors.green,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 60,
      minWidth: double.maxFinite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: widget.bgColor,
      onPressed: widget.ontTap,
      // () {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => LoginScreen(),
      //     ),
      //   );)
      // },
      child: Text(
        widget.title,
        style: TextStyle(
          color: widget.textColor,
          fontSize: 20,
        ),
      ),
    );
  }
}
