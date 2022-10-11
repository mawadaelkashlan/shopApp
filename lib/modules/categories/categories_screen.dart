import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';

import '../../shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit , ShopLayOutStates>(
      listener:  (context,state){},
      builder: (context,state) => ListView.separated(
        itemBuilder: (context,index)=> buildCatItem(ShopAppCubit.get(context).categoriesModel!.data.data[index]),
        separatorBuilder: (context, index) => myDivider() ,
        itemCount: ShopAppCubit.get(context).categoriesModel!.data.data.length,
      ),
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 15.0,),
        Text(model.name , style: TextStyle( fontSize: 20),),
        Spacer(),
        Icon(Icons.arrow_forward_ios_outlined)
      ],
    ),
  );
}
