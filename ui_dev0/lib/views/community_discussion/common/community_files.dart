import 'package:flutter/material.dart';
import 'package:ui_dev0/data_models/asset_model.dart';
import 'package:ui_dev0/enums/controller_states.dart';
import 'package:ui_dev0/views/community_page/state/community_controller.dart';
import 'package:ui_dev0/widgets/base_model_widget.dart';
import 'package:ui_dev0/widgets/base_network_widget.dart';
import 'package:ui_dev0/widgets/common_ui/file_widget.dart';

class CommunityPageFiles extends BaseModelWidget<CommunityController> {
  @override
  Widget build(BuildContext context, CommunityController controller) {
    return StreamBuilder(
      stream: controller.files,
      builder: (context, AsyncSnapshot<List<FileAsset>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty)
            return Center(
              child: const Text('No files shared yet!'),
            );
          return ListView(
            children: snapshot.data
                .map((file) => FileWidget(key: ValueKey(file.id), file: file))
                .toList(),
          );
        }
        return NetworkLoaderWidget(
          state: snapshot.hasError
              ? ControllerState.HAS_ERROR
              : ControllerState.BUSY,
          child: Container(),
        );
      },
    );
  }
}
