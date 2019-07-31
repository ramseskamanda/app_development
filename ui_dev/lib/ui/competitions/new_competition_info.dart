import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_dev/services/competition_creation_service.dart';
import 'package:ui_dev/ui/competitions/file_attachment.dart';
import 'package:provider/provider.dart';

class NewCompetitionInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 24.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'New Competition',
                style: Theme.of(context).textTheme.display1.copyWith(
                      color: CupertinoColors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(height: 24.0),
            ImageSelection(),
            const SizedBox(height: 12.0),
            InputTextFields(),
            Attachments(),
          ],
        ),
      ),
    );
  }
}

class ImageSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CompetitionCreationService>(
      builder: (context, service, child) {
        return Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                color: CupertinoColors.extraLightBackgroundGray,
                image: service.image != null
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(service.image),
                      )
                    : null,
              ),
              child: service.image == null
                  ? Center(
                      child: const Text('No image selected yet.'),
                    )
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: FittedBox(
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(CupertinoIcons.collections_solid),
                        onPressed: () => service.pickImage(1),
                      ),
                      IconButton(
                        icon: Icon(CupertinoIcons.photo_camera_solid),
                        onPressed: () => service.pickImage(0),
                      ),
                      if (service.image != null) ...[
                        IconButton(
                          icon: Icon(Icons.crop_rotate),
                          onPressed: () => service.cropImage(),
                        ),
                        IconButton(
                          icon: Icon(CupertinoIcons.delete_solid),
                          onPressed: () => service.clearImage(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class InputTextFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CompetitionCreationService>(
      builder: (context, service, child) {
        return Form(
          child: Column(
            children: <Widget>[
              Card(
                child: TextField(
                  controller: service.name,
                  maxLines: 1,
                  inputFormatters: [LengthLimitingTextInputFormatter(32)],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Name of the competition',
                    hintStyle: TextStyle(color: Colors.blueGrey.shade300),
                    prefix: SizedBox(width: 16.0),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Card(
                child: TextField(
                  controller: service.description,
                  maxLines: null,
                  minLines: 5,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write a description...',
                    hintStyle: TextStyle(color: Colors.blueGrey.shade300),
                    prefix: SizedBox(width: 16.0),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Attachments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CompetitionCreationService>(
      builder: (context, service, child) {
        int _length = service.files.length + 1;
        return Column(
          children: <Widget>[
            for (int i = 0; i < _length; i++)
              FileAttachment(
                key: ValueKey(i),
                isAddButton: i == _length - 1,
                index: i,
              ),
          ],
        );
      },
    );
  }
}
