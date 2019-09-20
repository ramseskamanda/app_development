import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/auth_notifier.dart';
import 'package:studentup_mobile/util/validators.dart';

class NameTextFormField extends StatefulWidget {
  final Sink<String> sink;
  final FocusNode nextNode;
  final String hintText;

  NameTextFormField({
    Key key,
    @required this.sink,
    this.nextNode,
    this.hintText = 'Full Name',
  }) : super(key: key);
  @override
  _NameTextFormFieldState createState() => _NameTextFormFieldState();
}

class _NameTextFormFieldState extends State<NameTextFormField> {
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
    AuthNotifier _auth = Provider.of<AuthNotifier>(context);
    return TextFormField(
      controller: _controller,
      validator: Validator.name,
      maxLength: 32,
      buildCounter: (context, {currentLength, maxLength, isFocused}) => null,
      onFieldSubmitted: (String data) =>
          FocusScope.of(context).requestFocus(widget.nextNode ?? FocusNode()),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: widget.hintText,
        errorText: _auth.hasError ? _auth.error.toString() : null,
        prefixIcon: Icon(
          Theme.of(context).platform == TargetPlatform.iOS
              ? CupertinoIcons.profile_circled
              : Icons.person,
        ),
      ),
    );
  }
}
