import 'package:studentup_mobile/util/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef String ValidationMethod(String data);

class PasswordTextFormField extends StatefulWidget {
  final bool confirm;
  final Sink<String> sink;
  final ValidationMethod validator;
  final FocusNode nextNode;
  PasswordTextFormField({
    Key key,
    this.confirm = false,
    @required this.sink,
    this.nextNode,
    this.validator,
  }) : super(key: key);

  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _pressed = false;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() => widget.sink.add(_controller.text));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidate: false,
      validator: widget.confirm ? widget.validator : Validator.password,
      onFieldSubmitted: (String data) =>
          FocusScope.of(context).requestFocus(widget.nextNode ?? FocusNode()),
      textInputAction:
          widget.nextNode == null ? TextInputAction.done : TextInputAction.next,
      autocorrect: false,
      controller: _controller,
      obscureText: !_pressed,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: widget.confirm ? 'Confirm Password' : 'Password',
        prefixIcon: Icon(
          widget.confirm
              ? CupertinoIcons.lab_flask_solid
              : CupertinoIcons.lab_flask,
        ),
        suffix: GestureDetector(
          child: Icon(_pressed ? CupertinoIcons.eye_solid : CupertinoIcons.eye),
          onTap: () {
            setState(() {
              _pressed = !_pressed;
            });
          },
        ),
      ),
    );
  }
}
