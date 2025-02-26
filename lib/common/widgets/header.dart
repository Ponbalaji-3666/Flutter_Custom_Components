import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';

class Header extends StatefulWidget {
  final bool showBackButton;
  final String? title;

  const Header({
    super.key,
    this.showBackButton = true,
    this.title
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.showBackButton
              ? IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 22.w,
              color: maroon,
            ),
          ) : SizedBox(width: 35.0.w),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${widget.title}',
                style: TextStyle(
                  color: darkBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.5.sp,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
            },
            icon: const Icon(Icons.menu_outlined)
          )
        ],
      ),
    );
  }
}
