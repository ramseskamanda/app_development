import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:ui_dev/models/project_model.dart';
import 'package:ui_dev/models/project_signup_model.dart';
import 'package:ui_dev/notifiers/error_handling/network_error.dart';
import 'package:ui_dev/notifiers/view_notifiers/view_notifier.dart';
import 'package:ui_dev/services/firebase/firestore.dart';
import 'package:ui_dev/services/firebase/storage.dart';
import 'package:ui_dev/test_data.dart';

class ProjectPageNotifier extends ViewNotifier {
  //Model for project page
  ProjectModel model;
  //potential actions
  TextEditingController _messageController;
  File _file;

  FirestoreReaderService _firestoreReaderService;
  FirestoreUploadService _firestoreUploadService;
  FirebaseStorageService _firebaseStorageService;

  ProjectPageNotifier(this.model) {
    _firestoreReaderService = FirestoreReaderService();
    _firestoreUploadService = FirestoreUploadService();
    _firebaseStorageService = FirebaseStorageService();
    _messageController = TextEditingController();
  }

  TextEditingController get message => _messageController;
  String get fileName => _file.path.split('/').last ?? 'No name';

  @override
  Future fetchData() async {
    isLoading = true;
    await _firestoreReaderService.fetchProjectSignupById(
      TestData.userId,
      model,
    );
    isLoading = false;
  }

  @override
  Future onRefresh() async => fetchData();

  Future downloadAttachmentsAndPreview() async {
    isLoading = true;
    await _firebaseStorageService.download(
      filePath: model.attachment,
      callback: () => isLoading = false,
      onError: () =>
          error = NetworkError('An error occured during the download.'),
    );
  }

  Future signUp() async {
    isLoading = true;
    try {
      String _filePath;
      if (_file != null)
        _filePath = await _firebaseStorageService.uploadProjectFile(
          _file,
          onError: () => error = NetworkError('Couldn\'t upload your image'),
        );
      final ProjectSignupModel _signupModel = ProjectSignupModel(
        userId: TestData.userId,
        message: _messageController.text,
        projectId: model.docId,
        timestamps: DateTime.now(),
        file: _filePath,
      );
      await _firestoreUploadService.uploadSignUpDocument(_signupModel);
      _messageController.clear();
      fetchData();
    } catch (e) {
      print(e);
      error = NetworkError('(TRACE)   ::    ${e.runtimeType}');
    }
  }

  Future removeApplicant() async {
    isLoading = true;
    try {
      final String docId = model.userSignUpFile?.docId ?? null;
      if (docId != null)
        await _firestoreUploadService.removeApplicant(docId: docId);
      fetchData();
    } catch (e) {
      error = NetworkError('(TRACE)   ::    ${e.runtimeType}');
    }
  }
}
