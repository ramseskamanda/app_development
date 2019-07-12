import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:studentup/util/env.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  double _getSize(int index) => index == 0
      ? 150.0
      : (index == Environment.searchCategories.length - 2 ? 250 : 200);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            snap: true,
            floating: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            forceElevated: true,
            elevation: 0.0,
            leading: null,
            title: SearchBar(focusNode),
            titleSpacing: 0.0,
            actions: <Widget>[
              if (focusNode.hasFocus) ...[
                FlatButton(
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.button.copyWith(
                        color: CupertinoColors.activeBlue, fontSize: 16.0),
                  ),
                  onPressed: () =>
                      FocusScope.of(context).requestFocus(FocusNode()),
                ),
              ] else ...[
                IconButton(
                  icon: Icon(CupertinoIcons.heart),
                  onPressed: () => print('Saved Profiles'),
                ),
              ],
            ],
          ),
          SliverPadding(padding: EdgeInsets.all(16.0)),
          SliverStaggeredGrid.countBuilder(
            crossAxisCount: 4,
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    'https://via.placeholder.com/150',
                    errorListener: () => print('Error Network Image Provider'),
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  Environment.searchCategories[index],
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
            staggeredTileBuilder: (int index) =>
                StaggeredTile.extent(2, _getSize(index)),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.15,
            ),
          ),
        ],
      ),
    );
  }
}

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
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: TypeAheadField(
        getImmediateSuggestions: true,
        suggestionsBoxController: _suggestionsBoxController,
        textFieldConfiguration: TextFieldConfiguration(
          controller: _typeAheadController,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: const Icon(CupertinoIcons.search),
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
          print('suggestionsCallback');
          if (pattern.isEmpty || pattern == null) return null;
          print('suggestionsCallback 2');
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
      ),
    );
  }
}
