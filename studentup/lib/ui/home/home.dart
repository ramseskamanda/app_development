import 'package:studentup/ui/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Object>(
        stream: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) => HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  Widget _buildSliver(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: const Icon(Icons.home),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          transitionBetweenRoutes: false,
          leading: ProfileDrawerButton(),
          largeTitle: const Text('Events'),
        ),
        SliverPadding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.11,
          ),
          sliver: _buildSliver(context),
        ),
      ],
    );
  }
}
