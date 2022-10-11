import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit , ShopLayOutStates>(
      listener:  (context,state){},
      builder: (context,state)
      {
              return ConditionalBuilder(
                condition: state is !ShopLoadingGetFavoritesState ,
                builder: (context) => ListView.separated(
                  itemBuilder: (context, index) => buildListProduct(
                      ShopAppCubit.get(context)
                          .favoritesModel!
                          .data!
                          .data![index].product!,
                      context),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: ShopAppCubit.get(context)
                      .favoritesModel!
                      .data!
                      .data!
                      .length,
                ),
                fallback: (context)=> Center(child: CircularProgressIndicator()),
              );
            });
  }


}
