import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_dev/enum/search_enum.dart';
import 'package:ui_dev/services/firebase/firestore.dart';

const int MINIMUM_LENGTH_COMPETITION = 3;
const int MAXIMUM_LENGTH_COMPETITION = 90;
const int MINIMUM_PARTICIPANTS = 10;
const int MAXIMUM_PARTICIPANTS = 250;
const int MAXIMUM_CATEGORIES_SELECTED = 3;

/// Only gets instantiated when a new competition is requested
class CompetitionCreationService extends ChangeNotifier {
  File _image;
  TextEditingController _nameController;
  TextEditingController _descriptionController;
  List<File> _files;
  DateTime _deadline;
  int _numParticipants;
  List<SearchCategory> _categories;
  bool _isUploading;
  bool _isDone;
  FirestoreService _firestoreService;

  File get image => _image;
  set image(File newImage) => _image = newImage ?? image;
  TextEditingController get name => _nameController;
  TextEditingController get description => _descriptionController;
  List<File> get files => _files ?? <File>[];
  DateTime get deadline => _deadline ?? minimumDeadline;
  set deadline(DateTime date) => _deadline = date ?? minimumDeadline;
  DateTime get minimumDeadline =>
      DateTime.now().add(const Duration(days: MINIMUM_LENGTH_COMPETITION));
  DateTime get maximumDeadline =>
      DateTime.now().add(const Duration(days: MAXIMUM_LENGTH_COMPETITION));
  int get numParticipants => _numParticipants;
  List<SearchCategory> get categories => _categories ?? <SearchCategory>[];
  double get minimumParticipants => MINIMUM_PARTICIPANTS.toDouble();
  double get maximumParticipants => MAXIMUM_PARTICIPANTS.toDouble();
  set numParticipants(int value) {
    _numParticipants = value;
    notifyListeners();
  }

  bool get isUploading => _isUploading;
  set isUploading(bool value) {
    _isUploading = value;
    notifyListeners();
  }

  bool get isDone => _isDone;
  set isDone(bool value) {
    _isDone = value;
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

  CompetitionCreationService() {
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _image = null;
    _files = <File>[];
    _deadline =
        DateTime.now().add(const Duration(days: MINIMUM_LENGTH_COMPETITION));
    _numParticipants = MINIMUM_PARTICIPANTS;
    _categories = <SearchCategory>[];
    _firestoreService = FirestoreService();
    _isUploading = false;
    _isDone = false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  /// Upload data
  Future<void> uploadCompetition() async {
    //Make model here
    isUploading = true;
    //_firestoreService.uploadCompetitionInformation(data);
    await Future.delayed(Duration(seconds: 2));
    _isUploading = false;
    isDone = true;
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
    //TODO: compress to show only thumbnail
    File selected =
        await ImagePicker.pickImage(source: ImageSource.values[source]);
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
