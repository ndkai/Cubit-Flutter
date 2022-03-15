import 'package:cubit_learn/category/data/models/category_response.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable{
  const CategoryState();
}

class InitialCategory extends CategoryState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CategoryLoading extends CategoryState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CategoryLoaded extends CategoryState{
  final CategoryResponse categoryResponse;

  CategoryLoaded(this.categoryResponse);
  @override
  // TODO: implement props
  List<Object?> get props => [categoryResponse];
}

class CategoryError extends CategoryState{
  final String error;

  CategoryError(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}