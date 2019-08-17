import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentup_mobile/models/user_info_model.dart';

final Firestore _firestore = Firestore.instance;

const String studentsCollection = 'students';
const String educationCollection = 'education_history';
const String experienceCollection = 'laboral_experiences';
const String startupCollection = 'startups';
const String prizesCollection = 'prizes';
const String projectCollection = 'projects';
const String projectSignupsCollection = 'project_signups';
const String thinkTanksCollection = 'think_tanks';
const String skillsCollection = 'skills';
const String chatsCollection = 'chats';
const String messagesCollection = 'messages';

class FirestoreReader {}

class FirestoreWriter {
  Future createUser(String uid, UserInfoModel user) async {
    try {
      await _firestore
          .collection(studentsCollection)
          .document(uid)
          .setData(user.toJson());
    } catch (e) {
      throw e;
    }
  }
}
