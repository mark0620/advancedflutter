import 'package:advancedflutter/common/model/cursor_pagination_model.dart';
import 'package:advancedflutter/restaurant/repository/restaurant_rating_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantRatingStateNorifier
    extends StateNotifier<CursorPaginationBase> {
  final RestaurantRatingRepository repository;

  RestaurantRatingStateNorifier({
    required this.repository,
  }) : super(
          CursorPaginationLoading(),
        );
}
