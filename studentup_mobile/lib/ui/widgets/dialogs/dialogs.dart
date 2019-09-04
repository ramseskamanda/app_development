import 'package:flutter/cupertino.dart';
import 'package:studentup_mobile/ui/widgets/dialogs/coming_soon.dart';
import 'package:studentup_mobile/ui/widgets/dialogs/network_error_dialog.dart';
import 'package:studentup_mobile/ui/widgets/dialogs/rating_dialog.dart';

class Dialogs {
  static void showNetworkErrorDialog(BuildContext context) =>
      NetworkErrorDialog().show(context);
  static void showComingSoon(BuildContext context) =>
      ComingSoon().show(context);
  static void showRatingFor(
    BuildContext context,
    String premise,
    IconData icon,
  ) =>
      StarRatingDialog().show(context, premise, icon);
}
