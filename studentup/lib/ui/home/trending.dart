import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:studentup/ui/widgets/section.dart';

class TrendingCompetitions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int _length = 8;
    return Section(
      title: Text(
        'Trending competitions',
        style: Theme.of(context).textTheme.title,
      ),
      onMoreCallback: () => print('See more'),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _length,
          separatorBuilder: (context, index) => const SizedBox(width: 12.0),
          itemBuilder: (context, index) {
            if (index == 0 || index == _length) return SizedBox(width: 16.0);
            return CompetitionCard();
          },
        ),
      ),
    );
  }
}

class CompetitionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    'https://via.placeholder.com/150',
                    errorListener: () =>
                        print('⚠️  [📸 CachedNetworkImageProvider Error]'),
                  ),
                  fit: BoxFit.cover,
                  //colorFilter: ColorFilter.linearToSrgbGamma(),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Market research',
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
