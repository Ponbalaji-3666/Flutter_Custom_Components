import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../services/directory_service.dart';
import '../styles/colors.dart';
import 'alert_snackbar.dart';
import 'default_button.dart';
import 'loader.dart';

class PdfViewer extends StatefulWidget {
  final String base64String;
  const PdfViewer({super.key, required this.base64String});

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  final DirectoryService _directoryService = DirectoryService();
  bool isReady = false;
  int? pages = 0;
  int? currentPage = 0;
  final Completer<PDFViewController> _controller = Completer<PDFViewController>();


  Future<void> _download() async {
    CustomLoader().show(context);

    PermissionStatus extStoragePermission = await Permission.manageExternalStorage.request();
    PermissionStatus storagePermission = await Permission.storage.request();

    if (extStoragePermission.isGranted || storagePermission.isGranted) {
      try {
        // Decode the Base64 string
        final bytes = base64Decode(widget.base64String);
        String? selectedDirectory = await _directoryService.getDownloadDirectory();

        if(selectedDirectory == null || selectedDirectory.isEmpty){
          selectedDirectory = await FilePicker.platform.getDirectoryPath();
          _directoryService.storeDownloadDirectory(selectedDirectory!);
        }

        if (selectedDirectory != null) {
          try{
            final timestamp = DateTime.now().millisecondsSinceEpoch;
            final file = File('$selectedDirectory/pdf_file_$timestamp.pdf');
            await file.writeAsBytes(bytes.buffer.asUint8List());
            CustomLoader().hide();

            if(mounted){
              showAlertSnackBar(
                context: context,
                message: "File Downloaded !",
                status: Status.success,
              );
            }
          }catch(e){
            CustomLoader().hide();
            if(mounted){
              showAlertSnackBar(
                context: context,
                message: 'Error while saving PDF',
                status: Status.error,
              );
            }
          }

        } else {
          CustomLoader().hide();
          if(mounted){
            showAlertSnackBar(
              context: context,
              message: 'Failed to find a valid directory',
              status: Status.error,
            );
          }
        }
      } catch (e) {
        // debugPrint('Error: $e');
        CustomLoader().hide();
        if(mounted){
          showAlertSnackBar(
            context: context,
            message: 'Error while saving PDF',
            status: Status.error,
          );
        }
      }
    } else {
      CustomLoader().hide();
      if(mounted){
        showAlertSnackBar(
          context: context,
          message: 'Storage Permission denied',
          status: Status.error,
        );
      }
    }
  }


  void _back(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: darkBlue,  // Border color
                  width: 1.0,  // Border width
                ),
              ),
              child: PDFView(
                pdfData: base64Decode(widget.base64String),
                enableSwipe: true,
                swipeHorizontal: false,
                autoSpacing: false,
                pageFling: true,
                pageSnap: true,
                fitEachPage: true,
                backgroundColor: Colors.grey,
                onRender: (pages) {
                  setState(() {
                    pages = pages;
                    isReady = true;
                  });
                },
                onError: (error) {
                  debugPrint("PDF Error: $error");
                },
                onPageError: (page, error) {
                  debugPrint("Page $page Error: $error");
                },
                onViewCreated: (PDFViewController pdfViewController) {
                  _controller.complete(pdfViewController);
                },
                onPageChanged: (int? page, int? total) {
                  setState(() {
                    currentPage = page!;
                  });
                },
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultButton(
                  width: 140.w,
                  label: "Back",
                  onPressed: _back,
                  labelColor: maroon,
                  backgroundColor: white,
                  borderColor: maroon,
                  outerPadding: EdgeInsets.only(top: 20.0.h, bottom: 0.0.h),
                ),
                DefaultButton(
                  width: 140.w,
                  label: "Download",
                  onPressed: _download,
                  outerPadding: EdgeInsets.only(top: 20.0.h, bottom: 0.0.h),
                  isIcon: true,
                  icon: Icons.file_download_outlined,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
