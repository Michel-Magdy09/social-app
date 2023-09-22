import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/Bloc/Home_Bloc/home_cubit.dart';

import '../Models/post_model.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.text,
      required this.keyBoardType,
      required this.prefixIcon,
      required this.validate,
      this.onTap,
      this.suffixIcon,
      this.isPasswordSeen = false});
  String? Function(String?)? validate;
  String hintText;
  var keyBoardType;
  var prefixIcon;
  TextEditingController text;
  var suffixIcon;
  VoidCallback? onTap;
  bool isPasswordSeen;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPasswordSeen,
      validator: validate,
      controller: text,
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      keyboardType: keyBoardType,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          errorStyle: const TextStyle(
              fontSize: 16.0, color: Colors.red, fontWeight: FontWeight.bold),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.black,
            size: 20,
          ),
          suffixIcon: InkWell(
            onTap: onTap,
            child: Icon(suffixIcon),
          ),
          labelText: hintText,
          labelStyle: const TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
    );
  }
}

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.titleText,
      required this.buttonColor,
      required this.textColor,
      required this.pressed});

  String titleText;
  var buttonColor;
  var textColor;
  VoidCallback pressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: ElevatedButton(
        onPressed: pressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: buttonColor,
        ),
        child: Text(
          titleText,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  PostModel model;
  int index;
  PostItem({
    required this.model,
    required this.index,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: EdgeInsets.all(8.0.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.r,
                backgroundImage: NetworkImage(model.userImage),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      style: TextStyle(
                          height: 1.1.h,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      model.dateTime,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(height: 1.1.h),
                    )
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {}, icon: const Icon(FontAwesomeIcons.ellipsis))
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              thickness: 2,
            ),
          ),
          Text(
            model.text,
            style: TextStyle(
                fontSize: 15.sp, fontWeight: FontWeight.w500, height: 1.15.h),
          ),
          Wrap(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 5.0),
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    "#Software_developer",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.blue,
                          fontSize: 13.sp,
                        ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 5.0),
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    "#Software_developer",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.blue,
                          fontSize: 13.sp,
                        ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 5.0),
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    "#ig",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.blue,
                          fontSize: 13.sp,
                        ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 5.0),
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    "#Made_my_day",
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Colors.blue,
                          fontSize: 13.sp,
                        ),
                  ),
                ),
              ),
            ],
          ),
          if (model.postImage != '')
            Image.network(
                fit: BoxFit.cover,
                height: 200.h,
                width: double.infinity,
                model.postImage),
          const Divider(
            thickness: 2,
          ),
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.heart, size: 18.r),
                    SizedBox(width: 7.w),
                    Text(HomeCubit.get(context).likesList[index].toString()),
                  ],
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.comments, size: 18.r),
                    SizedBox(width: 7.w),
                    Text("1000"),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 2,
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 17.r,
                backgroundImage:
                    NetworkImage(HomeCubit.get(context).userModel!.image),
              ),
              SizedBox(
                width: 3.w,
              ),
              Expanded(
                child: TextFormField(
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp),
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(hintText: "hello"),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  HomeCubit.get(context).likePost(
                      HomeCubit.get(context).postsIds[index].toString());
                },
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.heart, size: 18.r),
                    SizedBox(width: 7.w),
                    Text("Like"),
                  ],
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}

// class chatBubble extends StatelessWidget {
//   const chatBubble({
//     required this.message,
//     super.key,
//   });
//
//   final Message message;
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Container(
//         padding:
//             const EdgeInsets.only(left: 10, top: 16, right: 32, bottom: 16),
//         margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//         decoration: const BoxDecoration(
//           color: Colors.red,
//           borderRadius: BorderRadius.only(
//             bottomRight: Radius.circular(30),
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//           ),
//         ),
//         child: Text(message.message),
//       ),
//     );
//   }
// }
//
// class chatBubbleWithFriend extends StatelessWidget {
//   const chatBubbleWithFriend({
//     required this.message,
//     super.key,
//   });
//
//   final Message message;
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         padding:
//             const EdgeInsets.only(left: 10, top: 16, right: 32, bottom: 16),
//         margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//         decoration: const BoxDecoration(
//           color: Colors.blue,
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(30),
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//           ),
//         ),
//         child: Text(message.message),
//       ),
//     );
//   }
// }
