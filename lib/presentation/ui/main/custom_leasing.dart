import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kanooniha/common/appCommons/appRoutes.dart';
import 'package:kanooniha/core/navigationService/NavigationService.dart';

class CustomLeading extends StatelessWidget {
  const CustomLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      if(Navigator.canPop(context)){
        GetIt.I.get<NavigationServiceImpl>().pop();
      }else{
        GetIt.I.get<NavigationServiceImpl>().off(AppRoutes.home);
      }

    }, icon: const Icon(Icons.arrow_back_ios));
  }
}
