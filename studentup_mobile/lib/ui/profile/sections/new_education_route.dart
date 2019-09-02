import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/enum/degree_type.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/new_education_notifier.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';
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
                            controller: notifier.description,
                            maxLength: 140,
                            maxLengthEnforced: true,
                            minLines: 5,
                            maxLines: null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Study description goes here...',
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
                      return Center(child: const CircularProgressIndicator());

                    return StadiumButton(
                      text: 'Send',
                      onPressed: () async {
                        if (await notifier.send()) Navigator.of(context).pop();
                        if (notifier.hasError) {
                          //TODO: add AlertDialog in case the user presses the button too early
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('An Error Occured.'),
                                content: const Text(
                                    'Unfortunately we weren\'t able to deliver your data to our severs. Please try again.'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: const Text('Done'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                ],
                              );
                            },
                          );
                        }
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
