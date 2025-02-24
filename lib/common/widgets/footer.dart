import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Container(
        color: biscuit,
        padding: EdgeInsets.only(top: 6.0.h, bottom: 8.0.h, left:40.0.w, right:40.0.w),
        height: 65.0.h,
        child: Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    if(currentRoute != '/home'){
                      Navigator.pushNamed(context, '/home');
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        currentRoute == '/home' ? Icons.home : Icons.home_outlined,
                        size: 21.w,
                        color: maroon,
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        "Home",
                        style: TextStyle(
                          color: maroon,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.5.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if(currentRoute != '/account'){
                      Navigator.pushNamed(context, '/account');
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        currentRoute == '/account' ? Icons.person : Icons.person_outline,
                        size: 21.5.w,
                        color: maroon,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Account",
                        style: TextStyle(
                          color: maroon,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.5.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
        )
    );
  }
}
