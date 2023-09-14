import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/Bloc/Login_Bloc/login_cubit.dart';
import 'package:socialapp/Screens/register_screen.dart';
import 'package:socialapp/Shared/Network/Local/cache_helper.dart';

import '../Constants/components.dart';
import 'home_screen.dart';

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey();

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          CacheHelper.putData(key: 'uId', value: state.uId).then((value) {
            LoginCubit.get(context).getUserOnSignIn(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          });
        }
      },
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
                        prefixIcon: Icons.person,
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
                        isPasswordSeen: !loginCubit.seenPassword,
                        hintText: "Password",
                        prefixIcon: FontAwesomeIcons.lock,
                        suffixIcon: loginCubit.seenPassword
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        onTap: () {
                          loginCubit.changePasswordVisibility();
                        },
                        keyBoardType: TextInputType.text),
                    SizedBox(
                      height: 15.h,
                    ),
                    state is LoginLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            buttonColor: Colors.blue,
                            textColor: Colors.black,
                            titleText: "Login",
                            pressed: () async {
                              if (formKey.currentState!.validate()) {
                                await loginCubit.signInWithEmailAndPassword(
                                    email: email, password: password);
                              }
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
