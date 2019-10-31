import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ui_dev0/archive/models.dart';
import 'package:ui_dev0/archive/project_preview.dart';
import 'package:ui_dev0/archive/ripple.dart';

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

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading;

  @override
  void initState() {
    super.initState();
    _testLoad();
  }

  void _testLoad() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RippleScaffold(
      newRoute: NewPage(),
      appBar: AppBar(),
      body: isLoading
          ? ListViewLoader()
          : ListView(
              children: <Widget>[
                FractionallySizedBox(
                  widthFactor: 0.86,
                  child: CupertinoButton.filled(
                    child: const Text('Reload'),
                    onPressed: () => _testLoad(),
                  ),
                ),
                ProjectPreview(project: testProject1),
                ProjectPreview(project: testProject2),
              ],
            ),
    );
  }
}

class ListViewLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            child: Shimmer.fromColors(
              highlightColor: Colors.white,
              baseColor: Theme.of(context).disabledColor,
              child: SizedBox(
                height: 100,
                child: Container(
                  color: Colors.grey,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NewPage'),
      ),
    );
  }
}
