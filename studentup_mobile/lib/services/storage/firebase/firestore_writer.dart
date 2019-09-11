import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/models/education_model.dart';
import 'package:studentup_mobile/models/labor_experience_model.dart';
import 'package:studentup_mobile/models/message_model.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/models/project_signup_model.dart';
import 'package:studentup_mobile/models/skills_model.dart';
import 'package:studentup_mobile/models/startup_info_model.dart';
import 'package:studentup_mobile/models/think_tank_model.dart';
import 'package:studentup_mobile/models/user_info_model.dart';
import 'package:studentup_mobile/services/authentication/auth_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/storage/base_api.dart';
import 'package:studentup_mobile/services/storage/firebase/env.dart';

final Firestore _firestore = Firestore.instance;

class FirestoreWriter implements BaseAPIWriter {
  @override
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

  @override
  Future createStartup(String uid, StartupInfoModel startup) async {
    try {
      await _firestore
          .collection(startupCollection)
          .document(uid)
          .setData(startup.toJson());
    } catch (e) {
      throw e;
    }
  }

  @override
  Future updateProfileInfo(String uid, Map<String, dynamic> data) async {
    DocumentReference doc =
        _firestore.collection(studentsCollection).document(uid);

    Map result = await _firestore.runTransaction(
      (transaction) async {
        await transaction.update(doc, data);
      },
    );
    print(result);
  }

  @override
  Future postNewThinkTank(ThinkTanksModel model) async {
    await _firestore.collection(thinkTanksCollection).add(model.toJson());
  }

  @override
  Future removeThinkTank(ThinkTanksModel model) async {
    await _firestore
        .collection(thinkTanksCollection)
        .document(model.docId)
        .delete();
  }

  @override
  Future postNewSkill(SkillsModel model) async =>
      await _firestore.collection(skillsCollection).add(model.toJson());

  @override
  Future postNewEducation(EducationModel model) async =>
      await _firestore.collection(educationCollection).add(model.toJson());

  @override
  Future postNewExperience(LaborExeprienceModel model) async =>
      await _firestore.collection(experienceCollection).add(model.toJson());

  @override
  Future postNewTeamMember({
    UserInfoModel model,
    String docPath,
  }) async {
    DocumentReference doc = _firestore.document(docPath);
    await doc.updateData({
      'team.${model.docId}': Preview(
        givenName: model.givenName,
        imageUrl: model.mediaRef,
        uid: model.docId,
      ).toJson(),
    });
  }

  @override
  Future removeTeamMember({
    Preview model,
    String docPath,
  }) async {
    DocumentReference doc = _firestore.document(docPath);
    await doc.updateData({'team.${model.uid}': FieldValue.delete()});
  }

  @override
  Future postComment({Comments model, String collectionPath}) async {
    CollectionReference collection = _firestore.collection(collectionPath);
    return await collection.add(model.toJson());
  }

  @override
  Future removeVoter({
    String collectionPath,
    String docId,
    String uid,
    bool upvote,
  }) async {
    CollectionReference collection = _firestore.collection(collectionPath);

    await collection.document(docId).updateData(
          upvote
              ? {
                  'upvotes': FieldValue.arrayRemove([uid])
                }
              : {
                  'downvotes': FieldValue.arrayRemove([uid])
                },
        );
  }

  @override
  Future addVoter({
    String collectionPath,
    String docId,
    String uid,
    bool upvote,
  }) async {
    CollectionReference collection = _firestore.collection(collectionPath);
    await collection.document(docId).updateData(
          upvote
              ? {
                  'upvotes': FieldValue.arrayUnion([uid])
                }
              : {
                  'downvotes': FieldValue.arrayUnion([uid])
                },
        );
  }

  @override
  Future createChatRoom({
    ChatModel chat,
    MessageModel initialMessage,
  }) async {
    //TODO: change this
    // QuerySnapshot preExistingDoc =
    //     await _firestore.collection(chatsCollection).where('').getDocuments();
    DocumentReference newDoc =
        await _firestore.collection(chatsCollection).add(chat.toJson());
    final CollectionReference subcollectionRef = newDoc.collection('messages');
    await subcollectionRef.add(initialMessage.toJson());
    DocumentSnapshot snap = await newDoc.get();
    return ChatModel.fromDoc(snap);
  }

  @override
  Future uploadMessage({
    MessageModel messageModel,
    String collectionPath,
  }) async {
    CollectionReference collection = _firestore.collection(collectionPath);

    await collection.add(messageModel.toJson());
  }

  @override
  Future removeConversation({String collectionPath}) async {
    CollectionReference collection = _firestore.collection(collectionPath);
    return await collection.parent().delete();
  }

  @override
  Future uploadProjectInformation({ProjectModel model}) async =>
      await _firestore.collection(projectCollection).add(model.toJson());

  @override
  Future uploadSignUpDocument({
    ProjectSignupModel model,
    ProjectModel project,
  }) async =>
      await _firestore
          .collection(projectCollection)
          .document(project.docId)
          .collection('applications')
          .document(Locator.of<AuthService>().currentUser.uid)
          .setData(model.toJson());

  @override
  Future removeApplicant(String projectId) async => await _firestore
      .collection(projectCollection)
      .document(projectId)
      .collection('applications')
      .document(Locator.of<AuthService>().currentUser.uid)
      .delete();

  @override
  Future removeProject({String id}) async =>
      await _firestore.collection(projectCollection).document(id).delete();

  @override
  Future markAsRead({String docId}) async =>
      await _firestore.collection(chatsCollection).document(docId).updateData({
        'latest_message.seenAt': FieldValue.serverTimestamp(),
      });

  @override
  Future updateNotificationTokens({
    String docPath,
    String token,
    bool remove = false,
  }) async {
    DocumentReference doc = _firestore.document(docPath);
    _firestore.runTransaction((transaction) async {
      final snap = await transaction.get(doc);
      if (!snap.exists) throw 'Document does not exist.';
      final List<String> _tokens = snap?.data['tokens']?.cast<String>() ?? [];
      if (((!remove && !_tokens.contains(token)) ||
          (remove && _tokens.contains(token)))) {
        print('FIRESTORE ==> UPDATING TOKEN REGISTRY...');
        print('FIRESTORE ==> CURRENT REGISTRY: $_tokens');
        print('FIRESTORE ==> ADDING KEY: $token');
        return await transaction.update(doc, {
          'tokens': remove
              ? FieldValue.arrayRemove([token])
              : FieldValue.arrayUnion([token]),
        });
      }
    });
  }
}
