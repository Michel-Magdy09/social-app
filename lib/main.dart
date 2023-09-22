import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialapp/Bloc/Home_Bloc/home_cubit.dart';
import 'package:socialapp/Bloc/Register_Bloc/register_cubit.dart';
import 'package:socialapp/Screens/home_screen.dart';
import 'package:socialapp/Screens/register_screen.dart';

import 'Bloc/Login_Bloc/login_cubit.dart';
import 'Shared/Network/Local/cache_helper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Widget startWidget;
  var uid = CacheHelper.getData(key: 'UserDocId');
  if (uid != null) {
    startWidget = const HomeScreen();
  } else {
    startWidget = const RegisterScreen();
  }
  runApp(MyApp(widget: startWidget));
}

class MyApp extends StatelessWidget {
  final Widget widget;
  const MyApp({required this.widget, super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginCubit(),
          ),
          BlocProvider(
            create: (context) => RegisterCubit(),
          ),
          BlocProvider(
              create: (context) => HomeCubit()
                ..getUserData()
                ..getPosts()),
        ],
        child: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'First Method',
                // You can use the library anywhere in the app even in theme
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: child,
              );
            },
            child: widget));
  }
}
