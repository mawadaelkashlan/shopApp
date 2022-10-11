import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'layout/shop_layout.dart';
import 'shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/components/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  Widget widget;
  bool? onBoarding = CacheHelper.getBoolean(key: 'onBoarding');
  token = CacheHelper.getString(key: 'token')??'';
  print(token);

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();
  } else {
    widget = OnBoradingScreen();
  }

  runApp(MyApp(isDark = false, widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final bool isDark;

  MyApp(
    this.isDark,
    this.startWidget,
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(
          create: (context) => ShopAppCubit()
            ..getHomeData()
            ..getCategoriesData()..getFavoritesData()..getUserData(),
        )
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
