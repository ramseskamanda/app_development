import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:studentup/routers/search_router.dart';
import 'package:studentup/util/env.dart';

class SearchCard extends StatelessWidget {
  final int index;

  const SearchCard({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String categoryName = Environment.searchCategories[index];
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        SearchRouter.category,
        arguments: categoryName,
      ),
      child: Container(
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
            categoryName,
            style:
                Theme.of(context).textTheme.title.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
