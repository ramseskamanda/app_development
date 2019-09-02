import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentup_mobile/enum/search_enum.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:studentup_mobile/services/firestore_service.dart';
import 'package:studentup_mobile/services/locator.dart';

const int MINIMUM_LENGTH_Project = 3;
const int MAXIMUM_LENGTH_Project = 75;
const int MINIMUM_PARTICIPANTS = 10;
const int MAXIMUM_PARTICIPANTS = 250;
const int MAXIMUM_CATEGORIES_SELECTED = 3;

/// Only gets instantiated when a new Project is requested
class ProjectCreationService extends NetworkNotifier {
  File _image;
  TextEditingController _nameController;
  TextEditingController _descriptionController;
  List<File> _files;
  DateTime _deadline;
  int _numParticipants;
  List<SearchCategory> _categories;
  FirestoreWriter _firestoreWriter;
  FirebaseStorageService _firebaseStorageService;
  List<StorageUploadTask> _uploadTasks;
  bool _isDone;

  File get image => _image;
  set image(File newImage) => _image = newImage ?? image;
  TextEditingController get name => _nameController;
  TextEditingController get description => _descriptionController;
  List<File> get files => _files ?? <File>[];
  DateTime get deadline => _deadline ?? minimumDeadline;
  set deadline(DateTime date) => _deadline = date ?? minimumDeadline;
  DateTime get minimumDeadline =>
      DateTime.now().add(const Duration(days: MINIMUM_LENGTH_Project));
  DateTime get maximumDeadline =>
      DateTime.now().add(const Duration(days: MAXIMUM_LENGTH_Project));
  int get numParticipants => _numParticipants;
  List<SearchCategory> get categories => _categories ?? <SearchCategory>[];
  double get minimumParticipants => MINIMUM_PARTICIPANTS.toDouble();
  double get maximumParticipants => MAXIMUM_PARTICIPANTS.toDouble();
  set numParticipants(int value) {
    _numParticipants = value;
    notifyListeners();
  }

  bool get isUploading => _uploadTasks.isNotEmpty && !isDone;

  bool get isDone => _isDone;

  set uploads(List<StorageUploadTask> list) {
    _uploadTasks = list;
    notifyListeners();
  }

  Observable<double> get uploadStream =>
      Observable.zip(_uploadTasks.map((u) => u.events),
          (List<StorageTaskEvent> events) {
        return events.isNotEmpty
            ? events.fold<double>(
                    0, (total, e) => total + e.snapshot.bytesTransferred) /
                events.fold<double>(
                    0, (total, e) => total + e.snapshot.totalByteCount)
            : 0;
      });

  bool get formIsValid {
    return _nameController.text != null &&
        _nameController.text.isNotEmpty &&
        _descriptionController.text != null &&
        _descriptionController.text.isNotEmpty &&
        _files != null &&
        _deadline != null &&
        _numParticipants != null &&
        _categories != null &&
        _categories.length > 0;
  }

  ProjectCreationService() {
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _image = null;
    _files = <File>[];
    _deadline =
        DateTime.now().add(const Duration(days: MINIMUM_LENGTH_Project));
    _numParticipants = MINIMUM_PARTICIPANTS;
    _categories = <SearchCategory>[];
    _uploadTasks = <StorageUploadTask>[];
    _firestoreWriter = Locator.of<FirestoreWriter>();
    _firebaseStorageService = FirebaseStorageService();
    _isDone = false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  /// Upload data
  Future<void> uploadProject() async {
    if (!formIsValid) return;
    isLoading = true;
    try {
      final List<File> allFiles = [image, ...files]
        ..removeWhere((file) => file == null);
      List<String> _paths = FirebaseStorageService.createFilePaths(
        allFiles,
        'projects_files',
      );
      ProjectModel _model = ProjectModel(
        creatorId: Locator.of<AuthService>().currentUser.uid,
        creatorMedia: Locator.of<AuthService>().currentUser.photoUrl,
        creator: Locator.of<AuthService>().currentUser.displayName,
        timestamp: DateTime.now(),
        categories: categories,
        maxUsersNum: numParticipants,
        media: null, //TODO: add background image here
        description: description.text,
        title: name.text,
        files: _paths.skip(1).toList(),
        deadline: deadline,
      );
      uploads = _firebaseStorageService.startUpload(allFiles, _paths);
      uploadStream.listen((double percent) {
        if (1.0 == percent) notifyListeners();
      });
      await _firestoreWriter.uploadProjectInformation(model: _model);
      _isDone = true;
    } catch (e) {
      print(e);
    }
    isLoading = false;
  }

  /// Cropper plugin
  Future<void> cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: image.path,
      // ratioX: 1.0,
      // ratioY: 1.0,
      // maxWidth: 512,
      // maxHeight: 512,
      toolbarColor: Colors.purple,
      toolbarWidgetColor: Colors.white,
      toolbarTitle: 'Crop It',
    );
    _image = cropped ?? image;
    notifyListeners();
  }

  /// Select an image via gallery or camera
  Future<void> pickImage(int source) async {
    File selected = await ImagePicker.pickImage(
      source: ImageSource.values[source],
      imageQuality: 60,
    );
    image = selected;
    notifyListeners();
  }

  /// Remove image
  void clearImage() {
    _image = null;
    notifyListeners();
  }

  /// Pick a single file directly
  Future<void> pickFile() async {
    File file = await FilePicker.getFile(type: FileType.ANY);
    if (file != null) files.add(file);
    notifyListeners();
  }

  /// Remove file
  void removeFile(int index) {
    files.removeAt(index);
    notifyListeners();
  }

  /// Select Category
  void toggleCategory(SearchCategory category) {
    if (categories.contains(category))
      categories.removeWhere((c) => c == category);
    else if (categories.length < MAXIMUM_CATEGORIES_SELECTED)
      categories.add(category);
    notifyListeners();
  }

  @override
  Future fetchData() async {}

  @override
  Future onRefresh() async {}
}
