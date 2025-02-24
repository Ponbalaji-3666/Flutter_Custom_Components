import 'package:flutter/material.dart';
import 'package:flutter_custom_components/common/widgets/default_button.dart';
import 'package:flutter_custom_components/screens/display_comp.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DefaultButton(
              label: "Map",
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DisplayComp(compName: "Map")
                  ),
                );
              },
              outerPadding: EdgeInsets.only(top: 4.0.h, bottom: 4.0.h),
            ),
            DefaultButton(
              label: "OCR",
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DisplayComp(compName: "OCR")
                  ),
                );
              },
              outerPadding: EdgeInsets.only(top: 4.0.h, bottom: 4.0.h),
            ),
            DefaultButton(
              label: "Image & Crop",
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DisplayComp(compName: "ImageCrop")
                  ),
                );
              },
              outerPadding: EdgeInsets.only(top: 5.0.h, bottom: 5.0.h),
            ),
            DefaultButton(
              label: "PDF Viewer",
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DisplayComp(compName: "PdfViewer")
                  ),
                );
              },
              outerPadding: EdgeInsets.only(top: 5.0.h, bottom: 5.0.h),
            ),
            DefaultButton(
              label: "Alert Dialog",
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DisplayComp(compName: "AlertDialog")
                  ),
                );
              },
              outerPadding: EdgeInsets.only(top: 5.0.h, bottom: 5.0.h),
            ),
            DefaultButton(
              label: "Alert Snackbar",
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DisplayComp(compName: "AlertSnackbar")
                  ),
                );
              },
              outerPadding: EdgeInsets.only(top: 5.0.h, bottom: 5.0.h),
            ),
            DefaultButton(
              label: "Multi Input",
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DisplayComp(compName: "MultiInput")
                  ),
                );
              },
              outerPadding: EdgeInsets.only(top: 5.0.h, bottom: 5.0.h),
            ),
            DefaultButton(
              label: "Custom Dropdown",
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DisplayComp(compName: "Dropdown")
                  ),
                );
              },
              outerPadding: EdgeInsets.only(top: 5.0.h, bottom: 5.0.h),
            ),
          ],
        ),
      ),
    );
  }
}
