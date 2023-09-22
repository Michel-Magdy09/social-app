import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Bloc/Home_Bloc/home_cubit.dart';

import '../Constants/components.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);
        return homeCubit.allUsersModel.isNotEmpty
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return UserChat(
                    homeCubit: homeCubit,
                    index: index,
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: homeCubit.allUsersModel.length)
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
