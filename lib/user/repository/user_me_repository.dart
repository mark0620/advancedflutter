import 'package:advancedflutter/common/const/data.dart';
import 'package:advancedflutter/common/dio/dio.dart';
import 'package:advancedflutter/user/model/user_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'user_me_repository.g.dart';

final userMeRepositoryProvider = Provider<UserMeRepository>((ref){
  final dio = ref.watch(dioProvidor);
  
  return UserMeRepository(dio,baseUrl: 'http://$ip/user/me');
});

//http://$ip/user/me
@RestApi()
abstract class UserMeRepository{
  factory UserMeRepository(Dio dio, {String baseUrl}) = _UserMeRepository;

  @GET('/')
  @Headers({
    'accessToken' : 'true',
  })
  Future<UserModel> getMe();

}