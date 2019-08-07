import 'package:flutter/cupertino.dart';

abstract class BaseService extends ChangeNotifier {
  void initialize();
  void dispose();
}
