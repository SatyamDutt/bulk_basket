import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryTextfield extends StatefulWidget {
  final String hintText;
  final TextEditingController? inputValue;
  final TextInputType? inputType;
    // ✅ ADD THIS
  final String? Function(String?)? validator;
  const PrimaryTextfield({
    super.key,
    required this.hintText,
    this.inputValue,
    this.inputType,
    this.validator
  });

  @override
  State<PrimaryTextfield> createState() => _PrimaryTextfieldState();
}

class _PrimaryTextfieldState extends State<PrimaryTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.inputValue,
      keyboardType: widget.inputType,
      validator: widget.validator,
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
