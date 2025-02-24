import 'package:flutter/material.dart';

class CustomLoader {
  static final CustomLoader _instance = CustomLoader._internal();
  factory CustomLoader() => _instance;

  CustomLoader._internal();

  late OverlayEntry _overlayEntry;
  bool _isLoading = false;

  void show(BuildContext context) {
    if (_isLoading) return;

    _isLoading = true;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: 0,
        right: 0,
        top: 0,
        bottom: 0,
        child: Material(
          color: Colors.black.withOpacity(0.5),
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry);

    // Future.delayed(duration, () {
    //   hide();
    // });
  }

  void hide() {
    if (!_isLoading) return;

    _isLoading = false;
    _overlayEntry.remove();
  }
}
