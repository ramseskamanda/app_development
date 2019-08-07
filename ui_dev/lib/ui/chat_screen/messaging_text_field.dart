import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_dev/services/messaging_service.dart';

class MessagingTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: 290),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          top: BorderSide(
            color: CupertinoColors.extraLightBackgroundGray,
            width: 0.5,
          ),
        ),
      ),
      child: Consumer<MessagingService>(
        builder: (context, service, child) {
          return Row(
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: SizedBox(width: 24.0),
              ),
              // Edit text
              Flexible(
                child: Container(
                  child: TextField(
                    controller: service.controller,
                    onSubmitted: (value) => service.sendMessage(),
                    onChanged: (value) {
                      if (value.length > 0) service.canSend = true;
                      if (value.length > 1) return;
                      if (value.length == 0) service.canSend = false;
                    },
                    textInputAction: TextInputAction.send,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Type your message...',
                    ),
                    focusNode: service.focusNode,
                  ),
                ),
              ),

              // Button send message
              Material(
                color: Colors.transparent,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: service.canSend ? service.sendMessage : null,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
