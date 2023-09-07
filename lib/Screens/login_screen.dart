import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/Bloc/Login_Bloc/login_cubit.dart';
import 'package:socialapp/Screens/register_screen.dart';

import '../Constants/components.dart';

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey();
bool isLoading = false;

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        var loginCubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Login"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.sizeOf(context).width / 30),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          // using regular expression
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return "Please enter a valid email address";
                          }
                          // the email is valid
                          return null;
                        },
                        text: email,
                        hintText: "Email",
                        icon: Icons.person,
                        keyBoardType: TextInputType.emailAddress),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextFormField(
                        // (?=.*[A-Z])       // should contain at least one upper case
                        //   (?=.*[a-z])       // should contain at least one lower case
                        //   (?=.*?[0-9])      // should contain at least one digit
                        //   (?=.*?[!@#\$&*~]) // should contain at least one Special character
                        //     .{8,}             // Must be at least 8 characters in length
                        validate: (value) {
                          RegExp regex = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          } else {
                            if (!regex.hasMatch(value)) {
                              return 'Enter valid password';
                            } else {
                              return null;
                            }
                          }
                        },
                        text: password,
                        hintText: "Password",
                        icon: Icons.password,
                        keyBoardType: TextInputType.text),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomButton(
                      buttonColor: Colors.blue,
                      textColor: Colors.black,
                      titleText: "Login",
                      pressed: () async {
                        try {
                          if (formKey.currentState!.validate()) {
                            isLoading = true;

                            await loginCubit.signInWithEmailAndPassword();
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     settings: RouteSettings(arguments: email.text),
                            //     builder: (context) => ChatScreen(),
                            //   ),
                            // );
                          }
                        } on FirebaseAuthException catch (exception) {
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
                                msg:
                                    'Authentication error: ${exception.message}',
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
                        isLoading = false;
                      },
                    ),
                    Row(
                      children: [
                        const Text(
                          "Doesnt have an account ?",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()),
                              );
                            },
                            child: const Text("Register"))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
