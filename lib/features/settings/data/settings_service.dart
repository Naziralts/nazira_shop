import 'package:hive/hive.dart';
import '../../../core/constants/hive_boxes.dart';

class SettingsService {
  final Box _box = Hive.box(HiveBoxes.settingsBox);

  bool isDarkMode() => _box.get('isDarkMode', defaultValue: false);

  void toggleTheme() => _box.put('isDarkMode', !isDarkMode());

  String getLanguage() => _box.get('language', defaultValue: 'en');

  void setLanguage(String langCode) => _box.put('language', langCode);
}
