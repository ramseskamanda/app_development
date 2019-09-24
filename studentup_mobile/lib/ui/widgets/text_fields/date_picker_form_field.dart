import 'package:flutter/cupertino.dart';
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

  final bool allowBlank;

  const InlineDatePickerFormField({
    Key key,
    this.controller,
    this.hintText,
    this.onChange,
    @required this.onConfirm,
    this.onClose,
    this.onCancel,
    this.allowBlank = false,
  }) : super(key: key);
  @override
  _InlineDatePickerFormFieldState createState() =>
      _InlineDatePickerFormFieldState();
}

class _InlineDatePickerFormFieldState extends State<InlineDatePickerFormField> {
  bool _canClear = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: TextField(
            textCapitalization: TextCapitalization.sentences,
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
                initialDateTime: DateTime.now(),
                onCancel: widget.onCancel,
                onClose: widget.onClose,
                onChange: widget.onChange,
                onConfirm: (date, i) {
                  widget.onConfirm(date, i);
                  setState(() {
                    _canClear = true;
                  });
                },
              );
            },
          ),
        ),
        if (widget.allowBlank && _canClear)
          IconButton(
            icon: const Icon(CupertinoIcons.clear_circled_solid),
            color: Theme.of(context).disabledColor,
            onPressed: () {
              widget.controller.clear();
              setState(() {
                _canClear = false;
              });
            },
          ),
      ],
    );
  }
}
