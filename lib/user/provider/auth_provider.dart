import 'package:advancedflutter/common/const/data.dart';
import 'package:advancedflutter/common/dio/dio.dart';
import 'package:advancedflutter/common/view/root_tab.dart';
import 'package:advancedflutter/common/view/splash_screen.dart';
import 'package:advancedflutter/order/view/order_done_screen.dart';
import 'package:advancedflutter/restaurant/view/basket_screen.dart';
import 'package:advancedflutter/restaurant/view/restaurant_detail_screen.dart';
import 'package:advancedflutter/user/model/user_model.dart';
import 'package:advancedflutter/user/provider/user_me_provider.dart';
import 'package:advancedflutter/user/repository/auth_repository.dart';
import 'package:advancedflutter/user/view/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvidor);

  return AuthRepository(baseUrl: 'http://$ip/auth', dio: dio);
});

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  List<GoRoute> get routes => [
        GoRoute(
            path: '/',
            name: RootTab.routeName,
            builder: (_, __) => RootTab(),
            routes: [
              GoRoute(
                path: 'restaurant/:rid',
                name: RestaurantDetailScreen.routeName,
                builder: (_, state) => RestaurantDetailScreen(
                  id: state.pathParameters['rid']!,
                ),
              ),
            ]),
        GoRoute(
          path: '/basket',
          name: BasketScreen.routeName,
          builder: (_, state) => BasketScreen(),
        ),
        GoRoute(
          path: '/order_done',
          name: OrderDoneScreen.routeName,
          builder: (_, state) => OrderDoneScreen(),
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (_, __) => SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (_, __) => LoginScreen(),
        ),
      ];

  void logout() {
    ref.read(userMeProvider.notifier).logout();
  }

  //SplashScreen
  //앱을 처음 시작했을 때 토큰이 존재하는지 확인하고 로그인 스크린으로 보내줄
  //홈 스크린으로 보내줄지 확인하는 과정이 필요하다.
  String? redirectLogic(_, GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);
    final logginIn = state.location == '/login';

    //유저 정보가 없는데 로그인중이면 로그인 페이지에 두고
    //만약에 로그인중이 아니라면 로그인 페이지로 이동
    if (user == null) {
      return logginIn ? null : '/login';
    }
    //user가 null이 아님

    //userModel
    //사용자 정보가 있는 상태라면 로그인중이거나 현재 위치가 SplashScreen이면
    //home으로 이동
    if (user is UserModel) {
      return logginIn || state.location == '/splash' ? '/' : null;
    }

    //UserModelError
    if (user is UserModelError) {
      return !logginIn ? 'login' : null;
    }

    return null;
  }
}
