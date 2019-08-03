class EducationModel {
  String _userId;
  String _university;
  String _faculty;
  String _degree;
  String _gradDate;
  String _periodStart;
  String _periodEnd;
  String _studyDescription;

  EducationModel({
    String userId,
    String university,
    String faculty,
    String degree,
    String gradDate,
    String periodStart,
    String periodEnd,
    String studyDescription,
  }) {
    _userId = userId;
    _university = university;
    _faculty = faculty;
    _degree = degree;
    _gradDate = gradDate;
    _periodStart = periodStart;
    _periodEnd = periodEnd;
    _studyDescription = studyDescription;
  }

  String get userId => _userId ?? '404 Error';
  String get university => _university ?? '404 Error';
  String get faculty => _faculty ?? '404 Error';
  String get degree => _degree ?? '404 Error';
  String get gradDate => _gradDate ?? '404 Error';
  String get periodStart => _periodStart ?? '404 Error';
  String get periodEnd => _periodEnd ?? '404 Error';
  String get studyDescription => _studyDescription ?? '404 Error';

  EducationModel.fromJson(Map<String, dynamic> json) {
    _userId = json['user_id'];
    _university = json['university'];
    _faculty = json['faculty'];
    _degree = json['degree'];
    _gradDate = json['grad_date'];
    _periodStart = json['period_start'];
    _periodEnd = json['period_end'];
    _studyDescription = json['study_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = _userId;
    data['university'] = _university;
    data['faculty'] = _faculty;
    data['degree'] = _degree;
    data['grad_date'] = _gradDate;
    data['period_start'] = _periodStart;
    data['period_end'] = _periodEnd;
    data['study_description'] = _studyDescription;
    return data;
  }
}
