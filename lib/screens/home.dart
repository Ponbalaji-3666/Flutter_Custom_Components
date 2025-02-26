import 'package:flutter/material.dart';
import 'package:flutter_custom_components/common/widgets/default_button.dart';
import 'package:flutter_custom_components/screens/display_comp.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/widgets/alert_dialog.dart';
import '../common/widgets/alert_snackbar.dart';

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
              label: "Camera & Crop",
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DisplayComp(compName: "Camera & Crop")
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
                      builder: (context) => const DisplayComp(compName: "PDF Viewer")
                  ),
                );
              },
              outerPadding: EdgeInsets.only(top: 5.0.h, bottom: 5.0.h),
            ),
            DefaultButton(
              label: "Alert Dialog",
              onPressed: () async {
                await showAlertDialog(
                  context: context,
                  message: "Data is fetched from master record !",
                  status: StatusTypes.info,
                  isAction: false,
                  onConfirm: () {},
                );
                await Future.delayed(Duration(seconds: 1));
                await showAlertDialog(
                  context: context,
                  message: "Data added successfully !",
                  status: StatusTypes.success,
                  isAction: false,
                  onConfirm: () {},
                );
                await Future.delayed(const Duration(seconds: 1));
                await showAlertDialog(
                  context: context,
                  message: "Are you sure to add this data ?",
                  status: StatusTypes.warning,
                  isAction: false,
                  onConfirm: () {},
                );
                await Future.delayed(const Duration(seconds: 1));
                await showAlertDialog(
                  context: context,
                  message: "Failed to add data !",
                  status: StatusTypes.error,
                  isAction: false,
                  onConfirm: () {},
                );
                await Future.delayed(const Duration(seconds: 1));
                await showAlertDialog(
                  context: context,
                  message: "Are you sure you want to delete this data?",
                  status: StatusTypes.warning,
                  isAction: true,
                  onConfirm: () {
                    showAlertSnackBar(
                      context: context,
                      message: 'Data added successfully !',
                      status: Status.success,
                    );
                  },
                );
              },
              outerPadding: EdgeInsets.only(top: 5.0.h, bottom: 5.0.h),
            ),
            DefaultButton(
              label: "Alert Snackbar",
              onPressed: (){
                showAlertSnackBar(
                  context: context,
                  message: 'Data is fetched from master record !',
                  status: Status.info,
                );
                showAlertSnackBar(
                  context: context,
                  message: 'Data added successfully !',
                  status: Status.success,
                );
                showAlertSnackBar(
                  context: context,
                  message: 'Are you sure to add this data ?',
                  status: Status.warning,
                );
                showAlertSnackBar(
                  context: context,
                  message: 'Failed to add data !',
                  status: Status.error,
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
                      builder: (context) => const DisplayComp(compName: "Multi Input")
                  ),
                );
              },
              outerPadding: EdgeInsets.only(top: 5.0.h, bottom: 5.0.h),
            ),
            DefaultButton(
              label: "Dropdown",
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
