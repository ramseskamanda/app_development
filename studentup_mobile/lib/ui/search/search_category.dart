import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentup_mobile/enum/search_enum.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/search/base_search_api.dart';
import 'package:studentup_mobile/ui/search/search_screen_delegate.dart';
import 'package:studentup_mobile/ui/search/search_user_profile_card.dart';
import 'package:studentup_mobile/ui/widgets/dialogs/dialogs.dart';
import 'package:studentup_mobile/ui/widgets/utility/network_sensitive_widget.dart';

class CategoryScreen extends StatefulWidget {
  final SearchCategory category;

  const CategoryScreen({Key key, @required this.category}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Completer<List<UserInfoModel>> completer;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    completer = Completer()
      ..complete(Locator.of<BaseSearchAPI>()
          .searchUsersWithFacets(category: widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(toString(widget.category)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(CupertinoIcons.search),
            iconSize: 28.0,
            onPressed: () async {
              await showSearch(
                context: context,
                delegate: SearchScreenDelegate(widget.category),
              );
            },
          ),
          IconButton(
            icon: Icon(CupertinoIcons.heart),
            onPressed: () => Dialogs.showComingSoon(context),
          ),
        ],
      ),
      body: NetworkSensitive(
        callback: _fetchData,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: FutureBuilder<List<UserInfoModel>>(
            future: completer.future,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                if (snapshot.hasError)
                  return Center(child: Text(snapshot.error.toString()));
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.data.isEmpty)
                return Center(
                    child: Text(
                        'No results found for: ${toString(widget.category)}'));
              return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemBuilder: (context, index) =>
                    UserProfileCard(model: snapshot.data[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}
