import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

typedef DateValueCallback(DateTime dateTime, List<int> selectedIndex);
typedef DateVoidCallback();

class InlineDatePickerFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final DateValueCallback onChange;
  final DateValueCallback onConfirm;
  final DateVoidCallback onClose;
  final DateVoidCallback onCancel;

  const InlineDatePickerFormField({
    Key key,
    this.controller,
    this.hintText,
    this.onChange,
    @required this.onConfirm,
    this.onClose,
    this.onCancel,
  }) : super(key: key);
  @override
  _InlineDatePickerFormFieldState createState() =>
      _InlineDatePickerFormFieldState();
}

class _InlineDatePickerFormFieldState extends State<InlineDatePickerFormField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      readOnly: true,
      maxLines: 1,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: widget.hintText,
      ),
      onTap: () async {
        DatePicker.showDatePicker(
          context,
          // DateTime minDateTime,
          // DateTime maxDateTime,
          initialDateTime: DateTime.now(),
          onCancel: widget.onCancel,
          onClose: widget.onClose,
          onChange: widget.onChange,
          onConfirm: widget.onConfirm,
        );
      },
    );
  }
}
