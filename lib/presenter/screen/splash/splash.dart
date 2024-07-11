import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contact_sqflite/presenter/screen/splash/splash_bloc.dart';

import '../../../data/pref/my_shared.dart';
import '../home/home.dart';
import '../login/login.dart';
import '../login/login_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var myShared = MyShared();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(myShared)..add(CheckAuthEvent()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (state is Unauthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) => LoginBloc(),
                        child: const LoginScreen(),
                      )),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset("assets/image_splash.png"),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Image.asset("assets/rectangle.png"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
