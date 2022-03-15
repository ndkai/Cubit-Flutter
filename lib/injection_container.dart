import 'package:connectivity/connectivity.dart';
import 'package:cubit_learn/category/data/data_sources/category_datasource.dart';
import 'package:cubit_learn/category/data/repositories/category_repo_impl.dart';
import 'package:cubit_learn/category/domain/repositories/category_repo.dart';
import 'package:cubit_learn/category/domain/use_cases/fetch_category_uc.dart';
import 'package:cubit_learn/category/presentation/manager/category_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
   //bloc
  sl.registerFactory(
        () => CategoryCubit(sl()),
  );

  //usecase
  sl.registerLazySingleton(() => FetchCategoryUc(sl()));

  // repo
  sl.registerLazySingleton<CategoryRepo>(
          () => CategoryRepoImpl(sl(), sl()));

  //datasourse
  sl.registerLazySingleton<CategoryDataSource>(
        () => CategorDatasourceImpl(sl()),
  );

  // core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //external
  // final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
    sl.registerLazySingleton(() => Connectivity());
}
