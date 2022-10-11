import 'package:shop_app/models/change_favorites.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopLayOutStates{}

class ShopInitialState extends ShopLayOutStates{}

class ChangeBottomNavState extends ShopLayOutStates{}

class ShopChangeModeState extends ShopLayOutStates{}

class ShopLoadingHomeDataState extends ShopLayOutStates{}

class ShopSuccessHomeDataState extends ShopLayOutStates{}

class ShopErrorHomeDataState extends ShopLayOutStates{}

class ShopSuccessCategoriesDataState extends ShopLayOutStates{}

class ShopErrorCategoriesDataState extends ShopLayOutStates{}

class ShopSuccessChangeFavoritesState extends ShopLayOutStates{
   final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);

}

class ShopSuccessChangeFavoritesMapState extends ShopLayOutStates{}

class ShopErrorChangeFavoritesState extends ShopLayOutStates{}
class ShopLoadingGetFavoritesState extends ShopLayOutStates{}

class ShopSuccessGetFavoritesDataState extends ShopLayOutStates{}

class ShopErrorGetFavoritesDataState extends ShopLayOutStates{}

class ShopLoadingUserDataState extends ShopLayOutStates{}

class ShopSuccessUserDataState extends ShopLayOutStates{
  final LoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopLayOutStates{}

class ShopLoadingUpdateUserDataState extends ShopLayOutStates{}

class ShopSuccessUpdateUserDataState extends ShopLayOutStates{
  final LoginModel loginModel;

  ShopSuccessUpdateUserDataState(this.loginModel);
}

class ShopErrorUpdateUserDataState extends ShopLayOutStates{}