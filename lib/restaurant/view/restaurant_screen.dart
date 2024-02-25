import 'package:advancedflutter/common/model/cursor_pagination_model.dart';
import 'package:advancedflutter/restaurant/component/restaurant_card.dart';
import 'package:advancedflutter/restaurant/model/restaurant_model.dart';
import 'package:advancedflutter/restaurant/provider/restaurant_provider.dart';
import 'package:advancedflutter/restaurant/repository/restaurant_repository.dart';
import 'package:advancedflutter/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(scrollListener);
  }
  void scrollListener(){

    if(controller.offset > controller.position.maxScrollExtent - 300 ){
      ref.read(restaurantProvider.notifier).paginate(
          fetchMore: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(restaurantProvider);

    //완전 처음 로딩일 때
    if(data is CursorPaginationLoading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (data is CursorPaginationError){
      return Center(
        child: Text(data.message),
      );
    }

    //CursorPatingaion
    //CursorPatingaionFetchingMore
    //CursorPatingaionRefetching

    final cp = data as CursorPagination;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          controller: controller,
          itemCount: cp.data.length,
          itemBuilder: (_, index) {
            final pItem = cp.data[index];
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
        ),
    );
  }
}
