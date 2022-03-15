import 'dart:developer';

import 'package:cubit_learn/category/data/models/category_response.dart';
import 'package:dio/dio.dart';

abstract class CategoryDataSource{
  Future<CategoryResponse> fetchCategoryData();
}

class CategorDatasourceImpl extends CategoryDataSource{
  final Dio dio;

  CategorDatasourceImpl(this.dio);


  @override
  Future<CategoryResponse> fetchCategoryData() {
    return _fetchCategoryData();
  }

  Future<CategoryResponse> _fetchCategoryData() async{
    Response response = await dio.get("https://dummyjson.com/products")
        .timeout(Duration(seconds: 60));
    // log("_fetchCategoryData ${response.data}");
    try{
      if(response.statusCode == 200){
        return CategoryResponse.fromJson(response.data);
      } else {
        return CategoryResponse(error: response.data);
      }
    } catch(e){
      print("_fetchCategoryData e ${e}");
      return CategoryResponse(error: "e");
    }
  }

}