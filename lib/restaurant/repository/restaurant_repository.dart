import 'package:advancedflutter/common/const/data.dart';
import 'package:advancedflutter/common/dio/dio.dart';
import 'package:advancedflutter/common/model/cursor_pagination_model.dart';
import 'package:advancedflutter/restaurant/model/restaurant_detail_model.dart';
import 'package:advancedflutter/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  final dio = ref.watch(dioProvidor);

  final repository =
      RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');

  return repository;
});

@RestApi()
abstract class RestaurantRepository {
  //baseUrl : http://$ip/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  //http://$ip/restaurant/
  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<RestaurantModel>> paginate();

  //http://$ip/restaurant/:id
  @GET('/{id}')
  @Headers({'accessToken': 'true'})
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path('id') required String id,
  });
}
