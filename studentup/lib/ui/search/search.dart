import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:studentup/ui/widgets/search_bar.dart';
import 'package:studentup/util/env.dart';

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: SearchBar(focusNode),
          ),
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
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: StaggeredGridView.countBuilder(
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
        ),
      ),
    );
  }
}
