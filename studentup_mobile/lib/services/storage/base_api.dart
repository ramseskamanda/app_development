import 'package:rxdart/rxdart.dart';
import 'package:studentup_mobile/enum/query_order.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/models/education_model.dart';
import 'package:studentup_mobile/models/labor_experience_model.dart';
import 'package:studentup_mobile/models/message_model.dart';
import 'package:studentup_mobile/models/prize_model.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/models/project_signup_model.dart';
import 'package:studentup_mobile/models/skills_model.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/think_tank_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';

abstract class BaseAPIReader {
  Future<Map<dynamic, bool>> findUserDocument(String uid);
  Future<UserInfoModel> fetchUser(String uid);
  Future<List<UserInfoModel>> fetchAllUsers(List<String> users);
  Observable<UserInfoModel> fetchUserInfoStream(String docPath);
  Future<List<Preview>> fetchAllUserAccounts(List<String> users);
  Observable<StartupInfoModel> fetchStartupInfoStream(String docPath);
  Observable<List<SkillsModel>> fetchSkills(String uid);
  Observable<List<EducationModel>> fetchEducation(String uid);
  Observable<List<LaborExeprienceModel>> fetchExperience(String uid);
  Future<List<StartupInfoModel>> fetchStartups(QueryOrder order);
  Future<List<ThinkTankModel>> fetchThinkTanks(QueryOrder order);
  Observable<ThinkTankModel> fetchThinkTankStream(String docId);
  Observable<List<ThinkTankModel>> fetchThinkTanksByOwnerStream(String uid,
      {QueryOrder order = QueryOrder.newest});
  Future<List<ProjectModel>> fetchProjects(QueryOrder order);
  Future<ProjectModel> fetchProjectInfo(String docId);
  Future<List<ProjectModel>> fetchProjectsByOwner(String uid,
      {QueryOrder order = QueryOrder.popularity});
  Observable<List<ProjectModel>> fetchProjectsByOwnerStream(String uid,
      {QueryOrder order = QueryOrder.popularity});
  Observable<List<ProjectModel>> fetchOngoingProjects(String uid,
      {QueryOrder order = QueryOrder.popularity});
  Observable<List<ProjectModel>> fetchPastProjects(String uid);
  Observable<List<Comments>> fetchComments(String collectionPath);
  Observable<List<ChatModel>> fetchChatPreviews(String uid);
  Observable<dynamic> fetchMessages(String collectionPath);
  Future<List<UserInfoModel>> fetchRankings({bool monthly = true});
  Future<List<PrizeModel>> fetchPrizesRanking();
  Observable<List<ProjectSignupModel>> fetchProjectSignups(
      ProjectModel project);
  Observable<ProjectSignupModel> fetchProjectSignupById(
      String userId, ProjectModel project);
}

abstract class BaseAPIWriter {
  Future createUser(String uid, UserInfoModel user);
  Future createStartup(String uid, StartupInfoModel startup);
  Future updateNotificationTokens(
      {String docPath, String token, bool remove = false});
  Future updateProfileInfo({String docPath, Map<String, dynamic> data});
  Future postNewThinkTank(ThinkTankModel model);
  Future editThinkTank({ThinkTankModel model, Map<String, dynamic> data});
  Future removeThinkTank(ThinkTankModel model);
  Future removeComment({ThinkTankModel tank, Comments comment});
  Future postNewSkill(SkillsModel model);
  Future removeSkill(SkillsModel model);
  Future postNewEducation(EducationModel model);
  Future removeEducation(EducationModel model);
  Future editProfileEducation(String university);
  Future postNewExperience(LaborExeprienceModel model);
  Future removeExperience(LaborExeprienceModel model);
  Future postNewTeamMember({UserInfoModel model, String docPath});
  Future removeTeamMember({Preview model, String docPath});
  Future postComment({Comments model, String collectionPath});
  Future removeVoter(
      {String collectionPath, String docId, String uid, bool upvote});
  Future addVoter(
      {String collectionPath, String docId, String uid, bool upvote});
  Future createChatRoom({ChatModel chat, MessageModel initialMessage});
  Future uploadMessage({MessageModel messageModel, String collectionPath});
  Future removeConversation({String collectionPath});
  Future uploadProjectInformation({ProjectModel model});
  Future uploadSignUpDocument({ProjectSignupModel model, ProjectModel project});
  Future removeApplicant(String projectId);
  Future removeProject({String id});
  Future editProjectInfo(ProjectModel model, Map<String, dynamic> data);
  Future markAsRead({String docId});
}
