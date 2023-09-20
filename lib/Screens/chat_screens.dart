import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Bloc/Home_Bloc/home_cubit.dart';

import '../Shared/Network/Local/cache_helper.dart';
import 'login_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);
        return Column(
          children: [
            Column(
              children: [
                TextButton(
                    onPressed: () {
                      CacheHelper.removeData(key: "UserDocId");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: Text("LOGOUT"))
              ],
            )
          ],
        );
      },
    );
  }
}
