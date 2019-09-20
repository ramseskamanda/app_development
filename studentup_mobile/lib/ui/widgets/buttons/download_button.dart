import 'dart:io';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/storage/base_file_storage_api.dart';
import 'package:studentup_mobile/ui/widgets/dialogs/dialogs.dart';

class DownloadButton extends StatefulWidget {
  final String file;
  final bool useFlatButton;

  const DownloadButton({
    Key key,
    @required this.file,
    this.useFlatButton = false,
  }) : super(key: key);

  @override
  _DownloadButtonState createState() => _DownloadButtonState();
}

//TODO: adapt this to work for multiple files / Change the design to show all the available attachments
class _DownloadButtonState extends State<DownloadButton> {
  Observable<DownloadEvent> download;
  String fileUri;

  _startDownload() async {
    if (!await Dialogs.showDownloadDialog(context)) return;
    print(widget.file);
    download = await Locator.of<BaseFileStorageAPI>()
        .downloadTemp(filePath: widget.file);
    download.listen((data) {
      setState(() {
        fileUri = data.uri;
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (fileUri != null)
      return IconButton(
        icon: const Icon(Icons.description),
        onPressed: () =>
            Locator.of<BaseFileStorageAPI>().showFile(file: File(fileUri)),
      );
    if (download != null)
      return StreamBuilder<DownloadEvent>(
        stream: download,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          return CircularPercentIndicator(
            radius: 32.0,
            percent: snapshot.data.percentageProgress,
            progressColor: Theme.of(context).accentColor,
            backgroundColor: Colors.transparent,
            // center: Icon(
            //   Icons.stop,
            //   color: Theme.of(context).accentColor,
            // ),
          );
        },
      );
    return IconButton(
      icon: const Icon(Icons.file_download),
      color: Theme.of(context).accentColor,
      onPressed: _startDownload,
    );
  }
}
