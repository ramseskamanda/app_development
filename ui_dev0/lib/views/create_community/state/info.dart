import 'package:rxdart/rxdart.dart';

class CommunityInfoBloc {
  final BehaviorSubject<String> _nameStream = BehaviorSubject<String>();
  final BehaviorSubject<String> _descriptionStream = BehaviorSubject<String>();
  BehaviorSubject<String> get name => _nameStream;
  BehaviorSubject<String> get description => _descriptionStream;
  Observable<bool> get canContinue => Observable.combineLatest2(
        _nameStream,
        _descriptionStream,
        (String a, String b) =>
            (a != null && a.isNotEmpty) && (b != null && b.isNotEmpty),
      );

  void dispose() {
    _nameStream.close();
    _descriptionStream.close();
  }
}
