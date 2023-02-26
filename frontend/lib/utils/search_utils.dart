import 'package:shared_preferences/shared_preferences.dart';

class SearchUtils {
  static Future saveSearchHistory(String keyword) async {
    if (keyword.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    final List<String> history = prefs.getStringList('search_history') ?? [];
    history.remove(keyword);
    history.insert(0, keyword);
    if (history.length > 20) {
      history.removeAt(20);
    }
    prefs.setStringList('search_history', history);
  }

  static Future<bool> removeHistory(String keyword) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> history = prefs.getStringList('search_history') ?? [];
    bool succeed = history.remove(keyword);
    prefs.setStringList('search_history', history);
    return succeed;
  }

  static Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('search_history') ?? [];
  }

  static Future removeAllHistory() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('search_history', []);
  }
}
