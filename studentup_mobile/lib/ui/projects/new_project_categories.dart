import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:studentup_mobile/enum/search_enum.dart';
import 'package:studentup_mobile/notifiers/view_notifiers/project_creation_notifier.dart';

class NewProjectCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 24.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Categories',
                style: Theme.of(context).textTheme.display1.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .display1
                          .color
                          .withAlpha(255),
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(height: 48.0),
            GridView.extent(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: true,
              maxCrossAxisExtent: 150.0,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              children: <Widget>[
                for (int i = 1; i < SearchCategory.values.length; i++)
                  CategoryTile(
                    key: ValueKey(i),
                    category: SearchCategory.values[i],
                  ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final SearchCategory category;

  const CategoryTile({Key key, @required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectCreationNotifier>(
      builder: (context, service, child) {
        bool selected = service.categories.contains(category);
        return InkWell(
          onTap: () => service.toggleCategory(category),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: selected
                  ? Theme.of(context).accentColor
                  : Theme.of(context).disabledColor,
            ),
            child: Center(
              child: Text(
                category.toString().split('.')[1].replaceAll('_', ' '),
                style: Theme.of(context).textTheme.subtitle,
              ),
            ),
          ),
        );
      },
    );
  }
}
