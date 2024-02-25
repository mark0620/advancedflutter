import 'package:advancedflutter/common/model/cursor_pagination_model.dart';
import 'package:advancedflutter/common/model/pagination_params.dart';
import 'package:advancedflutter/restaurant/model/restaurant_model.dart';
import 'package:advancedflutter/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);
    final notifier = RestaurantStateNotifier(repository: repository);
    return notifier;
  },
);

class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;

  RestaurantStateNotifier({
    required this.repository,
  }) : super(CursorPaginationLoading()) {
    paginate();
  }

  void paginate({
    int fetchCount = 20,

    //true면 추가로 데이터 가져오기
    //false - 새로고침(현재 상태를 덮어씌움)
    bool fetchMore = false,
    //강제로 다시 로딩하기
    //true : cursorPaginationLoading()
    bool forceRefetch = false,
  }) async {
    //5가지 가능성
    //현재 CursorPaginationBase의 상태들

    //1) CursorPagination - 정상적으로 데이터가 있는 상태
    //2) CursorPaginationLoading - 데이터가 로딩중인 상태(현재 캐시 없음)
    //3) CursorPaginationError - 에러가 있는 상태
    //4) CursorPaginationRefetching - 첫번째페이지부터 다시 테이터를 가져올때
    //5) CursorPaginationFetchMore - 추가 데이터를 paginate해오라는 요청을 받을 때

    //바로 반환하는 상황 먼저 코딩
    //1] hasmore == false(기존 상태에서 이미 다음 데이터가 없다는 값을 들고 있다면)
    //2] 로딩중 -> fetchMore가 true일때
    //            fetchMore가 false일때는 새로고침의 의도가 있다. -> 반환하지 않음
    if (state is CursorPagination && !forceRefetch) {
      final pState = state as CursorPagination;
      if (!pState.meta.hasMore) {
        return;
      }
    }
    final isLoading = state is CursorPaginationLoading;
    final isRefetching = state is CursorPaginationRefetching;
    final isFetchingMore = state is CursorPaginationFetchingMore;

    //2] 반환 상황
    if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
      return;
    }

    //PaginationParams생성
    PaginationParams paginationParams = PaginationParams(
      count: fetchCount,
    );

    //fetchMore상황 : 데이터를 추가로 가져오는 상황
    if (fetchMore) {
      final pState = state as CursorPagination;
      state = CursorPaginationFetchingMore(
        meta: pState.meta,
        data: pState.data,
      );

      paginationParams = paginationParams.copyWith(
        after: pState.data.last.id,
      );
    }

    final resp = await repository.paginate(
      paginationParams: paginationParams,
    );

    if(state is CursorPaginationFetchingMore){
      final pState = state as CursorPaginationFetchingMore;

      //기존 데이터에 새로운 데이터 추가
      state = resp.copyWith(
        data: [
          ...pState.data,
          ...resp.data,
        ],
      );
    }
  }
}
