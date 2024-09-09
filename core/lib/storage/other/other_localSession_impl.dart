import 'package:core/storage/LocalSessionRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

LocalSessionRepository getLocalSession() => OtherLocalSessionImpl();

class OtherLocalSessionImpl extends LocalSessionRepository {
  SharedPreferences? _prefs;

  Future<SharedPreferences> getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  @override
  Future<String> getData(String key) async {
    return (await getPrefs()).getString(key) ?? '';
  }

  @override
  Future<void> insertData(Map<String, String> data) async {
    var pref = (await getPrefs());
    for (var element in data.entries) {
      await pref.setString(element.key, element.value);
    }
  }

  @override
  Future<bool> clearSession() async {

    await _prefs?.clear();
    return true;
  }
}
