import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_custom_components/common/widgets/custom_cam.dart';
import 'package:flutter_custom_components/common/widgets/custom_map.dart';
import 'package:flutter_custom_components/common/widgets/dropdown.dart';
import '../common/styles/colors.dart';
import '../common/widgets/default_button.dart';
import '../common/widgets/header.dart';
import '../common/widgets/multi_input.dart';
import '../common/widgets/pdf_viewer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import '../services/mlkit_service.dart';

class DisplayComp extends StatefulWidget {
  final String compName;
  const DisplayComp({super.key, required this.compName});

  @override
  State<DisplayComp> createState() => _DisplayCompState();
}

class _DisplayCompState extends State<DisplayComp> {
  late Map<String, dynamic>? locationData = {};
  final MlkitService _mlkitService = MlkitService();
  late String _extractedText = "";
  late String _imgPath = "";
  late List<dynamic> selectedLocation = [];
  late List<dynamic> selectedLocations = [];
  final TextEditingController _locController = TextEditingController();

  void _updateLocation(dynamic data) {
    setState(() {
      locationData = data;
      debugPrint('${locationData?['placeName']}');
    });
  }

  Future<void> _onImageCaptured(String path) async {
    setState(() {
      _imgPath = path;
    });

    final inputImage = InputImage.fromFilePath(path);
    final extractedText = await _mlkitService.ocr(inputImage);

    setState(() {
      _extractedText = extractedText;
    });
  }

  void _onLocationsChanged(List<dynamic> selectedItems) {
    setState(() {
      selectedLocations = selectedItems;
    });
  }

