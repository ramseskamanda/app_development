import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:ui_development/models.dart';
import 'package:uuid/uuid.dart';

const faker = Faker();

final List<Widget> listTileWidgets = <Widget>[
  ListTile(
    title: Text('The Castro Theater',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('429 Castro St'),
    leading: Icon(
      Icons.theaters,
      color: Colors.blue[500],
    ),
  ),
  ListTile(
    title: Text('Alamo Drafthouse Cinema',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('2550 Mission St'),
    leading: Icon(
      Icons.theaters,
      color: Colors.blue[500],
    ),
  ),
  ListTile(
    title: Text('Roxie Theater',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('3117 16th St'),
    leading: Icon(
      Icons.theaters,
      color: Colors.blue[500],
    ),
  ),
  ListTile(
    title: Text('United Artists Stonestown Twin',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('501 Buckingham Way'),
    leading: Icon(
      Icons.theaters,
      color: Colors.blue[500],
    ),
  ),
  ListTile(
    title: Text('AMC Metreon 16',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('135 4th St #3000'),
    leading: Icon(
      Icons.theaters,
      color: Colors.blue[500],
    ),
  ),
  Divider(),
  ListTile(
    title: Text('K\'s Kitchen',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('757 Monterey Blvd'),
    leading: Icon(
      Icons.restaurant,
      color: Colors.blue[500],
    ),
  ),
  ListTile(
    title: Text('Emmy\'s Restaurant',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('1923 Ocean Ave'),
    leading: Icon(
      Icons.restaurant,
      color: Colors.blue[500],
    ),
  ),
  ListTile(
    title: Text('Chaiya Thai Restaurant',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('272 Claremont Blvd'),
    leading: Icon(
      Icons.restaurant,
      color: Colors.blue[500],
    ),
  ),
  ListTile(
    title: Text('La Ciccia',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
    subtitle: Text('291 30th St'),
    leading: Icon(
      Icons.restaurant,
      color: Colors.blue[500],
    ),
  ),
];
const CommunityModel defaultCommunity = CommunityModel(
  id: '0',
  name: 'All Communities',
  creator: null,
  public: null,
  description: 'All your communities',
);
final UserModel testUser1 = UserModel(
  name: faker.person.name(), //'Monkey D. Luffy',
  adminRoles: [],
  photoUrl: 'https://randomuser.me/api/portraits/lego/4.jpg',
  //'https://res.cloudinary.com/teepublic/image/private/s--vnhpoh0D--/t_Preview/b_rgb:484849,c_limit,f_jpg,h_630,q_90,w_630/v1555139745/production/designs/4629733_0.jpg',
);
final UserModel testUser2 = UserModel(
  name: faker.person.name(), //'Shanks LeRoux',
  adminRoles: ['1', '2'],
  photoUrl: 'https://randomuser.me/api/portraits/lego/1.jpg',
  //'https://media1.tenor.com/images/662e705815b4ea0d0c5939d07aec3e33/tenor.gif?itemid=12003987',
);
final UserModel currentUser = testUser1;
final List<CommunityModel> listCommunities = [
  CommunityModel(
    id: '1',
    name: faker.company.name(),
    // 'Straw Hat Pirates',
    public: true,
    creator: testUser1,
    description: faker.lorem.sentence(),
    // 'A crew of friendly pirates.',
    members: [
      testUser2,
    ],
    memberCount: 2,
    posts: [
      CommunityPostModel(
        originalPoster: testUser1,
        content: faker.lorem.sentence(),
        // "I'm going to become the King of Pirates!",
        postedAt: DateTime.now().subtract(const Duration(minutes: 2)),
      ),
      CommunityPostModel(
        originalPoster: testUser1,
        content: faker.lorem.sentence(),
        // "I just met a really cool swordsman!",
        postedAt: DateTime.now(),
      ),
    ],
  ),
  CommunityModel(
    id: '2',
    name: faker.company.name(),
    // 'Red Hair Pirates',
    public: false,
    creator: testUser2,
    description: faker.lorem.sentence(),
    //'A cool crew of red haired pirates.',
    posts: [
      CommunityPostModel(
        originalPoster: testUser2,
        content: "Yo!",
        postedAt: DateTime.now().subtract(const Duration(minutes: 1)),
        files: [
          FileAsset(
            id: Uuid().v4(),
            fileName: 'image test',
            downloadUrl: 'https://source.unsplash.com/random/200x200',
            //'http://24.media.tumblr.com/tumblr_mbji56MFHl1rffshko1_500.gif',
            fileType: 'image',
          ),
          FileAsset(
            id: Uuid().v4(),
            fileName: 'image test',
            downloadUrl: 'https://source.unsplash.com/random/250x250',
            //'http://24.media.tumblr.com/tumblr_mbji56MFHl1rffshko1_500.gif',
            fileType: 'image',
          ),
          FileAsset(
            id: Uuid().v4(),
            fileName: 'image test',
            downloadUrl: 'https://source.unsplash.com/random/300x300',
            // 'http://24.media.tumblr.com/tumblr_mbji56MFHl1rffshko1_500.gif',
            fileType: 'image',
          ),
          FileAsset(
            id: Uuid().v4(),
            fileName: 'image test',
            downloadUrl: 'https://source.unsplash.com/random/200x200',
            // 'http://24.media.tumblr.com/tumblr_mbji56MFHl1rffshko1_500.gif',
            fileType: 'image',
          ),
          FileAsset(
            id: Uuid().v4(),
            fileName: 'sample.pdf',
            downloadUrl: 'http://www.africau.edu/images/default/sample.pdf',
          ),
        ],
        replyCount: 1,
        replies: [
          CommunityPostModel(
            originalPoster: testUser1,
            content: "Yo ${faker.person.name()}!",
            postedAt: DateTime.now(),
            replyGeneration: 1,
          ),
          CommunityPostModel(
            originalPoster: testUser2,
            content: "${faker.person.name()}! How are you liking my hat?",
            postedAt: DateTime.now(),
            replyGeneration: 1,
          ),
        ],
        reactions: {
          'thumbsup': 1,
          null: 34,
        },
      ),
      CommunityPostModel(
        originalPoster: testUser2,
        content: "The sea is so nice today!",
        postedAt: DateTime.now().add(const Duration(minutes: 1)),
      ),
    ],
  ),
];
