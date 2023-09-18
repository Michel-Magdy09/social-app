import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialapp/Bloc/Home_Bloc/home_cubit.dart';
import 'package:socialapp/Screens/edit_profile_screen.dart';

import '../Constants/components.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);
        return Padding(
          padding: EdgeInsets.only(
            top: 15.0.r,
            bottom: 15.0.r,
            left: 8.0.r,
            right: 8.0.r,
          ),
          child: Column(
            children: [
              Container(
                height: 200.h,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 160.h,
                        width: double.infinity,
                        color: Colors.blue,
                        child: Image.network(
                          homeCubit.userModel!.cover,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 60.r,
                      child: CircleAvatar(
                        radius: 55.r,
                        backgroundImage:
                            NetworkImage(homeCubit.userModel!.image),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                homeCubit.userModel!.name,
                style: TextStyle(fontSize: 25.sp),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                homeCubit.userModel!.bio,
                style: TextStyle(fontSize: 15.sp),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Posts",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.sp),
                      ),
                      Text(
                        "100",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Likes",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.sp),
                      ),
                      Text(
                        "100",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Posts",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.sp),
                      ),
                      Text(
                        "100",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              CustomButton(
                titleText: "Edit Profile",
                buttonColor: Colors.blue,
                textColor: Colors.white,
                pressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfileScreen()),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
