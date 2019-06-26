import 'package:clique/bloc/notification_bloc.dart';
import 'package:clique/services/service_locator.dart';
import 'package:flutter/material.dart';

mixin NotificationMixin<T extends StatefulWidget> on State<T> {
  NotificationBloc _bloc = locator<NotificationBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.stream.listen((String s) => print(s));
  }
}