  void _onLocationChanged(List<dynamic> selectedItems) {
    setState(() {
      _locController.text = selectedItems[0].name;
      selectedLocation = selectedItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget slectedWidget;

    switch (widget.compName) {
      case "Map":
        slectedWidget = Column(
          children: [
            Expanded(
                child: CustomMap(
                    onLocationChanged: _updateLocation
                ),
            ),
            Container(
              color: white,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              height: 90.0.h,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${locationData?['placeName']}',
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              style: TextStyle(
                                  color: darkBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  overflow: TextOverflow.ellipsis
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              '(${locationData?['latitude']}, ${locationData?['longitude']})',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: darkBlue,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.sp,
                                  overflow: TextOverflow.ellipsis
                              ),
                            ),
                          ],
                        )
                    ),
                    SizedBox(width: 10.0.w),
                    DefaultButton(
                      label: "Add",
                      width: 60.w,
                      outerPadding: const EdgeInsets.all(0.0),
                      innerPadding: const EdgeInsets.all(4.0),
                      onPressed: () => {
                        ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(locationData?['placeName'])))
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        );
        break;
      case "OCR":
        slectedWidget =  _imgPath.isEmpty ?
        CustomCam(onImageCaptured: _onImageCaptured) :
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(
              File(_imgPath),
              width: 300.w,
              height: 300.h,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            Text(
              _extractedText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: darkBlue,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ],
        );
        break;
      case "Camera & Crop":
        slectedWidget = _imgPath.isEmpty ?
        CustomCam(onImageCaptured: _onImageCaptured) :
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(
              File(_imgPath),
              width: 300.w,
              height: 300.h,
              fit: BoxFit.contain,
            ),
          ],
        );
        break;
      case "PDF Viewer":
        slectedWidget = const PdfViewer(
            base64String: "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ZXNjZW50IC0yMTMgL0ZsYWdzIDk2Ci9Gb250QkJveCBbLTQwOSAtMjE0IDEwOTkgOTUxXSAvRm9udE5hbWUgL1BVQUxYQStIZWx2ZXRpY2FOZXVlLUxpZ2h0SXRhbGljCi9JdGFsaWNBbmdsZSAtMTIgL1N0ZW1WIDY3IC9MZWFkaW5nIDI4IC9NYXhXaWR0aCAxMTIwIC9TdGVtSCA1OCAvWEhlaWdodCA1MjQKL0ZvbnRGaWxlMiAyMiAwIFIgPj4KZW5kb2JqCjI1IDAgb2JqClsgMjc4IDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMjc4IDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAKMCAwIDY4NSAwIDUzNyAwIDAgMCAwIDAgMCAwIDAgMCA2MzAgMCAwIDAgNTU2IDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDUxOQowIDAgMCA1MTkgMjU5IDAgNTM3IDE4NSAwIDAgMTg1IDgzMyA1MzcgMCA1NzQgMCAwIDQ4MSAwIDUzNyAwIDAgMCAwIDAgMCAwCjAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAKMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMAowIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgMCAwIDAgNDQ0IF0KZW5kb2JqCjkgMCBvYmoKPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1RydWVUeXBlIC9CYXNlRm9udCAvUFVBTFhBK0hlbHZldGljYU5ldWUtTGlnaHRJdGFsaWMKL0ZvbnREZXNjcmlwdG9yIDI0IDAgUiAvV2lkdGhzIDI1IDAgUiAvRmlyc3RDaGFyIDMyIC9MYXN0Q2hhciAyMjIgL0VuY29kaW5nCi9NYWNSb21hbkVuY29kaW5nID4+CmVuZG9iagoxIDAgb2JqCjw8IC9UaXRsZSAoc2FtcGxlKSAvQXV0aG9yIChQaGlsaXAgSHV0Y2hpc29uKSAvQ3JlYXRvciAoUGFnZXMpIC9Qcm9kdWNlciAoTWFjIE9TIFggMTAuNS40IFF1YXJ0eiBQREZDb250ZXh0KQovQ3JlYXRpb25EYXRlIChEOjIwMDgwNzAxMDUyNDQ3WjAwJzAwJykgL01vZERhdGUgKEQ6MjAwODA3MDEwNTI0NDdaMDAnMDAnKQo+PgplbmRvYmoKeHJlZgowIDI2CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAxNzkzMCAwMDAwMCBuIAowMDAwMDAzOTgyIDAwMDAwIG4gCjAwMDAwMDUwNzMgMDAwMDAgbiAKMDAwMDAwMDAyMiAwMDAwMCBuIAowMDAwMDAzOTYyIDAwMDAwIG4gCjAwMDAwMDQwODYgMDAwMDAgbiAKMDAwMDAwNTAzNyAwMDAwMCBuIAowMDAwMDA3OTU3IDAwMDAwIG4gCjAwMDAwMTc3NDAgMDAwMDAgbiAKMDAwMDAxMzY5MiAwMDAwMCBuIAowMDAwMDA0MjA5IDAwMDAwIG4gCjAwMDAwMDUwMTcgMDAwMDAgbiAKMDAwMDAwNTE1NiAwMDAwMCBuIAowMDAwMDA1MjA2IDAwMDAwIG4gCjAwMDAwMDc0NzIgMDAwMDAgbiAKMDAwMDAwNzQ5MyAwMDAwMCBuIAowMDAwMDA3NzU1IDAwMDAwIG4gCjAwMDAwMDgxNDYgMDAwMDAgbiAKMDAwMDAxMzE0NiAwMDAwMCBuIAowMDAwMDEzMTY3IDAwMDAwIG4gCjAwMDAwMTM0MjQgMDAwMDAgbiAKMDAwMDAxMzg3NyAwMDAwMCBuIAowMDAwMDE3MDE2IDAwMDAwIG4gCjAwMDAwMTcwMzcgMDAwMDAgbiAKMDAwMDAxNzMwMiAwMDAwMCBuIAp0cmFpbGVyCjw8IC9TaXplIDI2IC9Sb290IDEzIDAgUiAvSW5mbyAxIDAgUiAvSUQgWyA8NGU5NDk1MTVhYWYxMzI0OThmNjUwZTdiZGU2Y2RjMmY+Cjw0ZTk0OTUxNWFhZjEzMjQ5OGY2NTBlN2JkZTZjZGMyZj4gXSA+PgpzdGFydHhyZWYKMTgxMzIKJSVFT0YK"
        );
        break;
      case "Multi Input":
        slectedWidget = MultiInput(
          label: 'Add Locations',
          placeholder: 'enter location here',
          onItemsChanged: (List<String> list) {
            debugPrint(list.toString());
          },
        );
        break;
      case "Dropdown":
        slectedWidget = Column(
          children: [
            CustomDropDown(
              label: "Select Location",
              placeHolder: "Select location here",
              itemsTitle: "Choose Location",
              onSelectionChanged: _onLocationChanged,
              textEditingController: _locController,
              items: [
                SelectedListItem(
                  name: "Chennai",
                  value: "1001",
                ),
                SelectedListItem(
                  name: "Mumbai",
                  value: "1002",
                ),
                SelectedListItem(
                  name: "Delhi",
                  value: "1003",
                ),
                SelectedListItem(
                  name: "Bangalore",
                  value: "1004",
                ),
                SelectedListItem(
                  name: "Kolkata",
                  value: "1005",
                ),
                SelectedListItem(
                  name: "Pune",
                  value: "1006",
                ),
              ],
            ),
            CustomDropDown(
                label: "Select Locations",
                placeHolder: "Select locations here",
                itemsTitle: "Choose Locations",
                enableMultipleSelection: true ,
                onSelectionChanged:_onLocationsChanged,
                items: [
                  SelectedListItem(
                      name: "Chennai",
                      value: "1001",
                  ),
                  SelectedListItem(
                      name: "Mumbai",
                      value: "1002",
                  ),
                  SelectedListItem(
                    name: "Delhi",
                    value: "1003",
                  ),
                  SelectedListItem(
                    name: "Bangalore",
                    value: "1004",
                  ),
                  SelectedListItem(
                    name: "Kolkata",
                    value: "1005",
                  ),
                  SelectedListItem(
                    name: "Pune",
                    value: "1006",
                  ),
                ],
            ),
            Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: selectedLocations.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0.h),
                      child: Card(
                        color:veryLightGrey2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                          side: const BorderSide(
                            color: mildGrey, // Border color (light grey)
                            width: 1.0, // Border width
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 6.0.h),
                          child: Text(
                            selectedLocations[index].name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: darkBlue,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ),
            DefaultButton(
              label: "Confirm",
              onPressed: (){
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        textAlign: TextAlign.start,
                        'Selected Location : ${selectedLocation[0].name}'
                    ),
                    Text(
                        textAlign: TextAlign.start,
                        'Selected Locations : ${selectedLocations.map((item) => item.name).join(', ').toString()}'
                    ),
                  ],
                )));
              },
              outerPadding: EdgeInsets.only(top: 0.0.h, bottom: 0.0.h),
            ),
          ],
        );
        break;
      default:
        slectedWidget = const Center(child: Text("Unknown Component"));
        break;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Header(
          title: widget.compName,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 8.0.h),
        child: Center(child: slectedWidget),
      ),
    );
  }
}
