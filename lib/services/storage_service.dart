import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const _keyLanguage = 'agri_language';
  static const _keyDarkMode = 'agri_dark_mode';
  static const _keyState = 'agri_state';
  static const _keyDistrict = 'agri_district';
  static const _keyMandal = 'agri_mandal';
  static const _keyVillage = 'agri_village';
  static const _keyLat = 'agri_lat';
  static const _keyLon = 'agri_lon';
  static const _keyUserName = 'agri_user_name';
  static const _keyUserEmail = 'agri_user_email';
  static const _keyIsLoggedIn = 'agri_is_logged_in';
  static const _keyMuteGreetings = 'agri_mute_greetings';
  static const _keySelectedCrop = 'agri_selected_crop';
  static const _keyVoiceSpeed = 'agri_voice_speed';
  static const _keyLoginAttempts = 'agri_login_attempts';
  static const _keyLockoutTime = 'agri_lockout_time';

  final FlutterSecureStorage _secureStorage;
  final Map<String, String> _cache = {};

  StorageService._(this._secureStorage);

  static Future<StorageService> init() async {
    const secureStorage = FlutterSecureStorage();
    final service = StorageService._(secureStorage);
    await service._loadCache();
    return service;
  }

  Future<void> _loadCache() async {
    final all = await _secureStorage.readAll();
    _cache.addAll(all);
  }

  Future<void> _write(String key, String value) async {
    _cache[key] = value;
    await _secureStorage.write(key: key, value: value);
  }

  Future<void> _delete(String key) async {
    _cache.remove(key);
    await _secureStorage.delete(key: key);
  }

  // ── Language ──
  Future<void> setLanguage(String code) => _write(_keyLanguage, code);
  String getLanguage() => _cache[_keyLanguage] ?? 'en';

  // ── Dark Mode ──
  Future<void> setDarkMode(bool value) => _write(_keyDarkMode, value.toString());
  bool getDarkMode() => _cache[_keyDarkMode] == 'true';

  // ── Voice & Audio Settings ──
  Future<void> setMuteGreetings(bool value) => _write(_keyMuteGreetings, value.toString());
  bool getMuteGreetings() => _cache[_keyMuteGreetings] != 'false';
  Future<void> setVoiceSpeed(int speed) => _write(_keyVoiceSpeed, speed.toString());
  int getVoiceSpeed() => int.tryParse(_cache[_keyVoiceSpeed] ?? '1') ?? 1;

  // ── Location ──
  Future<void> saveLocation({
    required String state,
    required String district,
    required String mandal,
    String? village,
    required double lat,
    required double lon,
  }) async {
    await Future.wait([
      _write(_keyState, state),
      _write(_keyDistrict, district),
      _write(_keyMandal, mandal),
      if (village != null) _write(_keyVillage, village) else _delete(_keyVillage),
      _write(_keyLat, lat.toString()),
      _write(_keyLon, lon.toString()),
    ]);
  }

  String? getState() => _cache[_keyState];
  String? getDistrict() => _cache[_keyDistrict];
  String? getMandal() => _cache[_keyMandal];
  String? getVillage() => _cache[_keyVillage];
  double? getLat() => double.tryParse(_cache[_keyLat] ?? '');
  double? getLon() => double.tryParse(_cache[_keyLon] ?? '');

  bool get hasLocation => _cache.containsKey(_keyState) && _cache.containsKey(_keyDistrict);

  Future<void> clearLocation() async {
    await Future.wait([
      _delete(_keyState),
      _delete(_keyDistrict),
      _delete(_keyMandal),
      _delete(_keyVillage),
      _delete(_keyLat),
      _delete(_keyLon),
    ]);
  }

  // ── User Session ──
  Future<void> saveUser({required String name, required String email}) async {
    await Future.wait([
      _write(_keyUserName, name),
      _write(_keyUserEmail, email),
      _write(_keyIsLoggedIn, 'true'),
      _delete(_keyLoginAttempts),
      _delete(_keyLockoutTime),
    ]);
  }

  String getUserName() => _cache[_keyUserName] ?? 'Agroksha Farmer';
  String getUserEmail() => _cache[_keyUserEmail] ?? '';
  bool getIsLoggedIn() => _cache[_keyIsLoggedIn] == 'true';

  Future<void> clearUser() async {
    await Future.wait([
      _delete(_keyUserName),
      _delete(_keyUserEmail),
      _delete(_keyIsLoggedIn),
    ]);
  }

  // ── Login Cooldown & Rate Limiting ──
  int getLoginAttempts() => int.tryParse(_cache[_keyLoginAttempts] ?? '0') ?? 0;
  Future<void> incrementLoginAttempts() async {
    int attempts = getLoginAttempts() + 1;
    await _write(_keyLoginAttempts, attempts.toString());
  }
  
  Future<void> setLockoutTime(DateTime time) => _write(_keyLockoutTime, time.toIso8601String());
  DateTime? getLockoutTime() {
    final val = _cache[_keyLockoutTime];
    if (val == null) return null;
    return DateTime.tryParse(val);
  }

  Future<void> resetLoginAttempts() async {
    await _delete(_keyLoginAttempts);
    await _delete(_keyLockoutTime);
  }

  // ── Selected Crop ──
  Future<void> setSelectedCrop(String crop) => _write(_keySelectedCrop, crop);
  String getSelectedCrop() => _cache[_keySelectedCrop] ?? 'Paddy';

  Future<void> clearAll() async {
    _cache.clear();
    await _secureStorage.deleteAll();
  }
}
