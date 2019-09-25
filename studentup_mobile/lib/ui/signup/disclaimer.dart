import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/enum/login_types.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/web_service.dart';
import 'package:studentup_mobile/util/config.dart';

class Disclaimer extends StatefulWidget {
  final AuthType type;
  Disclaimer({Key key, @required this.type}) : super(key: key);

  @override
  _DisclaimerState createState() => _DisclaimerState();
}

class _DisclaimerState extends State<Disclaimer> {
  TapGestureRecognizer _privacyRecognizer;
  TapGestureRecognizer _termsRecognizer;
  bool _acceptedPrivacy = false;
  bool _acceptedTerms = false;

  @override
  void initState() {
    super.initState();
    _privacyRecognizer = TapGestureRecognizer()
      ..onTap = () => Locator.of<WebService>()
          .launchURLInDefaultBrowser(PRIVACY_POLICY_URL);
    _termsRecognizer = TapGestureRecognizer()
      ..onTap = () =>
          Locator.of<WebService>().launchURLInDefaultBrowser(TERMS_OF_USE_URL);
  }

  @override
  void dispose() {
    _privacyRecognizer.dispose();
    _termsRecognizer.dispose();
    super.dispose();
  }

  _togglePrivacy(bool value) {
    setState(() {
      _acceptedPrivacy = value;
    });
  }

  _toggleTerms(bool value) {
    setState(() {
      _acceptedTerms = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Theme.of(context).iconTheme.color,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Disclaimer',
          style: TextStyle(color: Theme.of(context).textTheme.title.color),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              termsAndConditions,
              softWrap: true,
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(height: 16.0),
          ListTile(
            leading: Checkbox(
              value: _acceptedTerms,
              onChanged: _toggleTerms,
            ),
            title: RichText(
              text: TextSpan(
                text: 'I agree to the Terms of Use, as found ',
                style: Theme.of(context).textTheme.body2,
                children: [
                  TextSpan(
                    text: 'here',
                    style: TextStyle(
                      color: CupertinoColors.activeBlue,
                    ),
                    recognizer: _termsRecognizer,
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: Checkbox(
              value: _acceptedPrivacy,
              onChanged: _togglePrivacy,
            ),
            title: RichText(
              text: TextSpan(
                text: 'I agree to the Privacy Policy, as found ',
                style: Theme.of(context).textTheme.body2,
                children: [
                  TextSpan(
                    text: 'here',
                    style: TextStyle(
                      color: CupertinoColors.activeBlue,
                    ),
                    recognizer: _privacyRecognizer,
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
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
                  textColor: CupertinoColors.white,
                  child: const Text('Proceed'),
                  onPressed: !(_acceptedTerms && _acceptedPrivacy)
                      ? null
                      : () => Navigator.of(context, rootNavigator: true)
                          .pop<bool>(true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
