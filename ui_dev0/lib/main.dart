import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_dev0/models.dart';

final UserModel user1 = UserModel(
  name: 'Demon Slayer Corps',
  photoUrl:
      'https://res.cloudinary.com/teepublic/image/private/s--chXFqa8z--/t_Preview/b_rgb:191919,c_limit,f_jpg,h_630,q_90,w_630/v1567113870/production/designs/5784407_0.jpg',
);

final ProjectModel testProject1 = ProjectModel(
  creator: user1,
  name: 'Finish the movie',
  description:
      'We need some rookies to get slaughtered and a Hashira so we can finish the movie\'s content:)',
  duration: const Duration(days: 180),
  applicationDeadline: DateTime.now().add(const Duration(days: 10)),
  image: FileAsset(
    downloadUrl: 'https://i.ytimg.com/vi/EjYBQTt5vB0/maxresdefault.jpg',
  ),
  featured: true,
  tags: <String, dynamic>{
    'location': 'Maastricht, Netherlands',
    'type': 'Co-founder needed',
    'workload': '< 5 hours / week',
  },
);

final ProjectModel testProject2 = ProjectModel(
  creator: user1,
  name: 'Finish the movie',
  description:
      'We need some rookies to get slaughtered and a Hashira so we can finish the movie\'s content:)',
  duration: const Duration(days: 180),
  applicationDeadline: DateTime.now().add(const Duration(hours: 2)),
  tags: <String, dynamic>{
    'location': 'Remote',
    'type': 'Co-founder needed',
  },
);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ProjectPreview(project: testProject1),
          ProjectPreview(project: testProject2),
        ],
      ),
    );
  }
}

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

class ProjectTags extends StatelessWidget {
  final Map<String, dynamic> tags;

  const ProjectTags({Key key, this.tags = const {}}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: tags.entries.map(
        (entry) {
          return Chip(
            label: Text(
              entry.value.toString(),
              style: TextStyle(color: CupertinoColors.white),
            ),
            avatar: Text(tagEmojis[entry.key]),
            backgroundColor: tagColors[entry.key],
          );
        },
      ).toList(),
    );
  }
}
