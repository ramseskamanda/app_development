import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_dev0/views/create_community/state/info.dart';

class CreateCommunityInfo extends StatelessWidget {
  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FractionallySizedBox(
        widthFactor: 0.86,
        child: Consumer<CommunityInfoBloc>(builder: (context, infoBloc, child) {
          return Column(
            children: <Widget>[
              const SizedBox(height: 32.0),
              TextField(
                controller: name
                  ..addListener(() => infoBloc.name.add(name.text)),
                maxLines: 1,
                maxLength: 32,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Community Name',
                ),
              ),
              const SizedBox(height: 32.0),
              TextField(
                controller: description
                  ..addListener(
                      () => infoBloc.description.add(description.text)),
                minLines: 5,
                maxLines: null,
                maxLength: 400,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write a description',
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
