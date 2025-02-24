import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../util/validators.dart';
import '../styles/colors.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String placeHolder;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool isSuffixIcon;
  final IconData? suffixIcon;
  final double suffixIconSize;
  final VoidCallback? onPressSuffixIcon;
  final bool readOnly;
  final Color borderColor;
  final Color backgroundColor;
  final void Function()? onTap;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    this.label = '',
    required this.placeHolder,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isSuffixIcon = false,
    this.suffixIcon,
    this.suffixIconSize = 13,
    this.onPressSuffixIcon,
    this.readOnly = false,
    this.backgroundColor = veryLightGray,
    this.borderColor = lightGray,
    this.onTap,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final Validators _validators = Validators();
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  void defaultOnTap() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label.isNotEmpty)
            // Custom label text
              Text(
                widget.label,
                style: TextStyle(
                  color: darkBlue,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
            SizedBox(height: 4.0.h),
            // Text field widget
            TextFormField(
              controller: widget.controller,
              onTap: widget.onTap,
              readOnly: widget.readOnly,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText ? _isObscured : false,
              validator: widget.validator ?? (value)=>_validators.nonEmpty(value, widget.label),
              decoration: InputDecoration(
                labelText: null,
                hintText: widget.placeHolder,
                hintStyle: TextStyle(
                  color: grey,
                  fontWeight: FontWeight.w300,
                  fontSize: 13.sp,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0.r),
                  borderSide: BorderSide(
                    color: widget.borderColor,
                    width: 1.5.w,
                    style: BorderStyle.solid,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0.r),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0.r),
                  borderSide: const BorderSide(color: lightGray),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
                filled: true,
                fillColor: widget.backgroundColor,
                suffixIcon: widget.obscureText ? IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility_off : Icons.visibility,
                    color: darkBlue,
                    size: 13.sp,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                ): widget.isSuffixIcon ?

                IconButton(
                  icon: Icon(
                    widget.suffixIcon,
                    color: darkBlue,
                    size: widget.suffixIconSize.sp,
                  ),
                  onPressed: widget.onPressSuffixIcon,
                ) : null,
              ),
            ),
          ],
        )
    );
  }
}
