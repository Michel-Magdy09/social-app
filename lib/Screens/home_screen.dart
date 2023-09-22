import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/Bloc/Home_Bloc/home_cubit.dart';

import '../Shared/Network/Local/cache_helper.dart';
import 'login_screen.dart';
import 'new_post_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is AddPostIndexState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NewPostScreen()));
        }
      },
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(actions: [
            TextButton(
              onPressed: () {
                CacheHelper.removeData(key: "UserDocId");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text(
                "LOGOUT",
                style: TextStyle(color: Colors.white),
              ),
            ),
            IconButton(
                onPressed: () {}, icon: const Icon(FontAwesomeIcons.bell)),
            IconButton(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.magnifyingGlass))
          ], title: Text(homeCubit.title[homeCubit.currentIndex])),
          body: homeCubit.screens[homeCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                homeCubit.changeBottomNavIndex(index);
              },
              currentIndex: homeCubit.currentIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.house), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.comment), label: "Chats"),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.squarePlus), label: "Add Post"),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.locationDot), label: "Users"),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.gear), label: "Settings"),
              ]),
        );
      },
    );
  }
}
