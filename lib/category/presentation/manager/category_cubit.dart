import 'package:cubit_learn/category/domain/use_cases/fetch_category_uc.dart';
import 'package:cubit_learn/category/presentation/manager/category_state.dart';
import 'package:cubit_learn/core/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState>{

  final FetchCategoryUc fetchCategoryUc;

  CategoryCubit(this.fetchCategoryUc): super(InitialCategory());

  void loading() => emit(CategoryLoading());

  Future<void> fetchData() async {
     var data = await fetchCategoryUc(NoParams());
     return emit(
         data.fold(
                 (l) => CategoryError(l.msg),
                 (r) => r.error == null? CategoryLoaded(r) : CategoryError(r.error.toString())));
  }


}