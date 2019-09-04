import 'package:flutter/cupertino.dart';
import 'package:studentup_mobile/models/education_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/auth_service.dart';
import 'package:studentup_mobile/services/firestore_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/util/util.dart';

class NewEducationNotifier extends NetworkNotifier {
  //TODO: change these into blocs
  String _category;
  TextEditingController _university;
  TextEditingController _description;
  TextEditingController _faculty;
  TextEditingController _startDateController;
  TextEditingController _gradDateController;
  DateTime _startDate;
  DateTime _gradDate;

  FirestoreWriter _firestoreWriter;

  NewEducationNotifier() {
    _firestoreWriter = FirestoreWriter();
    _university = TextEditingController();
    _description = TextEditingController();
    _faculty = TextEditingController();
    _startDateController = TextEditingController();
    _gradDateController = TextEditingController();
    category = 'Select a degree...';
  }

  TextEditingController get name => _university;
  TextEditingController get description => _description;
  TextEditingController get faculty => _faculty;
  String get category => _category;
  TextEditingController get startDateController => _startDateController;
  TextEditingController get gradDateController => _gradDateController;
  DateTime get gradDate => _gradDate;
  bool get canSend =>
      _university.text.isNotEmpty &&
      _description.text.isNotEmpty &&
      _faculty.text.isNotEmpty &&
      category != 'Select a degree...';

  set category(String value) {
    _category = value;
    notifyListeners();
  }

  set startDate(DateTime value) {
    _startDate = value;
    _startDateController.text = 'Started: ' + Util.formatDateTime(value);
    notifyListeners();
  }

  set gradDate(DateTime value) {
    if (_startDate == null || value == null || !value.isAfter(_startDate))
      return;
    _gradDate = value;
    _gradDateController.text =
        '(Expected) Graduation: ' + Util.formatDateTime(value);
    notifyListeners();
  }

  Future<bool> send() async {
    try {
      if (!canSend) return false;
      isLoading = true;
      final model = EducationModel(
        userId: Locator.of<AuthService>().currentUser.uid,
        university: _university.text,
        faculty: _faculty.text,
        degree: _category,
        gradDate: _gradDate,
        periodStart: _startDate,
        periodEnd: _gradDate,
        studyDescription: _description.text,
      );
      await _firestoreWriter.postNewEducation(model);
    } catch (e) {
      print(e);
      error = NetworkError(message: e.toString());
      return false;
    }
    isLoading = false;
    return true;
  }

  @override
  void dispose() {
    super.dispose();
    _university.dispose();
    _description.dispose();
    _faculty.dispose();
    _gradDateController.dispose();
    _startDateController.dispose();
  }

  @override
  Future fetchData() async {}

  @override
  Future onRefresh() async {}
}
