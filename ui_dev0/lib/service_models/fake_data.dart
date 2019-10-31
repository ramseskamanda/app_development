import 'package:ui_dev0/data_models/asset_model.dart';
import 'package:ui_dev0/data_models/community_model.dart';
import 'package:ui_dev0/data_models/community_post_model.dart';
import 'package:ui_dev0/data_models/user_model.dart';

class FakeData {
  static final UserModel testUser1 = UserModel(
    name: 'Fake Person One',
    adminRoles: [],
    photoUrl: 'https://randomuser.me/api/portraits/lego/4.jpg',
  );
  static final UserModel testUser2 = UserModel(
    name: 'Second Person Two',
    adminRoles: ['1', '2'],
    photoUrl: 'https://randomuser.me/api/portraits/lego/1.jpg',
  );
  static final UserModel currentUser = testUser1;
  static final List<CommunityModel> listCommunities = [
    CommunityModel(
      id: '1',
      name: 'Company 1',
      public: true,
      creator: testUser1,
      description: 'faker.lorem.sentence()',
      members: [
        testUser2,
      ],
      memberCount: 2,
      posts: [
        CommunityPostModel(
          id: '1',
          communityId: '1',
          communityName: 'Company 1',
          originalPoster: testUser1,
          content: 'faker.lorem.sentence()',
          postedAt: DateTime.now().subtract(const Duration(minutes: 2)),
        ),
        CommunityPostModel(
          id: '2',
          communityId: '1',
          communityName: 'Company 1',
          originalPoster: testUser1,
          content: 'faker.lorem.sentence()',
          postedAt: DateTime.now(),
        ),
      ],
    ),
    CommunityModel(
      id: '2',
      name: '2 Companies too',
      public: false,
      creator: testUser2,
      description: 'faker.lorem.sentence()',
      posts: [
        CommunityPostModel(
          id: '1',
          communityId: '2',
          communityName: '2 Companies too',
          originalPoster: testUser2,
          content: "Yo!",
          postedAt: DateTime.now().subtract(const Duration(minutes: 1)),
          files: [
            FileAsset(
              id: '0',
              fileName: 'image test',
              downloadUrl: 'https://source.unsplash.com/random/200x200',
              fileType: 'image',
              postedAt: DateTime.now().subtract(const Duration(minutes: 1)),
            ),
            FileAsset(
              id: '1',
              fileName: 'image test',
              downloadUrl: 'https://source.unsplash.com/random/250x250',
              fileType: 'image',
              postedAt: DateTime.now().subtract(const Duration(minutes: 1)),
            ),
            FileAsset(
              id: '2',
              fileName: 'image test',
              downloadUrl: 'https://source.unsplash.com/random/300x300',
              fileType: 'image',
              postedAt: DateTime.now().subtract(const Duration(minutes: 1)),
            ),
            FileAsset(
              id: '3',
              fileName: 'image test',
              downloadUrl: 'https://source.unsplash.com/random/200x200',
              fileType: 'image',
              postedAt: DateTime.now().subtract(const Duration(minutes: 1)),
            ),
            FileAsset(
              id: '4',
              fileName: 'sample.pdf',
              downloadUrl: 'http://www.africau.edu/images/default/sample.pdf',
              postedAt: DateTime.now().subtract(const Duration(minutes: 1)),
            ),
          ],
          replyCount: 1,
          replies: [
            CommunityPostModel(
              id: '3',
              communityId: '2',
              communityName: '2 Companies too',
              originalPoster: testUser1,
              content: "Yo",
              postedAt: DateTime.now(),
              replyGeneration: 1,
            ),
            CommunityPostModel(
              id: '4',
              communityId: '2',
              communityName: '2 Companies too',
              originalPoster: testUser2,
              content: "How are you liking my hat?",
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
          id: '2',
          communityId: '2',
          communityName: '2 Companies too',
          originalPoster: testUser2,
          content: "The sea is so nice today!",
          postedAt: DateTime.now().add(const Duration(minutes: 1)),
        ),
      ],
    ),
  ];
}
