import 'package:flutter/cupertino.dart';
import 'package:studentup_mobile/ui/widgets/dialogs/coming_soon.dart';
import 'package:studentup_mobile/ui/widgets/dialogs/delete_dialog.dart';
import 'package:studentup_mobile/ui/widgets/dialogs/logout_dialog.dart';
import 'package:studentup_mobile/ui/widgets/dialogs/network_error_dialog.dart';
import 'package:studentup_mobile/ui/widgets/dialogs/rating_dialog.dart';

class Dialogs {
  static Future<bool> showLogoutDialog(BuildContext context) async =>
      await LogoutDialog().show(context);
  static Future<bool> showDeletionDialog(BuildContext context) async =>
      await DeletionDialog().show(context);
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
