import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import '../../models/categories_model.dart';
import '../../shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopLayOutStates>(
        listener: (context, state) {
          if(state is ShopSuccessChangeFavoritesState)
            {
              if(!state.model.status){
                showToast(text: state.model.message, state: ToastState.ERROR);
              }
            }
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ShopAppCubit.get(context).homeModel != null &&
                ShopAppCubit.get(context).categoriesModel != null,
            builder: (context) => productsBuilder(
                ShopAppCubit.get(context).homeModel!,
                ShopAppCubit.get(context).categoriesModel!, context),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget productsBuilder(HomeModel model, CategoriesModel categoriesModel , context) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CarouselSlider(
              items: model.data.banners
                  .map((e) => Image(
                        image: NetworkImage(e.image),
                        width: double.infinity,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Categories',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                color: ShopAppCubit.get(context).isDark? Colors.white : Colors.black,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 100.0,
              child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      buildCategoriesItem(categoriesModel.data.data[index]),
                  separatorBuilder: (context, index) => SizedBox(
                        width: 10.0,
                      ),
                  itemCount: categoriesModel.data.data.length,
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              'Products',
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600,
                color: ShopAppCubit.get(context).isDark? Colors.white : Colors.black,

              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.73,
                children: List.generate(
                  model.data.products.length,
                  (index) => buildGridProduct(model.data.products[index] , context),
                ),
              ),
            )
          ]),
        ),
      );

  Widget buildGridProduct(ProductModel model , context) => Container(
    color: ShopAppCubit.get(context).isDark? HexColor('333333'): Colors.white ,
    child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
              Image(
                image: NetworkImage(model.image),
                width: double.infinity,
                height: 200.0,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'DICOUNT',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ]),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.old_price.round()}',
                          style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopAppCubit.get(context).changeFavorites(model.id);
                          print(model.id);
                        },
                        icon: Icon(
                          Icons.favorite,
                          size: 22,
                          color: ShopAppCubit.get(context).favorites[model.id]! ? Colors.red : Colors.grey,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildCategoriesItem(DataModel model) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
          image: NetworkImage(model.image),
        height: 100.0,
        width: 100.0,
      ),
      Container(
        width: 100.0,
        color: Colors.black.withOpacity(.8),
        child: Text(
          model.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white),
        ),
      ),
    ],
  );
}
