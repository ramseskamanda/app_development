import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/enum/degree_type.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/new_education_notifier.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';
import 'package:studentup_mobile/ui/widgets/dialogs/dialogs.dart';
import 'package:studentup_mobile/ui/widgets/text_fields/date_picker_form_field.dart';

class NewEducationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewEducationNotifier>(
      builder: (_) => NewEducationNotifier(),
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
            'New Education Profile',
            style: TextStyle(color: CupertinoColors.black),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Consumer<NewEducationNotifier>(
                    builder: (context, notifier, child) {
                      return Column(
                        children: <Widget>[
                          TextField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: notifier.name,
                            maxLength: 32,
                            maxLengthEnforced: true,
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'University',
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          DropdownButtonFormField<String>(
                            hint: Text(notifier.category),
                            onChanged: (value) => notifier.category = value,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            items: [
                              DropdownMenuItem(
                                value: 'Select a degree...',
                                child: const Text('Select a degree...'),
                              ),
                              for (DegreeType degree in DegreeType.values)
                                DropdownMenuItem(
                                  value: degree.toString().split('.')[1],
                                  child: Text(degree.toString().split('.')[1]),
                                ),
                            ],
                          ),
                          const SizedBox(height: 24.0),
                          TextField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: notifier.faculty,
                            maxLength: 32,
                            maxLengthEnforced: true,
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Faculty',
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          TextField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: notifier.description,
                            maxLength: 48,
                            maxLengthEnforced: true,
                            minLines: 3,
                            maxLines: null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Major',
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
                            controller: notifier.gradDateController,
                            hintText: '(Expected) Graduation Date',
                            onConfirm: (value, indices) =>
                                notifier.gradDate = value,
                          ),
                          const SizedBox(height: 24.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text('Show as main profile university'),
                              Switch.adaptive(
                                value: notifier.editProfile,
                                onChanged: (value) =>
                                    notifier.editProfile = value,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Consumer<NewEducationNotifier>(
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
