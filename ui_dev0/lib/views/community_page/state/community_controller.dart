import 'package:rxdart/rxdart.dart';
import 'package:ui_dev0/data_models/asset_model.dart';
import 'package:ui_dev0/data_models/community_model.dart';
import 'package:ui_dev0/data_models/community_post_model.dart';
import 'package:ui_dev0/service_models/database/base_database_service.dart';
import 'package:ui_dev0/service_models/locator.dart';
import 'package:ui_dev0/widgets/base_controller.dart';

class CommunityController extends BaseController {
  final CommunityModel model;
  final BaseDatabaseService _databaseService =
      locator.get<BaseDatabaseService>();
  Observable<List<CommunityPostModel>> _posts;
  Observable<List<FileAsset>> _files;

  CommunityController(this.model);

  Observable<List<CommunityPostModel>> get posts => _posts;
  Observable<List<FileAsset>> get files => _files;

  void fetchData() {
    _posts = _databaseService.fetchPostsFeed(communities: [model]);
    _files = _databaseService.fetchCommunityFiles(communities: [model]);
  }
}
