import 'package:connectivity/connectivity.dart';
import 'package:cubit_learn/category/data/data_sources/category_datasource.dart';
import 'package:cubit_learn/category/data/models/category_response.dart';
import 'package:cubit_learn/category/domain/repositories/category_repo.dart';
import 'package:cubit_learn/core/error/failures.dart';
import 'package:cubit_learn/core/network/network_info.dart';
import 'package:either_dart/src/either.dart';

const String NETWORK_FAILURE_MESSAGE = 'Vui lòng kiểm tra kết nối mạng!';

class CategoryRepoImpl extends CategoryRepo{
  final NetworkInfo networkInfo;
  final CategoryDataSource categoryDataSource;

  CategoryRepoImpl(this.categoryDataSource, this.networkInfo);


  @override
  Future<Either<Failure, CategoryResponse>> fetchCategory() {
    return _fetchCategory(categoryDataSource.fetchCategoryData());
  }

  Future<Either<Failure, CategoryResponse>> _fetchCategory(
      Future<CategoryResponse> getData) async {
    var connected = await networkInfo.isConnected;
    if (connected != ConnectivityResult.none ) {
      try {
        final data = await getData;
        if(data.error != null){
          return Left(ServerFailure(data.error.toString()));
        }
        return Right(data);
      } catch(e) {
        return Left(ServerFailure(e.toString()));
      }
    } else
      return Left(ServerFailure(NETWORK_FAILURE_MESSAGE));
  }


}