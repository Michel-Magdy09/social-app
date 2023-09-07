import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Screens/login_screen.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> signInWithEmailAndPassword() async {
    UserCredential userCredentials =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );

    if (userCredentials.user != null) {
      Fluttertoast.showToast(
          msg: "Welcome ${userCredentials.user!.email}!",
          fontSize: 15,
          backgroundColor: Colors.green,
          gravity: ToastGravity.CENTER);
    } else {
      Fluttertoast.showToast(
          msg: 'Sign-in operation failed.',
          fontSize: 15,
          backgroundColor: Colors.red,
          gravity: ToastGravity.CENTER);
    }
  }
}
