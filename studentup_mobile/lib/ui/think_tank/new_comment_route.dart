import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/think_tank_notifier.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';

class NewCommentRoute extends StatelessWidget {
  final ThinkTankNotifier notifier;

  const NewCommentRoute({Key key, @required this.notifier}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: CupertinoColors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('New Comment'),
      ),
      body: ChangeNotifierProvider<ThinkTankNotifier>.value(
        value: notifier,
        child: SafeArea(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.85,
              child: Stack(
                children: <Widget>[
                  TextField(
                    controller: notifier.newComment,
                    maxLength: 1000,
                    maxLengthEnforced: true,
                    minLines: 10,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your comment here...',
                    ),
                  ),
                  Positioned(
                    bottom: 24.0,
                    left: 0,
                    right: 0,
                    child: Consumer<ThinkTankNotifier>(
                      builder: (context, notifier, child) {
                        if (notifier.isLoading)
                          return Center(
                              child: const CircularProgressIndicator());
                        return StadiumButton(
                          text: 'Post Comment',
                          onPressed: () async {
                            await notifier.postComment();
                            Navigator.of(context).pop();
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
