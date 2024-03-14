




import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project2/login_screen.dart';

import '../consteant.dart';
import '../model/user_model.dart';
import '../shared/cache_helper.dart';
import 'states.dart';

class SokarCubit extends Cubit<SokarState>{

  SokarCubit() : super(SokarInitialState());

  static SokarCubit get(context) => BlocProvider.of(context);

  //indecator progress
  bool showSpinner = false;

  void playSpinner(){
    showSpinner=true;

  }

  bool obsecuer = true;

  void openObsecuer(){
    obsecuer = false;
    emit(OpenObsecuerState());
  }

  void closeObsecuer(){
    obsecuer = true;
    emit(OpenObsecuerState());
  }




  //register user
  Future<void> userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    try {
      var value = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      uid =value.user!.uid; //gamedddddddd ya abdoooooo wallahyyyyyyyyyy
      await userCreate(
        uid: value.user!.uid,
        email: email,
        password: password,
        name: name,
        phone: phone
      );
      emit(RegisterSuccessState());
    } catch (error) {
      print("Error during user registration: $error");
      emit(RegisterErrorState());
    }
  }

  //use it in userRegister above
  Future<void> userCreate({
    required String email,
    required String name,
    required String phone,
    required String password,
    required String uid,
  }) async {
    UserModel model = UserModel(
      email: email,
      password: password,
      userId: uid,
      name: name,
      phone: phone
    );
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(model.toMap());
      emit(CreateUserSuccessState());
    } catch (error) {
      print("Error during user creation: $error");
      emit(CreateUserErrorState());
    }
  }




  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      var value = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccessState(value.user!.uid));
    } catch (error) {
      print("Error during user login: $error");
      emit(LoginErrorState());
    }
  }

  UserModel? model;

  Future<void> getUserData() async {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      print(value.data()); // is map
      print(uid);
      print('ddddddddddddddd');
      print('${value.id}');
      uid=value.id;
      model = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState());
    });
  }



  void signOut(context) {
    CacheHelper.removeDate(key: 'userId')
        .then((value) {
      if (value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }



}