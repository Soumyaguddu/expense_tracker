import 'package:expense_tracker/blocs/ui/first_screen.dart';
import 'package:expense_tracker/blocs/ui/second_screen.dart';
import 'package:expense_tracker/sms_fetch_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../internet_cubit/internet_cubit.dart';

class Routes {

   static const  String first_screen = "/first";
   static const  String second_screen = "/second";
   static const  String sms_view_screen = "/sms_view";

  static Route? onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case first_screen :
        return MaterialPageRoute(builder: (context) =>
            BlocProvider(create: (context) => InternetCubit(),child: const FirstScreen(),));
      case second_screen :
        return MaterialPageRoute(builder: (context) =>
            BlocProvider(create: (context) => InternetCubit(),child:  SecondPage(),));
        case sms_view_screen :
        return MaterialPageRoute(builder: (context) =>
            BlocProvider(create: (context) => InternetCubit(),child: const SmsFetchScreen(),));
    }
  }
}