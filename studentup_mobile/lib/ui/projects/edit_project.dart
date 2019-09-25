import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/project_page_notifier.dart';
import 'package:studentup_mobile/ui/widgets/buttons/stadium_button.dart';
import 'package:studentup_mobile/ui/widgets/dialogs/dialogs.dart';

class EditProjectPage extends StatefulWidget {
  final ProjectPageNotifier notifier;
  const EditProjectPage({Key key, @required this.notifier}) : super(key: key);

  @override
  _EditProjectPageState createState() => _EditProjectPageState();
}

class _EditProjectPageState extends State<EditProjectPage> {
  TextEditingController _title;
  TextEditingController _desc;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.notifier.model.title);
    _desc = TextEditingController(text: widget.notifier.model.description);
  }

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.notifier,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: const Text('Edit Project'),
        ),
        body: SafeArea(
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.85,
              child: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Consumer<ProjectPageNotifier>(
                      builder: (context, notifier, child) {
                        return Stack(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                const SizedBox(height: 24.0),
                                TextField(
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  controller: _title,
                                  maxLength: 32,
                                  maxLengthEnforced: true,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Title of your project?',
                                  ),
                                ),
                                const SizedBox(height: 24.0),
                                TextField(
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  controller: _desc,
                                  maxLength: 400,
                                  maxLengthEnforced: true,
                                  minLines: 10,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'What is your project about?',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 16.0,
                    left: 0,
                    right: 0,
                    child: Consumer<ProjectPageNotifier>(
                      builder: (context, notifier, child) {
                        if (notifier.isLoading)
                          return Center(
                              child: const CircularProgressIndicator());
                        return StadiumButton(
                          text: 'Post Project',
                          onPressed: () async {
                            //FIXME: write this better
                            final result = await notifier.editProject(
                                data: {
                              'title': _title.text,
                              'description': _desc.text,
                            }..removeWhere(
                                    (k, v) => v == v.toString().isEmpty));
                            if (result) {
                              Navigator.of(context).pop(result);
                              notifier.fetchData();
                            } else
                              Dialogs.showNetworkErrorDialog(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
