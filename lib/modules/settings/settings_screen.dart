import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';

import '../../shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit ,ShopLayOutStates>(
      listener: (context ,state){},
      builder: (context ,state)
      {
        var model = ShopAppCubit.get(context).userModel;
        nameController.text = model!.data.name!;
        emailController.text = model!.data.email!;
        phoneController.text = model!.data.phone!;
        return ConditionalBuilder(
          condition: ShopAppCubit.get(context).userModel != null,
          builder: (context)=> Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: formKey,
              child: Center(
                child: Column(

                  children: [
                    Expanded(child: Container(
                      height: 200.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Image(
                        image: NetworkImage(model.data!.image!),
                        height: 100.0,
                        width: 100.0,
                      ),
                    )),
                    SizedBox(height: 30.0,),
                    DefaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        label: 'Name',
                        validate: 'Name must not be Empty',
                        prefix: Icons.person),
                    SizedBox(height: 20.0,),
                    DefaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        label: 'Email Address',
                        validate: 'email must not be Empty',
                        prefix: Icons.email),
                    SizedBox(height: 20.0,),
                    DefaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        label: 'Phone',
                        validate: 'Phone must not be Empty',
                        prefix: Icons.phone),
                    Spacer(),
                    defaultButton(function: (){
                      if(formKey.currentState!.validate())
                      {
                        ShopAppCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text);
                      }
                    }, text: 'update profile'),
                    SizedBox(height: 30.0,),
                    defaultButton(function: (){
                      signOut(context);
                    }, text: 'LogOut')
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
