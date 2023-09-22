import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/Bloc/Home_Bloc/home_cubit.dart';
import 'package:socialapp/Shared/Network/Local/cache_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  void getUserOnSignIn(context) {
    HomeCubit.get(context).getUserData();
  }

  Future<void> signInWithEmailAndPassword(
      {required email, required password}) async {
    emit(LoginLoadingState());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      )
          .then((value) {
        CacheHelper.putData(key: 'UserDocId', value: value.user!.uid);
        emit(LoginSuccessState(uId: value.user!.uid));
        Fluttertoast.showToast(
            msg: "Welcome ${value.user!.email}!",
            fontSize: 15,
            backgroundColor: Colors.green,
            gravity: ToastGravity.CENTER);
      });
    } on FirebaseAuthException catch (exception) {
      emit(LoginErrorState());
      if (exception.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: 'No user found for that email.',
            fontSize: 15,
            backgroundColor: Colors.red,
            gravity: ToastGravity.CENTER);
      } else if (exception.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: 'Wrong password provided for that user.',
            fontSize: 15,
            backgroundColor: Colors.red,
            gravity: ToastGravity.CENTER);
      } else {
        Fluttertoast.showToast(
            msg: 'Authentication error: ${exception.message}',
            fontSize: 15,
            backgroundColor: Colors.red,
            gravity: ToastGravity.CENTER);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Unexpected error: $e',
          fontSize: 15,
          backgroundColor: Colors.red,
          gravity: ToastGravity.CENTER);
    }
  }

  bool seenPassword = true;

  void changePasswordVisibility() {
    seenPassword = !seenPassword;
    emit(ChangePasswordVisibilityState());
  }
}
