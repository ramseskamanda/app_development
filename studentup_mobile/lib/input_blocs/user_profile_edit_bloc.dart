import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:studentup_mobile/services/authentication/auth_service.dart';
import 'package:studentup_mobile/services/locator.dart';
import 'package:studentup_mobile/services/storage/base_api.dart';
import 'package:studentup_mobile/util/util.dart';

class UserProfileEditBloc {
  TextEditingController _nameEditor;
  TextEditingController _universityEditor;
  TextEditingController _locationEditor;
  TextEditingController _bioEditor;
  BehaviorSubject<String> _name;
  BehaviorSubject<String> _university;
  BehaviorSubject<String> _location;
  BehaviorSubject<String> _bio;

  UserProfileEditBloc()
      : _nameEditor = TextEditingController(),
        _universityEditor = TextEditingController(),
        _locationEditor = TextEditingController(),
        _bioEditor = TextEditingController(),
        _name = BehaviorSubject<String>(),
        _university = BehaviorSubject<String>(),
        _location = BehaviorSubject<String>(),
        _bio = BehaviorSubject<String>() {
    _nameEditor.addListener(() => name.add(_nameEditor.text));
    _universityEditor.addListener(() => university.add(_universityEditor.text));
    _locationEditor.addListener(() => location.add(_locationEditor.text));
    _bioEditor.addListener(() => bio.add(_bioEditor.text));
  }

  TextEditingController get nameEditor => _nameEditor;
  TextEditingController get universityEditor => _universityEditor;
  TextEditingController get locationEditor => _locationEditor;
  TextEditingController get bioEditor => _bioEditor;

  Sink<String> get name => _name.sink;
  Sink<String> get university => _university.sink;
  Sink<String> get location => _location.sink;
  Sink<String> get bio => _bio.sink;

  String get nameValue => _name.value;
  String get emailValue => _university.value;
  String get passwordValue => _location.value;

  Stream<bool> get canEdit => Observable.combineLatest4(
        _name,
        _university,
        _location,
        _bio,
        (String a, String b, String c, String d) =>
            (a != null && b != null && c != null && d != null) &&
            (a.isNotEmpty || b.isNotEmpty || c.isNotEmpty || d.isNotEmpty),
      );

  void dispose() {
    _name.close();
    _university.close();
    _location.close();
    _bio.close();
    _nameEditor.dispose();
    _universityEditor.dispose();
    _locationEditor.dispose();
    _bioEditor.dispose();
  }

  Map<String, dynamic> _getData() {
    Map<String, dynamic> data = {};
    if (_nameEditor.text.isNotEmpty) data['given_name'] = _nameEditor.text;
    if (_universityEditor.text.isNotEmpty)
      data['university'] = _universityEditor.text;
    if (_locationEditor.text.isNotEmpty)
      data['location'] = Util.locationToGeoPoint(_locationEditor.text);
    if (_bioEditor.text.isNotEmpty) data['bio'] = _bioEditor.text;
    return data;
  }

  Future uploadEditorInfo() async {
    try {
      await Locator.of<BaseAPIWriter>().updateProfileInfo(
        Locator.of<AuthService>().currentUser.uid,
        _getData(),
      );
    } catch (e) {
      print(e);
    }
  }

  void clearEditor() {
    _nameEditor.clear();
    _universityEditor.clear();
    _locationEditor.clear();
    _bioEditor.clear();
  }
}
