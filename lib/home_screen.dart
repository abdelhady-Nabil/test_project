import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/cubit/cubit.dart';
import 'package:project2/cubit/states.dart';


import 'login_screen.dart';
import 'model/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserModel model;

  @override
  void initState() {
    super.initState();
    SokarCubit.get(context).getUserData().then((_) {
      setState(() {
        model = SokarCubit.get(context).model!;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SokarCubit()..getUserData(),
      child: BlocBuilder<SokarCubit, SokarState>(
        builder: (context, state) {
          final superCubit = context.read<SokarCubit>();
          UserModel? model = superCubit.model;

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/mann.png'),
                          radius: 25,
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('welcome back', style: TextStyle(fontSize: 12)),
                            Text(
                              model?.name ?? 'Loading...',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            )
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            SokarCubit.get(context).signOut(context);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          },
                          icon: Icon(Icons.logout),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('How Are You ', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Text('Feeling Today ?', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                              height: 170,
                              decoration: BoxDecoration(
                                  color: Colors.orange[200],
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(

                                        child: Icon(Icons.chat,color: Colors.white,),
                                      backgroundColor: Colors.orange,

                                    ),
                                    SizedBox(
                                      height: 35,
                                    ),
                                    Text('Consultation',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                    SizedBox(
                                      height:5,
                                    ),
                                    Text('50 Doctors',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),


                                  ],
                                ),
                              ),
                            )
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: Container(
                              height: 170,
                              decoration: BoxDecoration(
                                  color: Colors.deepPurple[200],
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(

                                      child: Icon(Icons.cases_outlined,color: Colors.white,),
                                      backgroundColor: Colors.deepPurple,

                                    ),
                                    SizedBox(
                                      height: 35,
                                    ),
                                    Text('Pharmacy',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                    SizedBox(
                                      height:5,
                                    ),
                                    Text('10 Pharma',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),


                                  ],
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text('My Health', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.heart_broken_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Heart Rate',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('last',style: TextStyle(fontSize: 18,),),
                            Text('Monument',style: TextStyle(fontSize: 18,),),

                            SizedBox(
                              height:25,
                            ),
                            Row(
                              children: [
                                Text('78/ ',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                                Text('bpm',style: TextStyle(fontSize: 18,),),

                              ],
                            ),

                          ],
                        ),
                      ),
                    )




                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
