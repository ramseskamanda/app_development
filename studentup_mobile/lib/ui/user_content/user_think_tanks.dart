import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/models/think_tank_model.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/services/authentication/base_auth.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/storage/base_api.dart';
import 'package:studentup_mobile/ui/widgets/screens/see_all.dart';

class UserThinkTanks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String uid = Locator.of<BaseAuth>().currentUserId;
    final Stream<List<ThinkTankModel>> projectsStream =
        Locator.of<BaseAPIReader>().fetchThinkTanksByOwnerStream(uid);
    return SeeAll(
      separator: const SizedBox(height: 16.0),
      stream: projectsStream,
      title: 'My Think Tanks',
      type: ThinkTankModel,
      emptyBuilder: Center(
        child: const Text('You have no think tanks yet!'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: const Icon(
          Icons.add,
          color: CupertinoColors.white,
        ),
        onPressed: () => Navigator.of(context).pushNamed(Router.newThinkTank),
      ),
    );
  }
}
