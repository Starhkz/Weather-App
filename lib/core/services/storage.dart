import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/utils/helpers.dart';

class SharedPreferenceLocalStorage {
  static SharedPreferenceLocalStorage? _instance;
  static SharedPreferences? _preferences;
  static Future<SharedPreferenceLocalStorage> getInstance() async {
    _instance ??= SharedPreferenceLocalStorage();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  Future setIntList(List<int> value) async {
    await _preferences!.setStringList('myList', toStringList(value));
  }

  Future<List<int>> getStringList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList('myList') ?? ['0', '5', '2'];
    return list.map((val) => int.parse(val)).toList();
  }
}
