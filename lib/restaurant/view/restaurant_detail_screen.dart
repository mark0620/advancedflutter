import 'package:advancedflutter/common/layout/default_layout.dart';
import 'package:advancedflutter/product/component/product_card.dart';
import 'package:advancedflutter/restaurant/component/restaurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타는떡볶이',
      child: Column(
        children: [
          RestaurantCard(
            image: Image.asset('asset/img/food/ddeok_bok_gi.jpg'),
            name: '불타는떡볶이',
            tags: ['ㅇ', 'ㄹ', 'ㅎ'],
            ratingsCount: 100,
            deliveryTime: 30,
            deliveryFee: 3000,
            ratings: 3.5,
            isDetail: true,
            detail: 'asdfadsfg',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ProductCard(),
          ),
        ],
      ),
    );
  }
}
