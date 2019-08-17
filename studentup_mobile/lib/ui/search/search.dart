// // import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:provider/provider.dart';
// import 'package:studentup_mobile/enum/search_enum.dart';
// import 'package:studentup_mobile/notifiers/view_notifiers/general_search_notifier.dart';
// import 'package:studentup_mobile/ui/search/search_category.dart';
// import 'package:studentup_mobile/ui/search/search_screen_delegate.dart';

// class SearchTab extends StatefulWidget {
//   @override
//   _SearchTabState createState() => _SearchTabState();
// }

// class _SearchTabState extends State<SearchTab> {
//   // double _getSize(int index) => index == 0
//   //     ? 150.0
//   //     : (index == SearchCategory.values.length - 2 ? 250 : 200);

//   Future<void> _onSearch(BuildContext context) async {
//     String result = await showSearch(
//       context: context,
//       delegate: SearchScreenDelegate(
//         Provider.of<GeneralSearchNotifier>(context),
//       ),
//     );
//     print(result);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<GeneralSearchNotifier>(
//       builder: (_) => GeneralSearchNotifier(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Search Engine'),
//           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//           elevation: 0.0,
//           centerTitle: true,
//           leading: IconButton(
//             icon: Icon(Icons.menu),
//             onPressed: () {},
//           ),
//           actions: <Widget>[
//             Builder(builder: (context) {
//               return IconButton(
//                 icon: const Icon(CupertinoIcons.search),
//                 iconSize: 28.0,
//                 onPressed: () => _onSearch(context),
//               );
//             }),
//             IconButton(
//               icon: Icon(CupertinoIcons.heart),
//               onPressed: () => print('Go To Saved Profiles'),
//             ),
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(4.0),
//           child: GridView.count(
//             crossAxisCount: 2,
//             mainAxisSpacing: 4.0,
//             crossAxisSpacing: 4.0,
//             children: <Widget>[
//               for (int i = 0; i < SearchCategory.values.length; i++)
//                 SearchCard(index: i),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // StaggeredGridView.countBuilder(
// //             crossAxisCount: 4,
// //             itemCount: SearchCategory.values.length,
// //             itemBuilder: (BuildContext context, int index) =>
// //                 SearchCard(index: index),
// //             staggeredTileBuilder: (int index) =>
// //                 StaggeredTile.extent(2, _getSize(index)),
// //             mainAxisSpacing: 4.0,
// //             crossAxisSpacing: 4.0,
// //           ),

// class SearchCard extends StatelessWidget {
//   final int index;

//   const SearchCard({Key key, this.index}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     String s =
//         SearchCategory.values[index].toString().split('.')[1].toLowerCase();
//     final String categoryName = '${s[0].toUpperCase()}${s.substring(1)}';

//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(
//           CupertinoPageRoute(
//             builder: (context) =>
//                 CategoryScreen(category: SearchCategory.values[index]),
//           ),
//         );
//       },
//       child: Stack(
//         children: <Widget>[
//           // CachedNetworkImage(
//           //   imageUrl: 'https://via.placeholder.com/150',
//           //   placeholder: (_, url) => Container(
//           //     color: CupertinoColors.lightBackgroundGray,
//           //   ),
//           //   errorWidget: (_, __, error) => Container(
//           //     color: CupertinoColors.lightBackgroundGray,
//           //     child: Center(child: const Icon(Icons.error)),
//           //   ),
//           //   imageBuilder: (_, image) {
//           //     return Container(
//           //       decoration: BoxDecoration(
//           //         borderRadius: BorderRadius.circular(8.0),
//           //         image: DecorationImage(
//           //           fit: BoxFit.cover,
//           //           image: image,
//           //         ),
//           //       ),
//           //     );
//           //   },
//           // ),
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8.0),
//               color: CupertinoColors.darkBackgroundGray.withOpacity(0.44),
//             ),
//           ),
//           Center(
//             child: Text(
//               categoryName.toString(),
//               style: Theme.of(context)
//                   .textTheme
//                   .title
//                   .copyWith(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
