class LaborExeprienceModel {
  String _userId;
  String _companyName;
  String _periodStart;
  String _periodEnd;

  LaborExeprienceModel({
    String userId,
    String companyName,
    String periodStart,
    String periodEnd,
  }) {
    _userId = userId;
    _companyName = companyName;
    _periodStart = periodStart;
    _periodEnd = periodEnd;
  }

  String get userId => _userId ?? '404 Error';
  String get companyName => _companyName ?? '404 Error';
  String get periodStart => _periodStart ?? '404 Error';
  String get periodEnd => _periodEnd ?? '404 Error';

  LaborExeprienceModel.fromJson(Map<String, dynamic> json) {
    _userId = json['user_id'];
    _companyName = json['company_name'];
    _periodStart = json['period_start'];
    _periodEnd = json['period_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = _userId;
    data['company_name'] = _companyName;
    data['period_start'] = _periodStart;
    data['period_end'] = _periodEnd;
    return data;
  }
}
