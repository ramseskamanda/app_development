import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/enum/notification_type.dart';
import 'package:studentup_mobile/router.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/notifications/notification_service.dart';
import 'package:studentup_mobile/ui/widgets/toasts/default_notification_toast.dart';
import 'package:studentup_mobile/ui/widgets/toasts/message_toast.dart';

mixin NotificationDisplayMixin {
  StreamSubscription _subscription;

  void initializeMixin(BuildContext context) {
    _subscription =
        Locator.of<NotificationService>().onMessage.listen((notification) {
      if (notification == null) return;
      switch (notification.type) {
        case NotificationType.DEFAULT:
          DefaultNotificationToast.show(
            context: context,
            model: notification,
            stateManagerCallback: () =>
                Provider.of<InnerRouter>(context).goToNotifications(),
          );
          break;
        case NotificationType.MESSAGING:
          MessageToast.show(
            context: context,
            model: notification,
            stateManagerCallback: () =>
                Provider.of<InnerRouter>(context).goToMessaging(),
          );
          break;
        default:
          return;
      }
    });
  }

  void disposeMixin() {
    _subscription.cancel();
  }
}
