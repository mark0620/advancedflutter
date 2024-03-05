import 'package:advancedflutter/common/component/pagination_list_view.dart';
import 'package:advancedflutter/restaurant/component/restaurant_card.dart';
import 'package:advancedflutter/restaurant/provider/restaurant_provider.dart';
import 'package:advancedflutter/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RestaurantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaginationListView(
      provider: restaurantProvider,
      itembuilder: <RestaurantModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            context.goNamed(RestaurantDetailScreen.routeName, pathParameters: {
              'rid': model.id,
            });
          },
          child: RestaurantCard.fromModel(
            model: model,
          ),
        );
      },
    );
  }
}
