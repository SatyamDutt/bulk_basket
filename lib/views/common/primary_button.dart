import 'package:bulk_basket/views/auth/login_screen.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final String title;
  final Function()? ontTap;
  final Color? textColor;
  final Color? bgColor ;
  final bool? isLoading;
  const PrimaryButton({super.key, required this.title, required this.ontTap,
  this.textColor = Colors.white,
  this.bgColor  = Colors.green,
  this.isLoading = false
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
      disabledColor: Colors.grey.withOpacity(0.1),
      onPressed: widget.isLoading == true ? null : widget.ontTap,
      // () {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => LoginScreen(),
      //     ),
      //   );)
      // },
      child: widget.isLoading == true
          ? const SizedBox(
              height: 22,
              width: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.green,
              ),
            )
          : Text(
        widget.title,
        style: TextStyle(
          color: widget.textColor,
          fontSize: 20,
        ),
      ),
    );
  }
}
