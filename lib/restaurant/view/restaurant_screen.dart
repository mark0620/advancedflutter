import 'package:advancedflutter/common/const/data.dart';
import 'package:advancedflutter/common/dio/dio.dart';
import 'package:advancedflutter/restaurant/component/restaurant_card.dart';
import 'package:advancedflutter/restaurant/model/restaurant_model.dart';
import 'package:advancedflutter/restaurant/repository/restaurant_repository.dart';
import 'package:advancedflutter/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({
    Key? key,
  }) : super(key: key);

  Future<List<RestaurantModel>> paginateRestaurant(WidgetRef ref) async {
    final dio = ref.watch(dioProvidor);

    final resp = await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant').paginate();

    return resp.data;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<List<RestaurantModel>>(
            future: paginateRestaurant(ref),
            builder: (context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator(),);
              }
              return ListView.separated(
                itemBuilder: (_, index) {
                  final pItem = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RestaurantDetailScreen(
                            id: pItem.id,
                          ),
                        ),
                      );
                    },
                    child: RestaurantCard.fromModel(model: pItem),
                  );
                },
                separatorBuilder: (_, index) {
                  return SizedBox(height: 16.0);
                },
                itemCount: snapshot.data!.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
