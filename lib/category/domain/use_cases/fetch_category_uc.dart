import 'package:cubit_learn/category/data/models/category_response.dart';
import 'package:cubit_learn/category/domain/repositories/category_repo.dart';
import 'package:cubit_learn/core/error/failures.dart';
import 'package:cubit_learn/core/usecase/usecase.dart';
import 'package:either_dart/either.dart';

class FetchCategoryUc implements UseCase<CategoryResponse, NoParams> {
  final CategoryRepo categoryRepo;

  FetchCategoryUc(this.categoryRepo);

  @override
  Future<Either<Failure, CategoryResponse>> call(NoParams params) async {
    return categoryRepo.fetchCategory();
  }
}
