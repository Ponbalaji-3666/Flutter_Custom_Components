import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import '../styles/colors.dart';
import 'alert_snackbar.dart';

class CustomCam extends StatefulWidget {
  final Function(String) onImageCaptured;
  const CustomCam({super.key, required this.onImageCaptured});

  @override
  State<CustomCam> createState() => _CustomCamState();
}

class _CustomCamState extends State<CustomCam> {
  late List<CameraDescription> _cameras;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isFlashOn = false;
  int _currentCameraIndex = 0;
  late bool isShow = false;

  Future<void> _initializeCameras() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        _controller = CameraController(_cameras[_currentCameraIndex], ResolutionPreset.max);
        _initializeControllerFuture = _controller.initialize();
        _initializeControllerFuture.then((_) async {
          if (!mounted) {
            return;
          }
          setState(() {});
        }).catchError((Object e) {
          if (e is CameraException) {
            switch (e.code) {
              case 'CameraAccessDenied':
                if(mounted){
                  showAlertSnackBar(
                    context: context,
                    message: "Camera Access Denied",
                    status: Status.error,
                  );
                }
                break;
              default:
                if(mounted){
                  showAlertSnackBar(
                    context: context,
                    message: "Something Went Wrong",
                    status: Status.error,
                  );
                }
                break;
            }
          }
        });
      } else {
        if(mounted){
          showAlertSnackBar(
            context: context,
            message: "Camera Not Found",
            status: Status.error,
          );
        }
      }
    } catch (e) {
      debugPrint('Error initializing cameras: $e');
      if(mounted){
        showAlertSnackBar(
          context: context,
          message: "Something Went Wrong",
          status: Status.error,
        );
      }
    }
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await _initializeCameras();
      isShow = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _captureAndProcessImage() async {
    try {
      await _initializeControllerFuture;

      final image = await _controller.takePicture();
      _cropImage(image.path);

    } catch (e) {
      // print("Error: $e");
      if(mounted){
        showAlertSnackBar(
          context: context,
          message: "Error while taking picture",
          status: Status.error,
        );
      }
    }
  }

  Future<void> _cropImage(String imagePath) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imagePath,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: maroon,
            toolbarWidgetColor: white,
            backgroundColor: white,
            activeControlsWidgetColor: oliveGreen,
            lockAspectRatio: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              // CropAspectRatioPresetCustom(),
            ],
          ),
          IOSUiSettings(
            title: 'Crop Image',
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              // CropAspectRatioPresetCustom(),
            ],
          ),
        ]

    );

    if (croppedFile != null) {
      widget.onImageCaptured(croppedFile.path);
    }
  }

  void _toggleFlash() async {
    if (_isFlashOn) {
      await _controller.setFlashMode(FlashMode.off);
    } else {
      await _controller.setFlashMode(FlashMode.torch);
    }

    setState(() {
      _isFlashOn = !_isFlashOn;
    });
  }

  void _switchCamera() async {
    _currentCameraIndex = (_currentCameraIndex + 1) % _cameras.length;
    _controller = CameraController(
      _cameras[_currentCameraIndex],
      ResolutionPreset.high,
    );
    await _controller.initialize();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return isShow ? FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: CameraPreview(_controller)
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.flip_camera_ios),
                          onPressed: _switchCamera,
                        ),
                        IconButton(
                          icon: const Icon(Icons.camera),
                          onPressed: _captureAndProcessImage,
                        ),
                        IconButton(
                          icon: Icon(_isFlashOn ? Icons.flash_on : Icons.flash_off),
                          onPressed: _toggleFlash,
                        ),
                      ],
                    ),
                  ),
                ],
              )
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    ) : const Center(child: CircularProgressIndicator());
  }
}