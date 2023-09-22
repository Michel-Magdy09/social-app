import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/Shared/Network/Local/cache_helper.dart';

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

  void createUser({
    @required email,
    @required name,
    @required phone,
    @required uId,
    @required image,
    @required cover,
    @required bio,
    @required isEmailVerified,
  }) {
    DocumentReference users =
        FirebaseFirestore.instance.collection('users').doc(uId);
    users.set({
      'name': name,
      'phone': phone,
      'email': email,
      'uId': uId,
      'cover':
          "https://img.freepik.com/free-photo/happy-mixed-race-woman-has-cheerful-expression-points-away-with-both-fore-fingers-says-follow-there-shows-direction-copy-space-wears-denim-clothes-white-hijab-isolated-purple-wall_273609-26320.jpg?w=1380&t=st=1694697732~exp=1694698332~hmac=c50a0301c2dbdff7b1d73ae8cd7760cdcde6fb484c61132aaf5ad802422079ab",
      'image':
          "https://campussafetyconference.com/wp-content/uploads/2020/08/iStock-476085198.jpg",
      'bio': "write your bio....",
      'isEmailVerified': isEmailVerified
    }).then((value) {
      CacheHelper.putData(key: 'UserDocId', value: uId);
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
