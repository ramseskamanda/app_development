import 'package:rxdart/rxdart.dart';
import 'package:ui_dev0/data_models/community_post_model.dart';
import 'package:ui_dev0/service_models/database/base_database_service.dart';
import 'package:ui_dev0/service_models/locator.dart';
import 'package:ui_dev0/widgets/base_controller.dart';

class DiscussionController extends BaseController {
  final CommunityPostModel root;
  final BaseDatabaseService _databaseService =
      locator.get<BaseDatabaseService>();
  Observable<List<CommunityPostModel>> _comments;

  DiscussionController(this.root);

  Observable<List<CommunityPostModel>> get comments => _comments;

  void fetchData() {
    _comments = _databaseService.fetchConversations(conversationIds: [root.id]);
  }
}
