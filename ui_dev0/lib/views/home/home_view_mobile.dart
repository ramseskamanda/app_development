import 'package:flutter/material.dart';
import 'package:ui_dev0/views/home/state/home_controller.dart';
import 'package:ui_dev0/widgets/base_model_widget.dart';
import 'package:ui_dev0/widgets/base_network_widget.dart';

class HomeViewMobilePortrait extends BaseModelWidget<HomeController> {
  @override
  Widget build(BuildContext context, HomeController controller) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          alignment: Alignment.center,
          widthFactor: 0.8,
          heightFactor: 0.25,
          child: Container(
            color: Colors.black,
            child: Center(
              child: NetworkLoaderWidget(
                state: controller.state,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'MOBILE PORTRAIT HOME',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                    RaisedButton(
                      child: const Text('Reload'),
                      onPressed: () async => await controller.fetchData(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
