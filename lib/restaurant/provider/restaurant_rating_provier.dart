import 'package:advancedflutter/common/model/cursor_pagination_model.dart';
import 'package:advancedflutter/common/provider/pagination_provider.dart';
import 'package:advancedflutter/rating/model/rating_model.dart';
import 'package:advancedflutter/restaurant/provider/restaurant_provider.dart';
import 'package:advancedflutter/restaurant/repository/restaurant_rating_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantRatingProvider = StateNotifierProvider.family<
    RestaurantRatingStateNorifier, CursorPaginationBase, String>((ref, id) {
  final repo = ref.watch(restaurantRatingRepositoryProvider(id));

  return RestaurantRatingStateNorifier(repository: repo);
});

class RestaurantRatingStateNorifier
    extends PaginationProvider<RatingModel, RestaurantRatingRepository> {
  RestaurantRatingStateNorifier({
    required super.repository,
  });
}
