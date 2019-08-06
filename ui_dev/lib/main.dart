import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_dev/notifiers/view_notifiers/profile_notifier.dart';
import 'package:ui_dev/test_data.dart';
import 'package:ui_dev/ui/chat_screen/chats.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => ProfileNotifier(uid: TestData.userId),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.lightGreen),
        home: Chats(),
      ),
    );
  }
}
