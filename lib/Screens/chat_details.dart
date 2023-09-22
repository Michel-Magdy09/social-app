import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialapp/Bloc/Home_Bloc/home_cubit.dart';
import 'package:socialapp/Models/user_model.dart';

import '../Constants/components.dart';

class ChatDetails extends StatelessWidget {
  UserModel userModel;
  TextEditingController messageText = TextEditingController();

  ChatDetails({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundImage: NetworkImage(userModel.image),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(userModel.name),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(10.0.r),
            child: Column(
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(homeCubit.userModel?.uId)
                      .collection('chats')
                      .doc(userModel.uId)
                      .collection('messages')
                      .snapshots(),
                  builder: (context, snapshot) {
                    homeCubit.getMessages(receiverId: userModel.uId);
                    if (homeCubit.messagesList.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Expanded(
                      child: ListView.builder(
                          reverse: true,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (homeCubit.messagesList[index].senderId ==
                                homeCubit.userModel?.uId) {
                              return MyChatBubble(
                                  messageModel: homeCubit.messagesList[index]);
                            }
                            return FriendChatBubble(
                                messageModel: homeCubit.messagesList[index]);
                          },
                          itemCount: homeCubit.messagesList.length),
                    );
                  },
                ),
                TextFormField(
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    controller: messageText,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        errorStyle: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: Colors.red),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: Colors.red),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            homeCubit.sendMessages(
                              receiverId: userModel.uId,
                              text: messageText.text,
                              dateTime: DateTime.now().toString(),
                            );
                            messageText.text = "";
                          },
                          child: const Icon(
                            Icons.send,
                            color: Colors.black,
                          ),
                        ),
                        hintText: "write your message here...",
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold))),
              ],
            ),
          ),
        );
      },
    );
  }
}
