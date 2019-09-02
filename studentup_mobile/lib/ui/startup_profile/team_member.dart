import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/ui/profile/other_profile.dart';

class TeamMember extends StatelessWidget {
  final bool isAdditional;
  final int numAdditional;
  final Preview model;

  const TeamMember(
      {Key key, this.isAdditional = false, this.numAdditional = 0, this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => OtherProfile(infoModel: model),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 1.0),
        child: isAdditional
            ? CircleAvatar(
                radius: 32.0,
                child: Text('+$numAdditional'),
                backgroundColor: CupertinoColors.lightBackgroundGray,
              )
            : CachedNetworkImage(
                imageUrl: model.imageUrl,
                placeholder: (_, url) => CircleAvatar(
                  radius: 32.0,
                  backgroundColor: CupertinoColors.lightBackgroundGray,
                ),
                errorWidget: (_, url, error) => CircleAvatar(
                  radius: 32.0,
                  backgroundColor: CupertinoColors.lightBackgroundGray,
                  child: Icon(Icons.error),
                ),
                imageBuilder: (context, image) {
                  return CircleAvatar(
                    radius: 32.0,
                    backgroundImage: image,
                  );
                },
              ),
      ),
    );
  }
}
