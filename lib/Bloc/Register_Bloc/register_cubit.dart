import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Home_Bloc/home_cubit.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);
  void getUserOnSignUp(context) {
    HomeCubit.get(context).getUserData();
  }

  Future<void> createUserWithEmailAndPassword({
    @required email,
    @required password,
    @required name,
    @required phone,
  }) async {
    emit(RegisterLoadingState());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) {
        Fluttertoast.showToast(
            msg: "Success!",
            fontSize: 30,
            backgroundColor: Colors.green,
            gravity: ToastGravity.CENTER);
        createUser(
            email: email.text,
            name: name.text,
            phone: phone.text,
            uId: value.user?.uid,
            isEmailVerified: false);
      });
    } on FirebaseAuthException catch (exception) {
      emit(RegisterErrorState());
      if (exception.code == 'weak-password') {
        Fluttertoast.showToast(
            msg: 'The password provided is too weak.',
            fontSize: 15,
            backgroundColor: Colors.red,
            gravity: ToastGravity.CENTER);
      } else if (exception.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.',
            fontSize: 15,
            backgroundColor: Colors.red,
            gravity: ToastGravity.CENTER);
      }
    } catch (e) {
      print(e);
    }
  }

  void createUser(
      {@required email,
      @required name,
      @required phone,
      @required uId,
      @required isEmailVerified}) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.add({
      'name': name,
      'phone': phone,
      'email': email,
      'uId': uId,
      'isEmailVerified': isEmailVerified
    }).then((value) {
      emit(CreateUserSuccessState(uId));
    }).catchError((error) {
      print(error.toString());
      emit(CreateUserErrorState());
    });
  }

  bool seenPassword = true;

  void changePasswordVisibility() {
    seenPassword = !seenPassword;
    emit(ChangePasswordVisibilityState());
  }
}
