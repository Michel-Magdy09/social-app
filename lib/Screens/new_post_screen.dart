import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/Bloc/Home_Bloc/home_cubit.dart';

TextEditingController postTextController = TextEditingController();

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("Create Post"),
            actions: [
              TextButton(
                  onPressed: () {
                    if (homeCubit.postImage == null) {
                      homeCubit.createNewPost(
                        dateTime: DateTime.now().toString(),
                        postText: postTextController.text,
                      );
                    } else {
                      homeCubit.uploadPostImage(
                        dateTime: DateTime.now().toString(),
                        postText: postTextController.text,
                      );
                    }
                  },
                  child: Text(
                    "Post",
                    style: TextStyle(color: Colors.white, fontSize: 15.sp),
                  )),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(10.0.r),
            child: Column(
              children: [
                if (state is CreatePostLoadingState)
                  SizedBox(
                    height: 4.h,
                  ),
                if (state is CreatePostLoadingState) LinearProgressIndicator(),
                if (state is CreatePostLoadingState)
                  SizedBox(
                    height: 8.h,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.r,
                      backgroundImage: NetworkImage(homeCubit.userModel!.image),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            homeCubit.userModel!.name,
                            style: TextStyle(
                                height: 1.1.h,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: postTextController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "What is on your mind..."),
                  ),
                ),
                if (homeCubit.postImage != null)
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: 160.h,
                        width: double.infinity,
                        color: Colors.blue,
                        child: Image.file(homeCubit.postImage),
                      ),
                      CircleAvatar(
                        radius: 20.r,
                        child: IconButton(
                            onPressed: () {
                              homeCubit.removePostImage();
                            },
                            iconSize: 17.r,
                            color: Colors.white,
                            icon: const Icon(FontAwesomeIcons.close)),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            homeCubit.pickPostImageFromGallery();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.image,
                                size: 20.r,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "Add Photo",
                                style: TextStyle(fontSize: 16.sp),
                              )
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.hashtag,
                              size: 15.r,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "Tags",
                              style: TextStyle(fontSize: 18.sp),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
