import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

class GeoLocationService {
  bg.State _currentState;

  /// Default radius for any given event
  double _kDefaultRadius = 100.0;

  /// Default Config for the Geolocation Plugin
  bg.Config _kDefaultConfig = bg.Config(
    allowIdenticalLocations: false,
    autoSync: false, //DEBUG: true
    batchSync: false, //DEBUG: true
    debug: true,
    desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
    distanceFilter: 4.0,
    forceReloadOnBoot: false,
    forceReloadOnGeofence: true,
    forceReloadOnHeartbeat: false,
    forceReloadOnLocationChange: false,
    forceReloadOnMotionChange: false,
    forceReloadOnSchedule: true, //Check this one
    geofenceInitialTriggerEntry: true,
    geofenceModeHighAccuracy: true,
    geofenceProximityRadius: 200,
    isMoving: true,
    locationAuthorizationAlert: <String, dynamic>{}, //Check this
    logLevel: bg.Config.LOG_LEVEL_VERBOSE,
    schedule: <String>[],
    scheduleUseAlarmManager: true,
    speedJumpFilter: 200,
    startOnBoot: true,
    stopAfterElapsedMinutes: 10, //Check this
    stopOnStationary: false,
    stopOnTerminate: false,
    useSignificantChangesOnly: true,
    reset: true,
  );

  bg.State get state => _currentState;

  /// 1. Sets up event listeners
  /// 2. Configures the plugin
  /// 3. Starts the plugin
  Future<void> setupGeoLocation() async {
    bg.BackgroundGeolocation.onGeofence((bg.GeofenceEvent event) {
      print(event.action);
      if (event.action == 'DWELL') print(event.identifier);
    });

    bg.BackgroundGeolocation.onSchedule((bg.State _state) {
      if (_state.enabled) {
        print('[onSchedule] - start tracking');
      } else {
        print('[onSchedule] - stop tracking');
      }
    });

    _currentState = await bg.BackgroundGeolocation.ready(_kDefaultConfig);
    if (!_currentState.enabled)
      _currentState = await bg.BackgroundGeolocation.startSchedule();
  }

  /// Add a new geofence around the location provided
  Future<void> addEventGeofence(
    String name,
    GeoPoint location, [
    double radius,
  ]) async {
    try {
      await bg.BackgroundGeolocation.addGeofence(
        bg.Geofence(
          identifier: name,
          latitude: location.latitude,
          longitude: location.longitude,
          radius: radius ?? _kDefaultRadius,
        ),
      );
      print('[addEventGeofence - Geofence added: $name]');
    } catch (e) {
      print(e);
    }
  }

  /// Updates the configuration's schedule in real time
  Future<void> updateSchedule(String scheduleToAdd) async {
    try {
      List<String> _currentSchedule = List<String>.from(_currentState.schedule);
      _currentSchedule.add(scheduleToAdd + ' geolocation');
      _currentState = await bg.BackgroundGeolocation.setConfig(
        bg.Config(schedule: _currentSchedule),
      );
      print(
          '[updateSchedule - Schedule updated with $scheduleToAdd :: $_currentState]');
    } catch (e) {
      print(e);
    }
  }

  Future<void> debugGeofencesAndSchedule() async {
    List<bg.Geofence> geofences = await bg.BackgroundGeolocation.geofences;
    print('[Geofences Debug]');
    print(geofences.map((geofence) => geofence.identifier));
    print('[Schedule Debug]');
    print(_currentState.schedule);
  }
}
