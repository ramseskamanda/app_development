import 'package:flutter/material.dart';
import 'package:studentup_mobile/enum/login_types.dart';
import 'package:studentup_mobile/util/config.dart';

class Disclaimer extends StatelessWidget {
  final AuthType type;
  Disclaimer({Key key, @required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Theme.of(context).scaffoldBackgroundColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Disclaimer',
          style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  termsAndConditions,
                  softWrap: true,
                  textAlign: TextAlign.justify,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context, rootNavigator: true)
                        .pop<bool>(false),
                  ),
                  const SizedBox(width: 24.0),
                  RaisedButton(
                    shape: StadiumBorder(),
                    color: Theme.of(context).accentColor,
                    textColor: Theme.of(context).scaffoldBackgroundColor,
                    child: const Text('Proceed'),
                    onPressed: () => Navigator.of(context, rootNavigator: true)
                        .pop<bool>(true),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
