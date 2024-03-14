import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:project2/shared/cache_helper.dart';
import 'package:project2/signup_screen.dart';

import 'consteant.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'home_screen.dart';
import 'layout_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController  _EmailTextController = TextEditingController();
  final TextEditingController  _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SokarCubit(),
      child: BlocConsumer<SokarCubit, SokarState>(
        listener: (context,state ){
          if(state is LoginSuccessState){
            //SuperCubit.get(context).model;
            SokarCubit.get(context).getUserData();

            CacheHelper.saveData(
                key: 'userId',
                value: state.uid
            ).then((value)async{
              uid =state.uid;
              print('hereeeeeee');
              print(uid);
              SokarCubit.get(context).getUserData();

              await FirebaseFirestore.instance.collection('users').doc(uid).snapshots().forEach((element) {
                if(element.data()?['emil'] ==_EmailTextController.text && element.data()?['password']==_passwordController.text){
                  print('i user');
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LayoutScreen()));
                }else{
                  showModalBottomSheet(context: context, builder: (context){
                    return Container(
                      height: 300,
                      color: Colors.red,
                      child: Center(
                        child: Column(
                          children: [
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                            }, child:Column(
                              children: [
                                Text('Email or Password isnot correct',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                                Text('back to login',style: TextStyle(color: Colors.black),),
                              ],
                            )),
                          ],
                        ),
                      ),
                    );
                  }
                  );
                }
              });

            }).catchError((error){});
          }
          if(state is LoginErrorState){
            showModalBottomSheet(context: context, builder: (context){
              return Container(
                height: 300,
                color: Colors.red,
                child: Center(
                  child: Column(
                    children: [
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      }, child:Column(
                        children: [
                          Text('Email or Password isnot correct',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                          Text('back to login',style: TextStyle(color: Colors.black),),
                        ],
                      )),
                    ],
                  ),
                ),
              );
            }
            );
          }
        },
        builder: (context,state ){
          return Form(
            key: _formKey,
            child: Scaffold(
              body: ModalProgressHUD(
                inAsyncCall: SokarCubit.get(context).showSpinner,
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Login',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Image.asset(
                            'assets/logoo.png', // Path to your logo image
                            width: 150, // Adjust the width as needed
                            height: 150, // Adjust the height as needed
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration:  InputDecoration(
                                label:Text('Enter your Email',style: TextStyle(color: PrimaryColor),),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: PrimaryColor)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: PrimaryColor)
                                ),
                                // border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.email,color: PrimaryColor,)

                            ),
                            cursorColor: PrimaryColor,
                            controller:_EmailTextController ,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Enter your Email";
                              }
                              final bool isValid = EmailValidator.validate(value);
                              if(!isValid){
                                return "invaild Email";
                              }
                              return null;
                            },
                            onChanged: (value){
                              value = _EmailTextController.text;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            obscureText: true,
                            decoration:  InputDecoration(
                              label:Text('Enter your password',style: TextStyle(color: PrimaryColor),),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: PrimaryColor)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: PrimaryColor)
                              ),
                              // border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock,color: PrimaryColor,),
                              suffixIcon: Icon(Icons.remove_red_eye,color: PrimaryColor,),

                            ),
                            cursorColor: PrimaryColor,
                            controller:_passwordController ,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Enter your password";
                              }
                            },

                            onChanged: (value){
                              value = _passwordController.text;
                            },
                          ),
                          SizedBox(height: 20),

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     Text('Forgot password ?',style: TextStyle(color: Colors.blue),),
                          //   ],
                          // ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {

                              SokarCubit.get(context).playSpinner();

                              if (_formKey.currentState!.validate()) {
                                await SokarCubit.get(context).userLogin(
                                  email: _EmailTextController.text,
                                  password: _passwordController.text,
                                );

                                SokarCubit.get(context).showSpinner;


                              }
                            },
                            // onPressed: () {
                            //   // Login logic here
                            //   // Navigate to admin or user screen based on the condition
                            //   if (isAdmin) {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(builder: (context) => AdminScreen()),
                            //     );
                            //   } else {
                            //     // Navigate to user screen or sign up screen
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(builder: (context) => UserScreen()),
                            //     );
                            //   }
                            // },
                            child: Text('Login'),
                          ),                        SizedBox(height: 50),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Dont have an account ?'),
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                              }, child: Text('SignUp'))
                            ],
                          ),


                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );

        },
      ),
    );

  }
}



