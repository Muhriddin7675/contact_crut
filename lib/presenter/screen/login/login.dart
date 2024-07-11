import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../home/home.dart';
import '../home/home_bloc.dart';
import '../register/register.dart';
import '../register/register_bloc.dart';
import 'login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is NavigateHome) {
              Navigator.pushReplacement(
                context, MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) => HomeBloc(),
                          child: const HomeScreen(),
                        )),
              );

          }
          else if (state is ErrorMessage) {
            Fluttertoast.showToast(
              msg: "Sizning akauntingiz yo'q ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.deepOrangeAccent,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 56),
            Expanded(
              flex: 3,
              child: Center(child: Image.asset("assets/image_login.png")),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        keyboardType: TextInputType.name,
                        controller: _controllerEmail,
                        cursorColor: const Color(0xffe95757),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _controllerEmail.text = '';
                              });
                            },
                            child: const Icon(
                              Icons.cancel,
                              color: Color(0xff8E8E93),
                            ),
                          ),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _controllerPassword,
                        obscureText: obscureText,
                        cursorColor: const Color(0xffe95757),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            child: Icon(
                              obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color(0xff8E8E93),
                            ),
                          ),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          disabledBackgroundColor: const Color(0xffe95757),
                          backgroundColor: const Color(0xffe95757),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // Rounded corners
                          ),
                        ),
                        onPressed: () {
                          print("Login press");
                          if (_controllerPassword.text.length >= 8 &&
                              _controllerEmail.text.endsWith("@gmail.com")) {
                            context.read<LoginBloc>().add(SignIn(
                                _controllerEmail.text,
                                _controllerPassword.text));
                          } else {
                            Fluttertoast.showToast(
                                msg: "Password yoki email xato!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.deepOrangeAccent,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            color: Colors.white, // Text color
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                    create: (context) => RegisterBloc(),
                                    child: const RegisterScreen(),
                                  )),
                        );
                      },
                      child: const Text(
                        "Don’t have an account yet? Sign up here",
                        style: TextStyle(color: Colors.black45, fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
