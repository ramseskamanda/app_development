class StudentModel {
  double _experiencePoints;
  double _monthlyExperience;
  String _name;
  int _completedProjects;
  String _university;

  StudentModel({
    double exp,
    double monthlyExp,
    String name,
    int completedProjects,
    String university,
  })  : _completedProjects = completedProjects,
        _name = name,
        _experiencePoints = exp,
        _monthlyExperience = monthlyExp,
        _university = university;

  String get name => _name ?? 'Unkown Name';
  double get experiencePoints => _experiencePoints ?? -1.0;
  double get monthlyExperience => _monthlyExperience ?? -1.0;
  int get completedProjects => _completedProjects ?? -1;
  String get university => _university ?? 'No university';
}
