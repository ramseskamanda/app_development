import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/new_experience_notifier.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';
import 'package:studentup_mobile/ui/widgets/dialogs/dialogs.dart';
import 'package:studentup_mobile/ui/widgets/text_fields/date_picker_form_field.dart';

class NewExperienceRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewExperienceNotifier>(
      builder: (_) => NewExperienceNotifier(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'New Experience Profile',
            style: TextStyle(color: CupertinoColors.black),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Consumer<NewExperienceNotifier>(
                    builder: (context, notifier, child) {
                      return Column(
                        children: <Widget>[
                          TextField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: notifier.company,
                            maxLength: 32,
                            maxLengthEnforced: true,
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Company/Organization/Workplace',
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          TextField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: notifier.position,
                            maxLength: 32,
                            maxLengthEnforced: true,
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Position',
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          InlineDatePickerFormField(
                            controller: notifier.startDateController,
                            hintText: 'Start Date',
                            onConfirm: (value, indices) =>
                                notifier.startDate = value,
                          ),
                          const SizedBox(height: 24.0),
                          InlineDatePickerFormField(
                            allowBlank: true,
                            controller: notifier.gradDateController,
                            hintText: 'End Date (Leave blank for ongoing)',
                            onConfirm: (value, indices) =>
                                notifier.endDate = value,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Consumer<NewExperienceNotifier>(
                  builder: (context, notifier, child) {
                    if (notifier.isLoading)
                      return const CircularProgressIndicator();

                    if (notifier.hasError)
                      Dialogs.showNetworkErrorDialog(context);

                    return StadiumButton(
                      text: 'Send',
                      onPressed: () async {
                        final bool result = await notifier.sendData();
                        if (result) Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
