import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/new_think_tank_notifier.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';

class ThinkTankEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewThinkTankNotifier>(
      builder: (_) => NewThinkTankNotifier(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          title: const Text('New Think Tank'),
        ),
        body: SafeArea(
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.85,
              child: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Consumer<NewThinkTankNotifier>(
                      builder: (context, notifier, child) {
                        return Stack(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                const SizedBox(height: 24.0),
                                TextField(
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  controller: notifier.name,
                                  maxLength: 32,
                                  maxLengthEnforced: true,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Title of your think tank?',
                                  ),
                                ),
                                const SizedBox(height: 24.0),
                                TextField(
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  controller: notifier.description,
                                  maxLength: 400,
                                  maxLengthEnforced: true,
                                  minLines: 10,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'What\'re your thinking about...',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 16.0,
                    left: 0,
                    right: 0,
                    child: Consumer<NewThinkTankNotifier>(
                      builder: (context, notifier, child) {
                        if (notifier.isLoading)
                          return Center(
                              child: const CircularProgressIndicator());
                        return StadiumButton(
                          text: 'Post Think Tank',
                          onPressed: () async {
                            final result = await notifier.sendData();
                            if (result) Navigator.of(context).pop(result);
                          },
                        );
                      },
                    ),
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
