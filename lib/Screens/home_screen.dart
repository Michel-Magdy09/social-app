import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Bloc/Home_Bloc/home_cubit.dart';
import 'package:socialapp/Screens/login_screen.dart';
import 'package:socialapp/Shared/Network/Local/cache_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("first"),
          ),
          body: homeCubit.userModel != null
              ? Column(
                  children: [
                    Text("hello ${homeCubit.userModel!.name}"),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          CacheHelper.removeData(key: "uId");

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        child: Text("LOGOUT"))
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
