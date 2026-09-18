import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputLabel extends StatefulWidget {
  final String title;
  const InputLabel({super.key,
  required this.title
  });

  @override
  State<InputLabel> createState() => _InputLabelState();
}

class _InputLabelState extends State<InputLabel> {
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Text(widget.title,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
