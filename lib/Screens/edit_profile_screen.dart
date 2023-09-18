import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Bloc/Home_Bloc/home_cubit.dart';
import '../Constants/components.dart';

TextEditingController nameController = TextEditingController();
TextEditingController bioController = TextEditingController();
TextEditingController phoneController = TextEditingController();

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);
        nameController.text = homeCubit.userModel!.name;
        bioController.text = homeCubit.userModel!.bio;
        phoneController.text = homeCubit.userModel!.phone;
        return Scaffold(
          appBar: AppBar(
            title: Text("Edit profile"),
            actions: [
              TextButton(
                onPressed: () async {
                  print("he");
                  await homeCubit.updateUserInfo(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                },
                child: Text(
                  "UPDATE",
                  style: TextStyle(color: Colors.white, fontSize: 15.sp),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.only(
              top: 15.0.r,
              bottom: 15.0.r,
              left: 8.0.r,
              right: 8.0.r,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is UpdateUserDataLoadingState)
                    LinearProgressIndicator(),
                  Container(
                    height: 200.h,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                height: 160.h,
                                width: double.infinity,
                                color: Colors.blue,
                                child: homeCubit.coverImage == null
                                    ? Image.network(
                                        homeCubit.userModel!.cover,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(homeCubit.coverImage)
                                        as Widget,
                              ),
                              CircleAvatar(
                                radius: 20.r,
                                child: IconButton(
                                    onPressed: () {
                                      homeCubit
                                          .PickCoverImageImageFromGallery();
                                    },
                                    iconSize: 17.r,
                                    color: Colors.white,
                                    icon: const Icon(FontAwesomeIcons.camera)),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 60.r,
                              child: CircleAvatar(
                                radius: 55.r,
                                backgroundImage: homeCubit.profileImage == null
                                    ? NetworkImage(homeCubit.userModel!.image)
                                    : FileImage(homeCubit.profileImage)
                                        as ImageProvider,
                              ),
                            ),
                            CircleAvatar(
                              radius: 20.r,
                              child: IconButton(
                                  onPressed: () {
                                    homeCubit.PickProfileImageFromGallery();
                                  },
                                  iconSize: 17.r,
                                  color: Colors.white,
                                  icon: const Icon(FontAwesomeIcons.camera)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (homeCubit.profileImage != null ||
                      homeCubit.coverImage != null)
                    Row(
                      children: [
                        if (homeCubit.profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                CustomButton(
                                    textColor: Colors.white,
                                    buttonColor: Colors.blue,
                                    pressed: () {
                                      homeCubit.uploadProfileImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text);
                                    },
                                    titleText: "upload profile"),
                                if (state is UpdateUserDataLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        SizedBox(
                          width: 5.w,
                        ),
                        if (homeCubit.coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                CustomButton(
                                    textColor: Colors.white,
                                    buttonColor: Colors.blue,
                                    pressed: () {
                                      homeCubit.uploadCoverImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text);
                                    },
                                    titleText: "upload cover"),
                                if (state is UpdateUserDataLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextFormField(
                      keyBoardType: TextInputType.name,
                      hintText: "What is my Name?",
                      prefixIcon: FontAwesomeIcons.user,
                      text: nameController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "the name must not be empty";
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextFormField(
                      keyBoardType: TextInputType.text,
                      hintText: "what inspire you ?",
                      prefixIcon: FontAwesomeIcons.user,
                      text: bioController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "the Bio must not be empty";
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextFormField(
                      keyBoardType: TextInputType.phone,
                      hintText: "Phone?",
                      prefixIcon: FontAwesomeIcons.user,
                      text: phoneController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "the phone must not be empty";
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
