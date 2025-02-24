// import 'dart:async';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_locales/flutter_locales.dart';
// import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';
// import 'package:provider/provider.dart';
// import 'package:qpmc_app/common/widgets/text_field.dart';
// import 'package:qpmc_app/providers/ocr_provider.dart';
// import 'default_button.dart';
//
// class Ocr extends StatefulWidget {
//   final Function(String)? onScan;
//   final VoidCallback onPressed;
//   const Ocr({
//     super.key,
//     this.onScan,
//     required this.onPressed
//   });
//
//   @override
//   State<Ocr> createState() => _OcrState();
// }
//
// class _OcrState extends State<Ocr> {
//   String text = "";
//   final StreamController<String> controller = StreamController<String>();
//   bool torchOn = false;
//   int cameraSelection = 0;
//   bool lockCamera = true;
//   bool lockText = false;
//   bool loading = false;
//   final GlobalKey<ScalableOCRState> cameraKey = GlobalKey<ScalableOCRState>();
//
//   void setText(value) {
//     controller.add(value);
//   }
//
//
//   @override
//   void initState(){
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     cameraKey.currentState?.dispose();
//     controller.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: <Widget>[
//         !loading
//             ? ScalableOCR(
//             key: cameraKey,
//             torchOn: torchOn,
//             cameraSelection: cameraSelection,
//             lockCamera: lockCamera,
//             paintboxCustom: Paint()
//               ..style = PaintingStyle.stroke
//               ..strokeWidth = 4.0
//               ..color = const Color.fromARGB(153, 102, 160, 241),
//             boxLeftOff: 5,
//             boxBottomOff: 2.5,
//             boxRightOff: 5,
//             boxTopOff: 2.5,
//             boxHeight: MediaQuery.of(context).size.height / 3,
//             getRawData: (value) {
//               inspect(value);
//             },
//             getScannedText: (value) {
//               setText(value);
//             })
//             : Padding(
//           padding: const EdgeInsets.all(17.0),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             height: MediaQuery.of(context).size.height / 3,
//             width: MediaQuery.of(context).size.width,
//             child: const Center(
//               child: CircularProgressIndicator(),
//             ),
//           ),
//         ),
//         StreamBuilder<String>(
//           stream: controller.stream,
//           builder:
//               (BuildContext context, AsyncSnapshot<String> snapshot) {
//             if (!lockText && snapshot.data != null) {
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 Provider.of<OcrProvider>(context, listen: false)
//                     .setOcrText(snapshot.data!);
//               });
//             }
//             return Result(
//               onScan: widget.onScan,
//               onPressed: widget.onPressed,
//               lockText: lockText,
//             );
//           },
//         ),
//         const Spacer(),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.flip_camera_ios),
//                 onPressed: () {
//                   setState(() {
//                     loading = true;
//                     cameraSelection = cameraSelection == 0 ? 1 : 0;
//                   });
//                   Future.delayed(const Duration(milliseconds: 150), () {
//                     setState(() {
//                       loading = false;
//                     });
//                   });
//                 },
//               ),
//               IconButton(
//                 icon: torchOn ? const Icon(Icons.flash_on) : const Icon(Icons.flash_off),
//                 onPressed: () async {
//                   setState(() {
//                     loading = true;
//                     torchOn = !torchOn;
//                   });
//                   Future.delayed(const Duration(milliseconds: 150), () {
//                     setState(() {
//                       loading = false;
//                     });
//                   });
//                 },
//               ),
//               IconButton(
//                 icon: lockText ? const Icon(Icons.lock) : const Icon(Icons.lock_open),
//                 onPressed: () {
//                   setState(() {
//                     loading = true;
//                     lockText = !lockText;
//                   });
//                   Future.delayed(const Duration(milliseconds: 150), () {
//                     setState(() {
//                       loading = false;
//                     });
//                   });
//                 },
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
//
// class Result extends StatelessWidget {
//   const Result({
//     super.key,
//     this.onScan,
//     required this.onPressed,
//     required this.lockText
//   });
//
//   final Function(String)? onScan;
//   final VoidCallback onPressed;
//   final bool lockText;
//
//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController codeController = TextEditingController();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       codeController.text = Provider.of<OcrProvider>(context, listen: false).ocrText;
//     });
//
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//           children: [
//             CustomTextField(
//               label: Locales.string(context, 'truck_number'),
//               placeHolder: Locales.string(context, 'enter_truck_number'),
//               controller: codeController,
//               readOnly: !lockText,
//               keyboardType: TextInputType.text,
//             ),
//             DefaultButton(
//                 label: "Validate Truck Number",
//                 outerPadding: const EdgeInsets.symmetric(vertical: 40),
//                 onPressed: onPressed
//             ),
//           ]
//       ),
//     );
//   }
// }