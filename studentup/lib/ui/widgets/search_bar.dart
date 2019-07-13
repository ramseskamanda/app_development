import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchBar extends StatefulWidget {
  final FocusNode focusNode;
  SearchBar(this.focusNode);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _typeAheadController;
  SuggestionsBoxController _suggestionsBoxController;

  @override
  void initState() {
    super.initState();
    _typeAheadController = TextEditingController();
    _suggestionsBoxController = SuggestionsBoxController();
  }

  @override
  void dispose() {
    _typeAheadController.dispose();
    _suggestionsBoxController.close();
    super.dispose();
  }

  void focusSearch() => print('focus changed');

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      getImmediateSuggestions: true,
      suggestionsBoxController: _suggestionsBoxController,
      textFieldConfiguration: TextFieldConfiguration(
        controller: _typeAheadController,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(CupertinoIcons.search),
          suffixIcon: _typeAheadController.text.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(CupertinoIcons.clear_circled_solid),
                  onPressed: _typeAheadController.clear,
                ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
          filled: true,
          fillColor: Colors.grey.shade300,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
      ),
      suggestionsCallback: (pattern) {
        if (pattern.isEmpty || pattern == null) return null;
        return Future.delayed(
          Duration(seconds: 1),
          () => <String>[
            pattern,
            pattern,
            pattern,
          ],
        );
      },
      itemBuilder: (context, suggestion) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            title: Text(
              suggestion,
            ),
          ),
        );
      },
      onSuggestionSelected: (suggestion) {
        print(suggestion);
      },
    );
  }
}
