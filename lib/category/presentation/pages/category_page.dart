import 'package:cubit_learn/base/size_config.dart';
import 'package:cubit_learn/category/data/models/category_response.dart';
import 'package:cubit_learn/category/presentation/manager/category_cubit.dart';
import 'package:cubit_learn/category/presentation/manager/category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late BuildContext currentContext;
  CategoryResponse? categoryResponse;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: BlocProvider<CategoryCubit>(
        create: (_) => sl<CategoryCubit>(),
        child: BlocConsumer<CategoryCubit, CategoryState>(
          listener: (context, state){
            print("CategoryPage CategoryCubit: ${state}");
            if(state is CategoryLoading){

            } else
            if(state is CategoryLoaded){
              categoryResponse = state.categoryResponse;
            } else
            if(state is CategoryError){

            }
          },
          builder: (context, state){
            currentContext = context;
            if(state is InitialCategory){
              fetchData();
            }
            return categoryResponse != null ? Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! * 0.05),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight! * 0.06,),
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.05),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Xin chào", style: TextStyle(fontSize: SizeConfig.screenWidth! * 0.04, color: Colors.black),),
                              Text("Đến với shop của Duy", style: TextStyle(fontSize: SizeConfig.screenWidth! * 0.045, fontWeight: FontWeight.bold, color: Colors.black),),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(SizeConfig.screenWidth! * 0.03),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(.2),
                                    borderRadius: BorderRadius.circular(SizeConfig.screenWidth! * 0.02, )
                                ),
                                child: Icon(Icons.search, size: SizeConfig.screenWidth! * 0.06, color: Colors.black,),
                              ),
                              SizedBox(width: SizeConfig.screenWidth! * 0.03,),
                              Container(
                                padding: EdgeInsets.all(SizeConfig.screenWidth! * 0.03),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(.2),
                                    borderRadius: BorderRadius.circular(SizeConfig.screenWidth! * 0.02)
                                ),
                                child: Icon(Icons.notifications_on_outlined, size: SizeConfig.screenWidth! * 0.06, color: Colors.black,),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * 0.06,),
                    Container(
                      height: SizeConfig.screenHeight! * 0.82,
                      child:  ListView(
                        children: items(),
                      ),
                    )
                  ],
                ),
              ),
            ) : Container();
          },
        ),
      ),
    );
  }

  List<Widget> items(){
    return categoryResponse!.products!.map((e) => Container(
      margin: EdgeInsets.only(bottom: SizeConfig.screenHeight! * 0.04),
      child: Column(
        children: [
          Image.network(e.images!.first, height: 200, width: 500,),
          SizedBox(height: SizeConfig.screenHeight! * 0.01,),
          Text(e.title!, style: TextStyle(fontSize: SizeConfig.screenWidth! * 0.06, fontWeight: FontWeight.bold),),
          SizedBox(height: SizeConfig.screenHeight! * 0.01,),
          Text("\$ ${e.price.toString()}", style: TextStyle(fontSize: SizeConfig.screenWidth! * 0.05),),
        ],
      ),
    )).toList();
  }

  void fetchData(){
    BlocProvider.of<CategoryCubit>(currentContext).fetchData();
  }
}
