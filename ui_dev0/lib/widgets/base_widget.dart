import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_dev0/widgets/base_controller.dart';

class BaseWidget<T extends BaseController> extends StatefulWidget {
  final Widget Function(BuildContext) builder;
  final Future<void> Function(T) modelInitializer;
  final Future<void> Function(T) onModelReady;
  final T viewModel;

  final Widget Function(BuildContext) loadingBuilder;
  final Widget Function(BuildContext) errorBuilder;

  const BaseWidget({
    Key key,
    @required this.builder,
    this.onModelReady,
    this.viewModel,
    this.loadingBuilder,
    this.errorBuilder,
    @required this.modelInitializer,
  })  : assert(builder != null, 'Builder cannot be null.'),
        assert(viewModel != null, 'Controller cannot be null.'),
        super(key: key);

  @override
  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends BaseController> extends State<BaseWidget<T>> {
  @override
  Widget build(BuildContext context) {
    if (widget.modelInitializer != null)
      widget.modelInitializer(widget.viewModel);
    if (widget.onModelReady != null) widget.onModelReady(widget.viewModel);
    return ChangeNotifierProvider<T>(
      builder: (context) => widget.viewModel,
      child: widget.builder(context),
    );
  }
}
