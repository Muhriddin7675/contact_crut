import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contact_sqflite/presenter/screen/register/register_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../home/home.dart';
import '../home/home_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerPassword;
  late TextEditingController _controllerConfirmPassword;
  var obscureText = true;

  @override
  void initState() {
    super.initState();
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
    _controllerConfirmPassword = TextEditingController();
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerConfirmPassword.dispose();
    super.dispose();
  }

  void _handleTextChanged() {
    setState(() {
      print("Username: ${_controllerEmail.text}");
      print("Password: ${_controllerPassword.text}");
      print("Confirm Password: ${_controllerConfirmPassword.text}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterNavigateHome) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>
                  BlocProvider(
                    create: (context) => HomeBloc(),
                    child: HomeScreen(),
                  )),
                  (Route<dynamic> route) => false,
            );
          } else if (state is RegisterErrorMessage) {
            Fluttertoast.showToast(
              msg: "Server xatoligi !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.deepOrangeAccent,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 56),
              Center(child: Image.asset("assets/register.png", height: 200)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.name,
                      controller: _controllerEmail,
                      onChanged: (value) => _handleTextChanged(),
                      cursorColor: const Color(0xffe95757),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: InkWell(
                          onTap: () {
                            _controllerEmail.text = '';
                          },
                          child: const Icon(
                            Icons.cancel,
                            color: Color(0xff8E8E93),
                          ),
                        ),
                        labelText: 'Username',
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _controllerPassword,
                      onChanged: (value) => _handleTextChanged(),
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
                    const SizedBox(height: 24),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _controllerConfirmPassword,
                      onChanged: (value) => _handleTextChanged(),
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
                        labelText: 'Confirm Password',
                      ),
                    ),
                    const SizedBox(height: 48),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffe95757),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          // Define your onPressed action here
                          if (_controllerPassword.text.length >= 8 &&
                              _controllerConfirmPassword.text ==
                                  _controllerPassword.text &&
                              _controllerEmail.text.endsWith("@gmail.com")) {
                            context.read<RegisterBloc>().add(Register(
                                _controllerEmail.text,
                                _controllerPassword.text));
                          } else {
                            Fluttertoast.showToast(
                                msg: "Password yoki Email xato kiritildi!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black45,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Do you have an account? Log in",
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
