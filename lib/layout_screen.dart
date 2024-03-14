
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/setting_screen.dart';

import 'chat_screen.dart';
import 'consteant.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'doctor_screen.dart';
import 'home_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int index = 0;
  List<Widget>screens=[
    HomeScreen(),
    ChatScreen(),
    DoctorScreen(),
    SettingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SokarCubit()..getUserData(),
      child: BlocConsumer<SokarCubit,SokarState>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            backgroundColor: Colors.white,
            body: screens[index],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: index,
              onTap: (value){
                setState(() {
                  index=value;
                  screens[index];
                });
              },
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.black,
              selectedItemColor: PrimaryColor,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home'

                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat),
                    label: 'chat'

                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.health_and_safety_outlined),
                    label: 'Doctors'

                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'seeting'

                ),




              ],
            ),
          );
        },

      ),
    );
  }
}
