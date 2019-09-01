import 'package:flutter/material.dart';
import 'package:studentup_mobile/enum/rule_set.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';
import 'package:studentup_mobile/util/config.dart';

class ProjectRules extends StatelessWidget {
  final RuleSet rulesSet;

  const ProjectRules({Key key, @required this.rulesSet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> rules =
        rulesSet == RuleSet.EndUser ? rulesUser : rulesCompanies;
    List<IconData> icons =
        rulesSet == RuleSet.EndUser ? iconsUser : iconsCompanies;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => print('object'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Project Rules',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            for (int i = 0; i < rules.length; i++) RuleTile(rules[i], icons[i]),
            SizedBox(height: 16.0),
            StadiumButton(
              text: 'Accept',
              onPressed: () => print('object'),
            ),
          ],
        ),
      ),
    );
  }
}

class RuleTile extends StatelessWidget {
  final String rule;
  final IconData iconData;

  const RuleTile(this.rule, this.iconData);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData, size: 32.0),
      title: Text(rule, softWrap: true),
      contentPadding: EdgeInsets.all(16.0),
    );
  }
}
