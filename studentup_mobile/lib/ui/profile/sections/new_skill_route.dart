import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/enum/search_enum.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/new_skill_notifier.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';

class NewSkillRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewSkillNotifier>(
      builder: (_) => NewSkillNotifier(),
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
            'New Skill',
            style: TextStyle(color: CupertinoColors.black),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Consumer<NewSkillNotifier>(
                    builder: (context, notifier, child) {
                      return Column(
                        children: <Widget>[
                          DropdownButtonFormField<String>(
                            hint: Text(notifier.category),
                            onChanged: (value) => notifier.category = value,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            items: [
                              DropdownMenuItem(
                                value: '',
                                child: const Text('Select a category...'),
                              ),
                              for (SearchCategory category
                                  in SearchCategory.values.skip(1))
                                DropdownMenuItem(
                                  value: category
                                      .toString()
                                      .split('.')[1]
                                      .replaceAll('_', ' '),
                                  child: Text(category
                                      .toString()
                                      .split('.')[1]
                                      .replaceAll('_', ' ')),
                                ),
                            ],
                          ),
                          const SizedBox(height: 24.0),
                          TextField(
                            controller: notifier.name,
                            maxLength: 32,
                            maxLengthEnforced: true,
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Skill name',
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          TextField(
                            controller: notifier.description,
                            maxLength: 140,
                            maxLengthEnforced: true,
                            minLines: 10,
                            maxLines: null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your message here...',
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Consumer<NewSkillNotifier>(
                  builder: (context, notifier, child) {
                    if (notifier.isLoading)
                      return Center(child: const CircularProgressIndicator());

                    return StadiumButton(
                      text: 'Send',
                      onPressed: () async {
                        await notifier.send();
                        Navigator.of(context).pop();
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
