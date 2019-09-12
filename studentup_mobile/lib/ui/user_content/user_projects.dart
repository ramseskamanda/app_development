import 'package:flutter/material.dart';

class UserProjects extends StatelessWidget {
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
        child: const Text('Coming Soon!'),
      ),
    );
  }
}
