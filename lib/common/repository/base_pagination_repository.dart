import 'package:advancedflutter/common/model/cursor_pagination_model.dart';
import 'package:advancedflutter/common/model/model_with_id.dart';
import 'package:advancedflutter/common/model/pagination_params.dart';

abstract class IBasePaginationRepository<T extends IModelWithId>{//I : interface
  Future<CursorPagination<T>> paginate({
    PaginationParams? paginationParams = const PaginationParams(),
  });
}