import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../home/home.dart';
import '../home/home_bloc.dart';
import 'add_bloc.dart';

class AddContact extends StatefulWidget {
  const AddContact({
    super.key,
  });

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  late TextEditingController _controllerName;
  late TextEditingController _controllerPhone;
  var buttonState = false;

  @override
  void initState() {
    super.initState();
    _controllerName = TextEditingController();
    _controllerPhone = TextEditingController();
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddBloc, AddState>(
      listener: (context, state) {
        if (state is AddPopBackStack) {
          print('Bloc.AddPopBackStack.SCREEN');
          // Navigator.pop(context, true);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    BlocProvider(
                      create: (context) => HomeBloc(),
                      child: const HomeScreen(),
                    )),
                (Route<dynamic> route) => false,
          );
        } else if (state is AddErrorMessage) {
          Fluttertoast.showToast(
              msg: "Kontakt qo'shilmadi",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(height: 56),
            Expanded(
                flex: 3,
                child: Center(child: Image.asset("assets/image_add.png"))),
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(children: [
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        keyboardType: TextInputType.name,
                        controller: _controllerName,
                        cursorColor: const Color(0xffe95757),
                        onChanged: (text) {
                          setState(() {
                            buttonState = (_controllerPhone.text.length == 13 &&
                                _controllerName.text.length >= 4 &&
                                _controllerPhone.text.startsWith("+998"));
                          });
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _controllerName.text = '';
                              });
                            },
                            child: const Icon(
                              Icons.cancel,
                              color: Color(0xff8E8E93),
                            ),
                          ),
                          labelText: 'Name',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        controller: _controllerPhone,
                        cursorColor: const Color(0xffe95757),
                        onChanged: (text) {
                          setState(() {
                            buttonState = (_controllerPhone.text.length == 13 &&
                                _controllerName.text.length >= 4 &&
                                _controllerPhone.text.startsWith("+998"));
                          });
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _controllerPhone.text = '';
                              });
                            },
                            child: const Icon(
                              Icons.cancel,
                              color: Color(0xff8E8E93),
                            ),
                          ),
                          labelText: 'Phone',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffe95757),
                          disabledBackgroundColor: (buttonState)
                              ? Color(0xffe95757)
                              : Color(0xfff58181),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // Rounded corners
                          ),
                        ),
                        onPressed: () {
                          if (buttonState) {
                            context.read<AddBloc>().add(AddUser(
                                _controllerName.text, _controllerPhone.text));
                          } else {
                            Fluttertoast.showToast(
                                msg: "Telefon nomer yoki ism xato!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black45,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.white, // Text color
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ))
          ])),
    );
  }
}
