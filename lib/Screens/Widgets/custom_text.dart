import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.maxLines = 2,
    this.fontSize = 15,
    this.color = Colors.white,
  });
  final String text;
  final int? maxLines;
  final double? fontSize;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      style: TextStyle(
        color: color,
        fontSize: fontSize!.h,
      ),
    );
  }
}
