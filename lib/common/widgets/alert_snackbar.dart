import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';

enum Status { success, error, warning, info }

void showAlertSnackBar({
  required BuildContext context,
  required String message,
  required Status status,
  Duration? duration,
}) {
  duration = const Duration(seconds: 2);

  Icon icon;
  Color backgroundColor;
  Color borderColor;
  Color textColor;
  String title;

  switch (status) {
    case Status.success:
      icon = const Icon(Icons.check_circle_rounded, color: green);
      backgroundColor = paleGreen;
      borderColor = lightGreen;
      textColor = green;
      title = "Success";
      break;
    case Status.error:
      icon = const Icon(Icons.error_outlined, color: red);
      backgroundColor = paleRed;
      borderColor = lightRed;
      textColor = red;
      title = "Error";
      break;
    case Status.warning:
      icon = const Icon(Icons.warning_outlined, color: orange);
      backgroundColor = paleOrange;
      textColor = orange;
      borderColor = lightOrange;
      title = "Warning";
      break;
    case Status.info:
      icon = const Icon(Icons.info_rounded, color: blue);
      backgroundColor = paleBlue;
      borderColor = lightBlue;
      textColor = blue;
      title = "Info";
      break;
  }

  final snackBar = SnackBar(
    margin: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 15.0.h),
    behavior: SnackBarBehavior.floating,
    showCloseIcon: true,
    closeIconColor: textColor,

    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: borderColor,
        width: 1.5,
        style: BorderStyle.solid,
      ),
    ),
    content: Row(
      children: [
        icon,
        SizedBox(width: 8.0.w),
        Flexible(
            fit: FlexFit.loose,
            child: Column(
              children: [
                Text.rich(
                  TextSpan(
                    text: '$title: ',
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: message,
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
      ],
    ),
    backgroundColor: backgroundColor,
    duration: duration,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
