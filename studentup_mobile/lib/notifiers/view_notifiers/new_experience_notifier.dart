import 'package:flutter/cupertino.dart';
import 'package:studentup_mobile/models/labor_experience_model.dart';
import 'package:studentup_mobile/notifiers/base_notifiers.dart';
import 'package:studentup_mobile/services/authentication/base_auth.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/util/util.dart';

class NewExperienceNotifier extends NetworkWriter {
  TextEditingController _company;
  TextEditingController _position;
  TextEditingController _startDateController;
  TextEditingController _endDateController;
  DateTime _startDate;
  DateTime _endDate;

  NewExperienceNotifier() {
    _company = TextEditingController();
    _position = TextEditingController();
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
  }

  TextEditingController get company => _company;
  TextEditingController get position => _position;
  TextEditingController get startDateController => _startDateController;
  TextEditingController get gradDateController => _endDateController;
  DateTime get endDate => _endDate;
  bool get canSend => _company.text.isNotEmpty && _position.text.isNotEmpty;

  set startDate(DateTime value) {
    _startDate = value;
    _startDateController.text = 'Started: ' + Util.formatDateTime(value);
    notifyListeners();
  }

  set endDate(DateTime value) {
    if (_startDate == null || value == null || !value.isAfter(_startDate))
      return;
    _endDate = value;
    _endDateController.text = 'Ended: ' + Util.formatDateTime(value);
    notifyListeners();
  }

  @override
  Future<bool> sendData() async {
    try {
      if (!canSend) return false;
      isLoading = true;
      final model = LaborExeprienceModel(
        userId: Locator.of<BaseAuth>().currentUserId,
        periodStart: _startDate,
        periodEnd: _endDate,
        companyName: _company.text,
        position: _position.text,
      );
      await writer.postNewExperience(model);
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
    _company.dispose();
    _position.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
  }
}
