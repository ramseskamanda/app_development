import 'package:provider/provider.dart';
import 'package:studentup/notifiers/authentication_notifier.dart';
import 'package:studentup/util/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NameTextFormField extends StatefulWidget {
  final Sink<String> sink;
  final FocusNode nextNode;
  NameTextFormField({Key key, @required this.sink, this.nextNode})
      : super(key: key);
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
    AuthenticationNotifier _auth = Provider.of<AuthenticationNotifier>(context);
    return TextFormField(
      controller: _controller,
      validator: Validator.name,
      onFieldSubmitted: (String data) =>
          FocusScope.of(context).requestFocus(widget.nextNode ?? FocusNode()),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Full Name',
        errorText: _auth.hasError ? _auth.error : null,
        prefixIcon: Icon(
          Theme.of(context).platform == TargetPlatform.iOS
              ? CupertinoIcons.profile_circled
              : Icons.person,
        ),
      ),
    );
  }
}
