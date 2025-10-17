import 'package:hive/hive.dart';
import 'package:nazira_shop/core/constants/hive_boxes.dart';


class FavoritesService {
  final Box _box = Hive.box(HiveBoxes.favoritesBox);

  List<int> getFavorites() => _box.values.cast<int>().toList();

  bool isFavorite(int productId) => _box.containsKey(productId);

  void toggleFavorite(int productId) {
    if (isFavorite(productId)) {
      _box.delete(productId);
    } else {
      _box.put(productId, productId);
    }
  }
}
