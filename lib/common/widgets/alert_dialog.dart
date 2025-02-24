import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';

enum StatusTypes { success, error, warning, info }

Future<void> showAlertDialog({
  required BuildContext context,
  required String message,
  required StatusTypes status,
  required VoidCallback onConfirm,
  required bool isAction,

}) async {
  Icon icon;

  switch (status) {
    case StatusTypes.success:
      icon = const Icon(Icons.check_circle_rounded, color: green);
      break;
    case StatusTypes.error:
      icon = const Icon(Icons.error_outlined, color: red);
      break;
    case StatusTypes.warning:
      icon = const Icon(Icons.warning_outlined, color: orange);
      break;
    case StatusTypes.info:
      icon = const Icon(Icons.info_rounded, color: blue);
      break;
  }

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {

      if (!isAction) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(const Duration(seconds: 2), () {
            if (context.mounted) {
              Navigator.pop(context);
            }
          });
        });
      }

      return AlertDialog(
        title: null,
        icon: icon,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: maroon,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
        actions: isAction ? <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: const Text('OK'),
          ),
        ] : null,
      );
    },
  );
}
