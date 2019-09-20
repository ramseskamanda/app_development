import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentup_mobile/enum/search_enum.dart';
import 'package:studentup_mobile/mixins/storage_io.dart';
import 'package:studentup_mobile/models/chat_model.dart';
import 'package:studentup_mobile/models/project_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/storage/firebase/firebase_storage.dart';

const int MINIMUM_LENGTH_PROJECT = 3;
const int MAXIMUM_LENGTH_PROJECT = 75;
const int MINIMUM_PARTICIPANTS = 10;
const int MAXIMUM_PARTICIPANTS = 250;
const int MAXIMUM_CATEGORIES_SELECTED = 3;

class ProjectCreationNotifier extends NetworkIO with StorageIO {
  File _image;
  TextEditingController _nameController;
  TextEditingController _descriptionController;
  List<File> _files;
  DateTime _deadline;
  int _numParticipants;
  List<SearchCategory> _categories;

  File get image => _image;
  set image(File newImage) => _image = newImage ?? image;
  TextEditingController get name => _nameController;
  TextEditingController get description => _descriptionController;
  List<File> get files => _files ?? <File>[];
  DateTime get deadline => _deadline ?? minimumDeadline;
  set deadline(DateTime date) => _deadline = date ?? minimumDeadline;
  DateTime get minimumDeadline =>
      DateTime.now().add(const Duration(days: MINIMUM_LENGTH_PROJECT));
  DateTime get maximumDeadline =>
      DateTime.now().add(const Duration(days: MAXIMUM_LENGTH_PROJECT));
  int get numParticipants => _numParticipants;
  List<SearchCategory> get categories => _categories ?? <SearchCategory>[];
  double get minimumParticipants => MINIMUM_PARTICIPANTS.toDouble();
  double get maximumParticipants => MAXIMUM_PARTICIPANTS.toDouble();
  set numParticipants(int value) {
    _numParticipants = value;
    notifyListeners();
  }

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

  ProjectCreationNotifier() {
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _image = null;
    _files = <File>[];
    _deadline =
        DateTime.now().add(const Duration(days: MINIMUM_LENGTH_PROJECT));
    _numParticipants = MINIMUM_PARTICIPANTS;
    _categories = <SearchCategory>[];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Future<void> fetchData() async {}

  @override
  Future<bool> sendData([data]) async {
    if (!formIsValid) return false;
    isWriting = true;
    try {
      final List<File> allFiles = files..removeWhere((file) => file == null);

      final List<String> imageUrl =
          await storage.upload(files: [image], location: projectsFolder);

      final List<String> _paths =
          await storage.upload(files: allFiles, location: projectsFolder);

      _paths.forEach(print);

      final Preview preview = data as Preview;
      ProjectModel _model = ProjectModel(
        creatorId: preview.uid,
        creatorMedia: preview.imageUrl,
        creator: preview.givenName,
        timestamp: DateTime.now(),
        categories: categories,
        maxUsersNum: numParticipants,
        media: imageUrl.length > 0 ? imageUrl.first : null,
        description: description.text,
        title: name.text,
        files: _paths,
        deadline: deadline,
      );
      // uploadTasks = storage.startUpload(allFiles, _paths);
      // uploadStream.listen((double percent) {
      //   if (1.0 == percent) isDone = true;
      // });
      await writer.uploadProjectInformation(model: _model);
      isDone = true;
    } catch (e) {
      print(e);
      writeError = NetworkError(message: e.toString());
      return false;
    }
    isWriting = false;
    return true;
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
}
