import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NewCompetitionCategories extends StatelessWidget {
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
                      color: CupertinoColors.black,
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
                for (int i = 0; i <= 10; i++)
                  CategoryTile(
                    key: ValueKey(i),
                    title: 'Category #$i',
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatefulWidget {
  final String title;

  const CategoryTile({Key key, @required this.title}) : super(key: key);

  @override
  _CategoryTileState createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  bool _selected;

  void _selectCategory() {
    setState(() {
      _selected = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _selected = false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _selectCategory,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: _selected
              ? Theme.of(context).accentColor
              : CupertinoColors.lightBackgroundGray,
        ),
        child: Center(
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
      ),
    );
  }
}
