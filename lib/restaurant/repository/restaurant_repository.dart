import 'package:advancedflutter/common/model/cursor_pagination_model.dart';
import 'package:advancedflutter/restaurant/model/restaurant_detail_model.dart';
import 'package:advancedflutter/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';


@RestApi()
abstract class RestaurantRepository{
  //baseUrl : http://$ip/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl})
   = _RestaurantRepository;

  //http://$ip/restaurant/
  @GET('/')
  @Headers({
    'accessToken' : 'true'
  })
  Future<CursorPagination<RestaurantModel>>paginate();

  //http://$ip/restaurant/:id
  @GET('/{id}')
  @Headers({
    'accessToken' : 'true'
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path('id') required String id,
});

}