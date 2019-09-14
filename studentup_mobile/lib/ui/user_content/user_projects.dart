import 'package:flutter/material.dart';
import 'package:flutter_villains/villain.dart';

class UserProjects extends StatefulWidget {
  @override
  _UserProjectsState createState() => _UserProjectsState();
}

class _UserProjectsState extends State<UserProjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        title: const Text('My Projects'),
      ),
      body: Center(
        child: Villain(
          villainAnimation: VillainAnimation.fromBottom(
            to: Duration(minutes: 1),
          ),
          secondaryVillainAnimation: VillainAnimation.fade(
            to: Duration(minutes: 1),
          ),
          child: const Text('Coming Soon!'),
        ),
      ),
    );
  }
}
