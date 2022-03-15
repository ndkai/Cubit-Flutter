import 'package:cubit_learn/category/data/models/category_response.dart';
import 'package:cubit_learn/core/error/failures.dart';
import 'package:either_dart/either.dart';

abstract class CategoryRepo{
  Future<Either<Failure, CategoryResponse>> fetchCategory();
}