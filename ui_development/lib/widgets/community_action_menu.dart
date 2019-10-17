import 'package:flutter/material.dart';
import 'package:ui_development/main.dart';

enum CommunityActions {
  REPORT,
  REPLY_CONVERSATION,
  REACT_COMMENT,
  TOGGLE_MEMBERSHIP,
  REQUEST_ACCESS,
  INFO,
  DOWNLOAD_FILE,
}

showReactionDialog(BuildContext context) async {
  return await showDialog<String>(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: ReactionPicker(),
      );
    },
  );
}

_showReportDialog(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Something wrong to report?'),
        content: const Text(
          'Are you sure you want to report this problem? We strongly encourage the reporting of inappropriate behavior and/or content. '
          'However, we urge our users to consider our (robotic) staff and the work needed to process all user requests.',
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop<bool>(false),
          ),
          RaisedButton(
            child: const Text('Report'),
            onPressed: () => Navigator.of(context).pop<bool>(true),
          ),
        ],
      );
    },
  );
}

showRequestAccessDialog(BuildContext context) async {
  final TextEditingController controller = TextEditingController(
      text: 'Hi there! I would love to join your community.');
  return await showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Request access to this community?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Personalized requests have a higher chance of acceptance.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: controller,
              minLines: 5,
              maxLines: 5,
              maxLength: 280,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          RaisedButton(
            child: const Text('Request Access'),
            onPressed: () => Navigator.of(context).pop<String>(controller.text),
          ),
        ],
      );
    },
  );
}

class ActionMenuCommunities extends StatelessWidget {
  final bool replyConversation;
  final bool reactComment;
  final bool canLeave;
  final bool canJoin;
  final bool canRequestToJoin;
  final bool getInfo;
  final bool canDownloadFile;
  final void Function() reportCallback;
  final void Function(String reaction) reactCallback;
  final void Function(String requestText, bool joining) modifyMembership;
  final void Function() getInfoCallback;
  final void Function() startFileDownload;

  const ActionMenuCommunities({
    Key key,
    @required this.reportCallback,
    this.replyConversation = false,
    this.reactComment = false,
    this.canLeave = false,
    this.canJoin = false,
    this.canRequestToJoin = false,
    this.getInfo = false,
    this.canDownloadFile = false,
    this.getInfoCallback,
    this.reactCallback,
    this.modifyMembership,
    this.startFileDownload,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CommunityActions>(
      icon: Icon(
        Icons.more_horiz,
        color: Theme.of(context).iconTheme.color,
      ),
      onSelected: (selected) async {
        switch (selected) {
          case CommunityActions.REACT_COMMENT:
            final String result = await showReactionDialog(context);
            if (result != null) reactCallback(result);
            break;
          case CommunityActions.REPLY_CONVERSATION:
            print('Focus the TextField for replies');
            break;
          case CommunityActions.REPORT:
            final bool result = await _showReportDialog(context);
            if (result != null && result) reportCallback();
            break;
          case CommunityActions.INFO:
            if (getInfoCallback != null) getInfoCallback();
            break;
          case CommunityActions.REQUEST_ACCESS:
            final String result = await showRequestAccessDialog(context);
            if (result != null && result.isNotEmpty)
              modifyMembership(result, false);
            break;
          case CommunityActions.TOGGLE_MEMBERSHIP:
            if (canJoin) {
              modifyMembership(null, true);
            } else if (canLeave) {
              modifyMembership(null, false);
            }
            break;
          case CommunityActions.DOWNLOAD_FILE:
            startFileDownload();
            break;
          default:
            break;
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: CommunityActions.REPORT,
            child: ListTile(
              title: const Text('Report'),
              trailing: const Icon(Icons.flag),
            ),
          ),
          if (replyConversation)
            PopupMenuItem(
              value: CommunityActions.REPLY_CONVERSATION,
              child: ListTile(
                title: const Text('Reply'),
                trailing: const Icon(Icons.reply),
              ),
            ),
          if (reactComment)
            PopupMenuItem(
              value: CommunityActions.REACT_COMMENT,
              child: ListTile(
                title: const Text('React'),
                trailing: const Icon(Icons.insert_emoticon),
              ),
            ),
          if (canJoin)
            PopupMenuItem(
              value: CommunityActions.TOGGLE_MEMBERSHIP,
              child: ListTile(
                title: const Text('Join'),
                trailing: const Icon(Icons.person_add),
              ),
            ),
          if (canLeave)
            PopupMenuItem(
              value: CommunityActions.TOGGLE_MEMBERSHIP,
              child: ListTile(
                title: const Text('Leave'),
                trailing: const Icon(Icons.exit_to_app),
              ),
            ),
          if (canRequestToJoin)
            PopupMenuItem(
              value: CommunityActions.REQUEST_ACCESS,
              child: ListTile(
                title: const Text('Request Access'),
                trailing: const Icon(Icons.person_add),
              ),
            ),
          if (getInfo)
            PopupMenuItem(
              value: CommunityActions.INFO,
              child: ListTile(
                title: const Text('Info'),
                trailing: const Icon(Icons.info),
              ),
            ),
          if (canDownloadFile)
            PopupMenuItem(
              value: CommunityActions.DOWNLOAD_FILE,
              child: ListTile(
                title: const Text('Save'),
                trailing: const Icon(Icons.file_download),
              ),
            ),
        ];
      },
    );
  }
}
