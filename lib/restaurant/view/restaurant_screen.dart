import 'package:advancedflutter/common/component/pagination_list_view.dart';
import 'package:advancedflutter/restaurant/component/restaurant_card.dart';
import 'package:advancedflutter/restaurant/provider/restaurant_provider.dart';
import 'package:advancedflutter/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';



class RestaurantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaginationListView(
      provider: restaurantProvider,
      itembuilder: <RestaurantModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => RestaurantDetailScreen(
                  id: model.id,
                ),
              ),
            );
          },
          child: RestaurantCard.fromModel(
            model: model,
          ),
        );
      },
    );
  }
}
