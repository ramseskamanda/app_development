import 'package:rxdart/rxdart.dart';
import 'package:ui_dev0/data_models/community_model.dart';
import 'package:ui_dev0/data_models/community_post_model.dart';
import 'package:ui_dev0/enums/controller_states.dart';
import 'package:ui_dev0/service_models/database/base_database_service.dart';
import 'package:ui_dev0/service_models/locator.dart';
import 'package:ui_dev0/widgets/base_controller.dart';

class CommunitiesController extends BaseController {
  final BaseDatabaseService _databaseService =
      locator.get<BaseDatabaseService>();
  CommunityModel _selected;
  List<CommunityModel> _communities = [];
  Observable<List<CommunityModel>> userCommunities;
  Observable<List<CommunityModel>> userRequests;
  Observable<List<CommunityPostModel>> userPostFeed;

  List<CommunityModel> get communities => _communities;
  CommunityModel get selected => _selected;
  set selected(CommunityModel value) {
    _selected = value;
    notifyListeners();
  }

  Future<void> fetchData() async {
    state = ControllerState.BUSY;
    _communities = await _databaseService.fetchCommunities();
    userCommunities = _databaseService.fetchUserCommunities();
    userRequests = _databaseService.fetchUserCommunityJoinRequests();
    userPostFeed = userCommunities.concatMap<List<CommunityPostModel>>(
        (coms) => _databaseService.fetchPostsFeed(communities: coms ?? []));
    state = ControllerState.IDLE;
  }
}
