import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:project2/home_screen.dart';
import 'package:project2/login_screen.dart';
import 'package:project2/signup_screen.dart';

import 'consteant.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'layout_screen.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController  _nameTextController = TextEditingController();
  final TextEditingController  _EmailTextController = TextEditingController();
  final TextEditingController  _phoneEmailController = TextEditingController();
  final TextEditingController  _passwordController = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext contex )=>SokarCubit(),
      child: BlocConsumer<SokarCubit,SokarState>(
        listener: (context,state){
          if (state is RegisterSuccessState) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LayoutScreen()));
          }
        },
        builder: (context,state){
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
                              Text('SignUp',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
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
                          TextFormField(
                            decoration:  InputDecoration(
                                label:Text('Enter your name',style: TextStyle(color: PrimaryColor),),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: PrimaryColor)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: PrimaryColor)
                                ),
                                // border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person,color: PrimaryColor,)

                            ),
                            cursorColor: PrimaryColor,
                            controller:_nameTextController ,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Enter your name";
                              }
                              return null;
                            },
                            onChanged: (value){
                              value = _nameTextController.text;
                            },
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
                                return "this Email is Invalid ";
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
                          TextFormField(
                            decoration:  InputDecoration(
                              label:Text('Enter your phone ',style: TextStyle(color: PrimaryColor),),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: PrimaryColor)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: PrimaryColor)
                              ),
                              // border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.phone,color: PrimaryColor,),
                              prefixText: '+2',
                            ),
                            maxLength: 11,

                            cursorColor: PrimaryColor,
                            controller:_phoneEmailController ,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Enter your phone";
                              }
                              if(value.length < 11){
                                return "this phone is Invalid";
                              }
                              return null;
                            },
                            onChanged: (value){
                              value = _phoneEmailController.text;
                            },
                          ),
                          SizedBox(height: 20),

                          SizedBox(height: 20),

                          Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue
                            ),
                            child:TextButton(
                              onPressed: ()async {

                                SokarCubit.get(context).playSpinner();
                                if (_formKey.currentState!.validate()) {
                                  SokarCubit.get(context).userRegister(
                                    name: _nameTextController.text,
                                    phone: _phoneEmailController.text,
                                    email: _EmailTextController.text,
                                    password: _passwordController.text,
                                  );




                                  //Check if the registration was successful before navigating
                                  if (SokarCubit.get(context).state is RegisterSuccessState) {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LayoutScreen()));
                                  }
                                }
                              },
                              child: const Text('SignUp',style: TextStyle(
                                  color: Colors.white,
                                fontSize: 20
                              ),),
                            ) //Center(child: Text('SignUp',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
                          ),
                          SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('I\'m already have an account ?'),
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                              }, child: Text('Login'))
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

