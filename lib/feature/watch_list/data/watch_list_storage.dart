import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class WatchListStorage {
  static const String boxName = 'watch_list';

  static Future<void> initialize() async {
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(boxName);
  }
}
