import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryTextfield extends StatefulWidget {
  final String hintText;
  final TextEditingController? inputValue;
  final TextInputType? inputType;
  const PrimaryTextfield({
    super.key,
    required this.hintText,
    this.inputValue,
    this.inputType
  });

  @override
  State<PrimaryTextfield> createState() => _PrimaryTextfieldState();
}

class _PrimaryTextfieldState extends State<PrimaryTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.inputValue,
      keyboardType: widget.inputType,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10.r,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
          )),
    );
  }
}
