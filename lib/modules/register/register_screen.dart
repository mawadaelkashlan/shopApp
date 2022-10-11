import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status) {
              showToast(
                  text: state.loginModel.message, state: ToastState.SUCCESS);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data.token)
                  .then((value) {
                token = state.loginModel.data.token!;
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              print(state.loginModel.message);
              showToast(
                  text: state.loginModel.message, state: ToastState.ERROR);
            }
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Register now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      DefaultFormField(
                          controller: nameController,
                          validate: 'Please enter Name',
                          type: TextInputType.name,
                          label: 'User Name',
                          prefix: Icons.person),
                      SizedBox(
                        height: 30,
                      ),
                      DefaultFormField(
                          controller: emailController,
                          validate: 'Please enter Email Address',
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email_outlined),
                      SizedBox(
                        height: 30,
                      ),
                      DefaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        label: 'Password',
                        validate: 'Password must not be Empty',
                        prefix: Icons.lock,
                        onSubmit: (value) {},
                        isPassword: ShopRegisterCubit.get(context).isPassword,
                        suffix: ShopRegisterCubit.get(context).suffix,
                        suffixPressed: () {
                          ShopRegisterCubit.get(context)
                              .changePasswordVisibility();
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      DefaultFormField(
                          controller: phoneController,
                          validate: 'Please enter Phone',
                          type: TextInputType.phone,
                          label: 'Phone',
                          prefix: Icons.phone),
                      SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingState,
                        builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'Register',
                            isUpperCase: true),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
