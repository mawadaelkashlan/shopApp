import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';


class DefaultFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  late String? validate;
  ValueChanged<String>? onSubmit;
  ValueChanged<String>? onChange;
  GestureTapCallback? onTap;
  final String label;
  final IconData prefix;
  bool? isPassword = false;
  IconData? suffix;
  VoidCallback? suffixPressed;
  bool? isClickable = true;

  DefaultFormField({
    required this.controller,
    required this.type,
    this.validate,
    this.onSubmit,
    this.onChange,
    required this.label,
    required this.prefix,
    this.isPassword,
    this.suffix,
    this.suffixPressed,
    this.onTap,
    this.isClickable,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '${validate}';
        }
        return null;
      },
      onTap: onTap,
      obscureText: isPassword ?? false,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
        )),
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPressed,
              )
            : null,
      ),
    );
  }
}

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required VoidCallback function,
  required String text,
}) => Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({required String text, required VoidCallback function,}) => TextButton(
onPressed: function,
child: Text(text.toUpperCase()),);

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

void showToast ({
  required String text,
  required ToastState state})=> Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: chooseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,

);

enum ToastState {SUCCESS, ERROR , WARNING}

Color chooseToastColor(ToastState state){
  late Color color;
  switch (state)
  {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget myDivider () => Padding(
  padding: const EdgeInsets.symmetric(
      horizontal: 10.0),
  child: Container(
    height: 1,
    color: Colors.grey,
  ),
);

Widget buildListProduct(model, context, {bool isOldPrice = true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      children: [
        Container(
          height: 120.0,
          width: 120.0,
          child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: double.infinity,
                  height: 120.0,
                  fit: BoxFit.cover,
                ),
                if (model.discount != 0 && isOldPrice)
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
        ),
        SizedBox(width: 10.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    model.price.toString(),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if (model.discount != 0 && isOldPrice)
                    Text(
                      model.oldPrice.toString(),
                      style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      ShopAppCubit.get(context).changeFavorites(model.id!);
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
  ),
);
