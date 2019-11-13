import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommunityTextField extends StatelessWidget {
  final FocusNode focusNode;

  const CommunityTextField({Key key, this.focusNode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        ListTile(
          title: TextField(
            focusNode: focusNode,
            textCapitalization: TextCapitalization.sentences,
            autofocus: true,
            minLines: 1,
            maxLines: 5,
            onSubmitted: (s) {},
            // onChanged: (value) {
            //   if (value.length > 0) service.canSend = true;
            //   if (value.length > 1) return;
            //   if (value.length == 0) service.canSend = false;
            // },
            textInputAction: TextInputAction.send,
            decoration: InputDecoration.collapsed(
              hintText: 'Type your message...',
            ),
            // focusNode: service.focusNode,
          ),
          trailing: IconButton(
            icon: Icon(Icons.send),
            onPressed: () {},
            // onPressed: service.canSend
            //     ? () async {
            //         if (!await service.sendData(MessagingAction.SEND))
            //           Dialogs.showNetworkErrorDialog(context);
            //       }
            //     : null,
            color: Theme.of(context).accentColor,
          ),
        ),
        Row(
          children: <Widget>[
            for (int _ in [0, 1, 2, 3]) ...[
              const SizedBox(width: 24),
              InkWell(
                child: const Icon(
                  Icons.camera_alt,
                  size: 22.0,
                ),
                onTap: () {},
              ),
            ]
          ],
        ),
        const SizedBox(height: 12.0),
      ],
    );
  }
}
// Transform(
//                 transform: Matrix4.rotationZ(pi / 5),
//                 child: InkWell(
//                   child: const Icon(
//                     Icons.attach_file,
//                     size: 22.0,
//                   ),
//                   onTap: () {},
//                 ),
//               ),
