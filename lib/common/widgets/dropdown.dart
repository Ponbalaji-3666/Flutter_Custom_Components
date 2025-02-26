import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_components/common/widgets/text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';

class CustomDropDown extends StatefulWidget {
  final ValueChanged <List<dynamic>>? onSelectionChanged;
  final TextEditingController? textEditingController;
  final String label;
  final String placeHolder;
  final String itemsTitle;
  final List<SelectedListItem>? items;
  final bool enableMultipleSelection;
  final bool isDisable;

  const CustomDropDown({
    super.key,
    this.textEditingController,
    required this.label,
    required this.placeHolder,
    this.itemsTitle = "Choose Options",
    this.items,
    this.onSelectionChanged,
    this.enableMultipleSelection = false,
    this.isDisable = false
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {

  void onTextFieldTap() {

    DropDownState(
      dropDown: DropDown(
          dropDownBackgroundColor: white,
          listTileColor: white,
          searchFillColor: lightGray,
          isDismissible: true,
          bottomSheetTitle: Text(
            widget.itemsTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0.sp,
            ),
          ),
          submitButtonText: 'Save',
          clearButtonText: 'Clear',
          data: widget.items ?? [],
          onSelected: (List<dynamic> selectedList) {
            List<dynamic> list = [];
            for (var item in selectedList) {
              if (item is SelectedListItem) {
                list.add(item);
              }
            }

            if (widget.onSelectionChanged != null) {
              widget.onSelectionChanged!(list);
            }
            // showSnackBar(list.toString());
          },
          enableMultipleSelection: widget.enableMultipleSelection
      ),
    ).showModal(context);
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          label: widget.label,
          placeHolder: widget.placeHolder,
          controller:  widget.textEditingController,
          keyboardType: TextInputType.text,
          onTap: widget.isDisable ? (){} : onTextFieldTap,
          readOnly: true,
          isSuffixIcon: true,
          suffixIcon: Icons.arrow_drop_down,
          suffixIconSize: 18,
        ),
      ],
    );
  }
}
