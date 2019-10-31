import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_dev0/archive/models.dart';
import 'package:ui_dev0/archive/project_tags.dart';

class ProjectPreview extends StatelessWidget {
  final ProjectModel project;

  const ProjectPreview({
    Key key,
    @required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CachedNetworkImage(
              imageUrl: project.creator.photoUrl,
              imageBuilder: (context, image) {
                return CircleAvatar(backgroundImage: image);
              },
            ),
            title: Text(project.creator.name),
            trailing: project.featured
                ? Chip(
                    elevation: 4.0,
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Theme.of(context).scaffoldBackgroundColor
                            : Theme.of(context).accentColor,
                    label: Text(
                      'Featured',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? CupertinoColors.activeGreen
                            : CupertinoColors.white,
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 8.0),
          FractionallySizedBox(
            widthFactor: 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${project.name} - ${project.stringDuration}',
                  style: Theme.of(context).textTheme.title,
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Application deadline: ${project.stringDeadline}',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle
                      .apply(color: Theme.of(context).textTheme.caption.color),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 8.0),
                ProjectTags(tags: project.tags),
                const SizedBox(height: 16.0),
                Text(
                  project.description,
                  style: Theme.of(context).textTheme.body2,
                ),
                const SizedBox(height: 16.0),
                if (project.image != null) ...[
                  CachedNetworkImage(
                    imageUrl: project.image.downloadUrl,
                    imageBuilder: (context, image) => Image(
                      image: image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
