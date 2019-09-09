import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:studentup_mobile/enum/project_action.dart';
import 'package:studentup_mobile/mixins/storage_io.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/models/project_signup_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/authentication/auth_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/storage/firebase/firebase_storage.dart';

class ProjectPageNotifier extends NetworkIO with StorageIO {
  //Model for project page
  ProjectModel model;
  //user sign up docs
  Stream<ProjectSignupModel> _userSignups;
  //potential actions
  TextEditingController _messageController;
  File _file;
  List<String> _downloadedFiles;

  ProjectPageNotifier(this.model)
      : _messageController = TextEditingController(),
        _downloadedFiles = [] {
    fetchData();
  }

  TextEditingController get message => _messageController;
  Stream<ProjectSignupModel> get userSignUpStream => _userSignups;
  bool get canApply =>
      _messageController.text?.isNotEmpty ?? false || _file != null;
  File get file => _file;
  set file(File value) {
    _file = value;
    print('value.path');
    notifyListeners();
  }

  @override
  Future fetchData() async {
    _userSignups = reader.fetchProjectSignupById(
      Locator.of<AuthService>().currentUser.uid,
      model,
    );
  }

  Future _signUp() async {
    if (!canApply) return;
    isWriting = true;
    String _filePath;
    if (_file != null) {
      final List<String> paths =
          await storage.upload(files: [_file], location: projectsFolder);
      _filePath = paths.length > 0 ? paths.first : null;
    }
    final ProjectSignupModel _signupModel = ProjectSignupModel(
      userId: Locator.of<AuthService>().currentUser.uid,
      message: _messageController.text,
      projectId: model.docId,
      timestamps: DateTime.now(),
      file: _filePath,
    );
    await writer.uploadSignUpDocument(
      model: _signupModel,
      project: model,
    );
    _messageController.clear();
    isWriting = false;
  }

  Future _removeApplicant() async {
    await writer.removeApplicant(model.docId);
    removeFile();
  }

  Future _deleteProject() async => await writer.removeProject(id: model.docId);

  /// Pick a single file directly
  Future<void> pickFile() async {
    File f = await FilePicker.getFile(type: FileType.ANY);
    if (f != null) file = f;
  }

  /// Remove file
  void removeFile() => file = null;

  @override
  Future<bool> sendData([data]) async {
    try {
      switch (data as ProjectAction) {
        case ProjectAction.SIGNUP:
          _signUp();
          break;
        case ProjectAction.WITHDRAW:
          _removeApplicant();
          break;
        case ProjectAction.DELETE:
          _deleteProject();
          break;
        default:
          throw 'No Action for: $data';
      }
    } catch (e) {
      writeError = NetworkError(message: e.toString());
      return false;
    }
    return true;
  }

  Future<void> downloadAttachmentsAndPreview() async {
    if (model.files.isEmpty) return;
    isReading = true;
    try {
      _downloadedFiles = await storage.download(filePaths: model.files);
      if (_downloadedFiles.isNotEmpty)
        await storage.showFile(file: File(_downloadedFiles[0]));
    } catch (e) {
      readError = NetworkError(message: e.toString());
    }
    isReading = false;
  }
}
