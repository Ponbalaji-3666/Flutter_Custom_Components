import 'package:flutter/material.dart';
import 'package:flutter_custom_components/common/widgets/text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';
import 'alert_snackbar.dart';
import 'default_button.dart';

class MultiInput extends StatefulWidget {
  final String label;
  final String placeholder;
  final Function(List<String>) onItemsChanged;

  const MultiInput({
    super.key,
    required this.label,
    required this.placeholder,
    required this.onItemsChanged,
  });

  @override
  State<MultiInput> createState() => _MultiInputState();
}

class _MultiInputState extends State<MultiInput> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _items = [];

  void _addItem() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      if (!_items.contains(text)) {
        setState(() {
          _items.add(text);
        });
        _textController.clear();
      } else {
        showAlertSnackBar(
          context: context,
          message: 'Item already added',
          status: Status.error,
        );
      }
      widget.onItemsChanged(_items);
    }
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
    widget.onItemsChanged(_items);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: widget.label,
          placeHolder: widget.placeholder,
          controller:  _textController,
          keyboardType: TextInputType.text,
          isSuffixIcon: true,
          suffixIcon: Icons.add,
          suffixIconSize: 15.sp,
          onPressSuffixIcon: _addItem,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0.h),
                child: ListTile(
                  minTileHeight: 35.0.h,
                  tileColor: softPinkGrey,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  title: Text(_items[index]),
                  trailing: InkWell(
                    child: Icon(
                      Icons.close,
                      color: darkBlue,
                      size: 14.5.sp,
                    ),
                    onTap: () => _removeItem(index),
                  ),
                ),
              );
            },
          ),
        ),
        DefaultButton(
          label: "Add Locations",
          onPressed: (){
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(_items.toString())));
          },
          outerPadding: EdgeInsets.only(top: 0.0.h, bottom: 0.0.h),
        ),
      ],
    );
  }
}