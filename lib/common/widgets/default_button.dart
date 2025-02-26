import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';

class DefaultButton extends StatelessWidget {
  final double width;
  final String label;
  final VoidCallback onPressed;
  final Color labelColor;
  final Color backgroundColor;
  final Color borderColor;
  final EdgeInsetsGeometry innerPadding;
  final EdgeInsetsGeometry outerPadding;
  final bool isIcon;
  final IconData icon;

  const DefaultButton({
    super.key,
    this.width = double.infinity,
    required this.label,
    required this.onPressed,
    this.labelColor = white,
    this.backgroundColor = maroon,
    this.borderColor = maroon,
    this.innerPadding = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
    this.outerPadding = const EdgeInsets.symmetric(vertical: 10.0),
    this.isIcon = false,
    this.icon = Icons.check,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: outerPadding.vertical, horizontal: outerPadding.horizontal
        ),
        child: SizedBox(
          width: width,
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              backgroundColor: backgroundColor, // Button background color
              padding: EdgeInsets.symmetric(
                  vertical: innerPadding.vertical, horizontal: innerPadding.horizontal
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r), // Rounded corners
              ),
              side: BorderSide(color: borderColor),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: labelColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(left:8.0.w),
                //   child: isIcon ? Opacity(
                //     opacity: 0.9,
                //     child: Icon(
                //       icon,
                //       color: labelColor,
                //       size: 18.sp,
                //     ),
                //   ) : null,
                // ),
              ],
            ),
          ),
        )
    );

  }
}
