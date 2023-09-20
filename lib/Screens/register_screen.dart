import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/Bloc/Register_Bloc/register_cubit.dart';

import '../Constants/components.dart';
import 'home_screen.dart';
import 'login_screen.dart';

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController phone = TextEditingController();
TextEditingController username = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey();

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is CreateUserSuccessState) {
          RegisterCubit.get(context).getUserOnSignUp(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      },
      builder: (context, state) {
        var registerCubit = RegisterCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Register"),
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
                          if (value!.isEmpty) {
                            return 'Please Enter Your UserName';
                          } else {
                            if (value.length < 6) {
                              return 'Name must be more than 5 characters';
                            } else {
                              return null;
                            }
                          }
                        },
                        text: username,
                        hintText: "Username",
                        prefixIcon: Icons.person,
                        keyBoardType: TextInputType.text),
                    SizedBox(
                      height: 15.h,
                    ),
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
                        prefixIcon: Icons.mail,
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
                              return 'Enter stronger password';
                            } else {
                              return null;
                            }
                          }
                        },
                        text: password,
                        hintText: "Password",
                        isPasswordSeen: !registerCubit.seenPassword,
                        prefixIcon: FontAwesomeIcons.lock,
                        suffixIcon: registerCubit.seenPassword
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        onTap: () {
                          registerCubit.changePasswordVisibility();
                        },
                        keyBoardType: TextInputType.text),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextFormField(
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your Phone Number';
                          } else {
                            if (value.length != 11) {
                              return 'Mobile Number Must Be Of 11 Digit';
                            } else {
                              return null;
                            }
                          }
                        },
                        text: phone,
                        hintText: "Phone",
                        prefixIcon: FontAwesomeIcons.phone,
                        keyBoardType: TextInputType.phone),
                    SizedBox(
                      height: 15.h,
                    ),
                    state is RegisterLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            buttonColor: Colors.blue,
                            textColor: Colors.black,
                            titleText: "Register",
                            pressed: () async {
                              if (formKey.currentState!.validate()) {
                                // isLoading = true;
                                await registerCubit
                                    .createUserWithEmailAndPassword(
                                        phone: phone,
                                        name: username,
                                        email: email,
                                        password: password);
                              }
                            },
                          ),
                    Row(
                      children: [
                        const Text(
                          "already have an account? ",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            },
                            child: const Text("Login"))
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
