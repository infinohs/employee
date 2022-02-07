import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  late SharedPreferences prefs;


  Future<SharedPreferences> init() async {
    return await SharedPreferences.getInstance();
  }

  getIntValue(String key) async {
    prefs = await init();
    if (prefs.containsKey(key))
      return prefs.getInt(key);
    else
      return 0;
  }

  getStringValue(String key) async {
    prefs = await init();
    if (prefs.containsKey(key))
      return prefs.getString(key);
    else
      return '';
  }

  putStringValue(String key, String value) async {
    prefs = await init();
    return prefs.setString(key, value);
  }

  putIntValue(String key, int value) async {
    prefs = await init();
    return prefs.setInt(key, value);
  }

  getDoubleValue(String key) async {
    prefs = await init();
    if (prefs.containsKey(key))
      return prefs.getDouble(key)!;
    else
      return 0.0;
  }

  putDoubleValue(String key, double value) async {
    prefs = await init();
    return prefs.setDouble(key, value);
  }

  getBoolValue(String key) async {
    prefs = await init();
    if (prefs.containsKey(key))
      return prefs.getBool(key)!;
    else
      return false;
  }

  putBoolValue(String key, bool value) async {
    prefs = await init();
    return prefs.setBool(key, value);
  }

  getContainsValue(String key) async {
    prefs = await init();
    return prefs.containsKey(key);
  }

  clearAllStorage() async {
    prefs = await init();
    prefs.clear();
  }
}
