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
  Stream<UserInfoModel> fetchUserInfoStream(String docPath);
  Stream<StartupInfoModel> fetchStartupInfoStream(String docPath);
  Stream<List<SkillsModel>> fetchSkills(String uid);
  Stream<List<EducationModel>> fetchEducation(String uid);
  Stream<List<LaborExeprienceModel>> fetchExperience(String uid);
  Future<List<StartupInfoModel>> fetchStartups(QueryOrder order);
  Future<List<ThinkTanksModel>> fetchThinkTanks(QueryOrder order);
  Future<List<ProjectModel>> fetchProjects(QueryOrder order);
  Future<List<ProjectModel>> fetchProjectsByOwner(String uid,
      {QueryOrder order = QueryOrder.popularity});
  Stream<List<ProjectModel>> fetchOngoingProjects(String uid,
      {QueryOrder order = QueryOrder.popularity});
  Stream<List<ProjectModel>> fetchPastProjects(String uid);
  Stream<List<Comments>> fetchComments(String collectionPath);
  Stream<List<ChatModel>> fetchChatPreviews(String uid);
  Stream<dynamic> fetchMessages(String collectionPath);
  Future<List<UserInfoModel>> fetchRankings({bool monthly = true});
  Future<List<PrizeModel>> fetchPrizesRanking();
  Stream<ProjectSignupModel> fetchProjectSignupById(
      String userId, ProjectModel project);
}

abstract class BaseAPIWriter {
  Future createUser(String uid, UserInfoModel user);
  Future createStartup(String uid, StartupInfoModel startup);
  Future updateProfileInfo(String uid, Map<String, dynamic> data);
  Future postNewThinkTank(ThinkTanksModel model);
  Future removeThinkTank(ThinkTanksModel model);
  Future postNewSkill(SkillsModel model);
  Future postNewEducation(EducationModel model);
  Future postNewExperience(LaborExeprienceModel model);
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
  Future markAsRead({String docId});
}
