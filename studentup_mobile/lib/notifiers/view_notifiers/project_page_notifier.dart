import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/models/project_signup_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/firebase_storage.dart';
import 'package:studentup_mobile/services/firestore_service.dart';
import 'package:studentup_mobile/services/locator.dart';

class ProjectPageNotifier extends NetworkNotifier {
  //Model for project page
  ProjectModel model;
  //user sign up docs
  Stream<ProjectSignupModel> _userSignups;
  //potential actions
  TextEditingController _messageController;
  File _file;

  FirestoreReader _firestoreReader;
  FirestoreWriter _firestoreWriter;
  FirebaseStorageService _firebaseStorage;

  ProjectPageNotifier(this.model) {
    _firestoreReader = FirestoreReader();
    _firestoreWriter = FirestoreWriter();
    _firebaseStorage = FirebaseStorageService();
    _messageController = TextEditingController();
    fetchData();
  }

  TextEditingController get message => _messageController;
  String get fileName => _file.path.split('/').last ?? 'No name';
  Stream<ProjectSignupModel> get userSignUpStream => _userSignups;
  bool get canApply =>
      _messageController.text?.isNotEmpty ?? false || _file != null;

  @override
  Future fetchData() async {
    _userSignups = _firestoreReader.fetchProjectSignupById(
      Locator.of<AuthService>().currentUser.uid,
      model,
    );
  }

  @override
  Future onRefresh() async => fetchData();

  Future downloadAttachmentsAndPreview() async {
    try {
      isLoading = true;
      for (String attachment in model.files)
        await _firebaseStorage.download(
          filePath: attachment,
          callback: () => isLoading = false,
          onError: () => error =
              NetworkError(message: 'An error occured during download.'),
        );
    } catch (e) {
      print(e);
      isLoading = false;
    }
  }

  Future signUp() async {
    if (!canApply) return;
    try {
      String _filePath;
      if (_file != null)
        _filePath = await _firebaseStorage.uploadProjectFile(
          _file,
          onError: () =>
              error = NetworkError(message: 'Couldn\'t store your image'),
        );
      final ProjectSignupModel _signupModel = ProjectSignupModel(
        userId: Locator.of<AuthService>().currentUser.uid,
        message: _messageController.text,
        projectId: model.docId,
        timestamps: DateTime.now(),
        file: _filePath,
      );
      await _firestoreWriter.uploadSignUpDocument(
        model: _signupModel,
        project: model,
      );
      _messageController.clear();
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      print(e);
      error = NetworkError(message: '(TRACE)   ::    ${e.runtimeType}');
    }
  }

  Future removeApplicant(String docId) async {
    try {
      await _firestoreWriter.removeApplicant(docId);
    } catch (e) {
      error = NetworkError(message: '(TRACE)   ::    ${e.runtimeType}');
    }
  }

  Future deleteProject() async {
    try {
      await _firestoreWriter.removeProject(id: model.docId);
    } catch (e) {
      error = NetworkError(message: 'Your request failed. Please try again.');
    }
  }
}
