import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/auth_notifier.dart';
import 'package:studentup_mobile/util/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailTextFormField extends StatefulWidget {
  final Sink<String> sink;
  final FocusNode nextNode;
  EmailTextFormField({Key key, @required this.sink, @required this.nextNode})
      : super(key: key);
  @override
  _EmailTextFormFieldState createState() => _EmailTextFormFieldState();
}

class _EmailTextFormFieldState extends State<EmailTextFormField> {
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
      validator: Validator.email,
      onFieldSubmitted: (String data) =>
          FocusScope.of(context).requestFocus(widget.nextNode),
      autocorrect: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Email',
        errorText: _auth.hasError ? _auth.error.toString() : null,
        prefixIcon: Icon(CupertinoIcons.mail),
      ),
    );
  }
}
