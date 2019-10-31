import 'package:flutter/material.dart';
import 'package:ui_dev0/views/home/state/home_controller.dart';
import 'package:ui_dev0/widgets/base_model_widget.dart';

class HomeViewTabletPortrait extends BaseModelWidget<HomeController> {
  @override
  Widget build(BuildContext context, HomeController data) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          alignment: Alignment.center,
          widthFactor: 0.8,
          heightFactor: 0.25,
          child: Container(
            color: Colors.blue,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'TABLET PORTRAIT HOME',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  RaisedButton(
                    child: const Text('Reload'),
                    onPressed: () async => await data.fetchData(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeViewTabletLandscape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          alignment: Alignment.center,
          widthFactor: 0.8,
          heightFactor: 0.25,
          child: Container(
            color: Colors.blue,
            child: Center(
              child: const Text(
                'TABLET LANDSCAPE HOME',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
