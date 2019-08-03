import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_dev/widgets/custom_sliver_delegate.dart';

class ProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: <Widget>[
            CustomScrollView(
              slivers: <Widget>[
                ImageScrollbaleAppBar(),
                //     Consumer<Object>(
                //       builder: (context, notifier, child) {
                //         if (notifier.isLoading)
                //           return SliverToBoxAdapter(
                //             child: Center(
                //               child: CircularProgressIndicator(),
                //             ),
                //           );
                //         else if (notifier.hasError)
                //           return SliverToBoxAdapter(
                //             child: Center(
                //               child: const Text('An Error Occured!'),
                //             ),
                //           );
                //         return ProjectInformation(
                //           notifier: notifier,
                //         );
                //       },
                //     ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              // child: Consumer<ProjectNotifier>(
              //   builder: (context, notifier, child) {
              //     if (notifier.isLoading) return Container();
              //     if (notifier.isUploading) return CircularProgressIndicator();
              //     return StadiumButton(
              //       text: notifier.userIsOwner
              //           ? 'Select Winners'
              //           : notifier.model.userSignedUp
              //               ? 'Withdraw Application'
              //               : 'Apply',
              //       onPressed: notifier.userIsOwner
              //           ? () => print('object')
              //           : notifier.model.userSignedUp
              //               ? () => notifier.removeApplicant()
              //               : () => notifier.signUp(),
              //     );
              //   },
              //),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageScrollbaleAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: CustomSliverDelegate(
        expandedHeight: MediaQuery.of(context).size.height * 0.3,
        // flexibleSpace: Consumer<ProjectNotifier>(
        //   builder: (context, project, child) {
        //     if (project.isLoading)
        //       return Container(
        //         color: CupertinoColors.lightBackgroundGray,
        //       );
        //     else
        //       return Container(
        //         decoration: BoxDecoration(
        //           image: DecorationImage(
        //             fit: BoxFit.cover,
        //             image: CachedNetworkImageProvider(
        //               //Project.imageUrl,
        //               'https://via.placeholder.com/150',
        //             ),
        //           ),
        //         ),
        //       );
        //   },
        // ),
        stackChildHeight: 96.0,
        leading: FlatButton(
          shape: CircleBorder(),
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
          child: Icon(Icons.arrow_back),
          onPressed: () => print('object'),
        ),
        actions: <Widget>[
          FlatButton(
            shape: CircleBorder(),
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
            child: Icon(Icons.more_horiz),
            onPressed: () => print('object'),
          ),
        ],
      ),
    );
  }
}

// class ProjectInformation extends StatelessWidget {
//   // final ProjectNotifier notifier;

//   const ProjectInformation({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (notifier.isLoading) return Container();
//     return SliverList(
//       delegate: SliverChildListDelegate(
//         <Widget>[
//           Column(
//             children: <Widget>[
//               if (notifier.model.userSignedUp)
//                 Text(
//                   'Signed Up!',
//                   style: Theme.of(context)
//                       .textTheme
//                       .title
//                       .copyWith(color: Theme.of(context).accentColor),
//                 ),
//               const SizedBox(height: 16.0),
//               Text(
//                 notifier.model.creator,
//                 style: Theme.of(context)
//                     .textTheme
//                     .headline
//                     .copyWith(fontWeight: FontWeight.w600),
//               ),
//               const SizedBox(height: 16.0),
//               Text(
//                 notifier.model.title,
//                 softWrap: true,
//                 textAlign: TextAlign.center,
//                 style: Theme.of(context).textTheme.display1.copyWith(
//                     color: CupertinoColors.black, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   Text(
//                     notifier.model.signupsNum.toString() + ' participants',
//                     style: Theme.of(context).textTheme.subtitle,
//                   ),
//                   Text(
//                     notifier.experience.toString() + ' XP to earn',
//                     style: Theme.of(context).textTheme.subtitle,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16.0),
//               FlatButton.icon(
//                 textColor: Theme.of(context).accentColor,
//                 icon: notifier.isDownloading
//                     ? CircularProgressIndicator()
//                     : Icon(Icons.file_download),
//                 label: Text(
//                   'Download attachement',
//                   style: Theme.of(context).textTheme.title,
//                 ),
//                 onPressed: notifier.isDownloading
//                     ? null
//                     : () => notifier.downloadAttachments(),
//               ),
//               const SizedBox(height: 16.0),
//               Text(
//                 notifier.model.description,
//                 textAlign: TextAlign.center,
//                 softWrap: true,
//               ),
//               const SizedBox(height: 16.0),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.9,
//                 child: Column(
//                   children: <Widget>[
//                     Card(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16.0, vertical: 8.0),
//                         child: TextField(
//                           controller: notifier.message,
//                           maxLines: null,
//                           minLines: 5,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: 'Write about your motivation...',
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 24.0),
//                     Center(child: SingleFileAttachment()),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 48.0),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class ProjectActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
