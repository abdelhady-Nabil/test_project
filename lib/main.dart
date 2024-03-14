


import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/layout_screen.dart';
import 'package:project2/shared/bloc_observer.dart';
import 'package:project2/shared/cache_helper.dart';
import 'package:project2/splash_screen.dart';
import 'package:project2/strart_screen.dart';

import 'consteant.dart';
import 'cubit/cubit.dart';
import 'home_screen.dart';
import 'login_screen.dart';

main()async{
  Bloc.observer = const SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Firebase initialization error: $e');
  }
  await CacheHelper.init();

  Widget widget;

  uid=CacheHelper.getData(key:'userId');

  if(uid != null){
    widget = HomeScreen();
  }else{
    widget = SplashScreen();
  }



  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
              create:(BuildContext context)=>SokarCubit()..getUserData()
          ),
        ],
        child: MyApp(
          startWidget :widget,
        ),
      ));
  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key,required this.startWidget}) : super(key: key);
  final Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'cairo',
          primaryColor: PrimaryColor,
          hintColor: threeColor,
          primarySwatch: Colors.blue
      ),
      title: 'Flutter Demo',
      home:  startWidget,
    );
  }
}

