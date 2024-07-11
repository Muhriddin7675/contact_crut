import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contact_sqflite/presenter/screen/update/update_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../data/model/contact_model.dart';
import '../home/home.dart';
import '../home/home_bloc.dart';

class UpdateContact extends StatefulWidget {
  final ContactModel contactData;

  const UpdateContact({super.key, required this.contactData});

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  late TextEditingController _controllerName;
  late TextEditingController _controllerPhone;
  late ContactModel contactModel;
  var buttonState = true;
  late String name;
  late String phone;

  @override
  void initState() {
    super.initState();
    contactModel = widget.contactData;
    _controllerName = TextEditingController();
    _controllerPhone = TextEditingController();
    _controllerName.text = widget.contactData.name;
    _controllerPhone.text = widget.contactData.phoneNumber;
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateBloc, UpdateState>(
      listener: (context, state) {
        if (state is PopBackStack) {
          // Navigator.pop(context);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) => HomeBloc(),
                      child: const HomeScreen(),
                    )),
            (Route<dynamic> route) => false,
          );
        } else if (state is ErrorMessage) {
          Fluttertoast.showToast(
              msg: "Kontakt yangilanmadi",
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
                child: Center(child: Image.asset("assets/image_update.png"))),
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(children: [
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: _controllerName,
                        onChanged: (text) {
                          buttonState = (_controllerPhone.text.length == 13 &&
                              _controllerName.text.length >= 4 &&
                              _controllerPhone.text.startsWith("+998"));
                        },
                        cursorColor: const Color(0xffe95757),
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
                        onChanged: (text) {
                          buttonState = (_controllerPhone.text.length == 13 &&
                              _controllerName.text.length >= 4 &&
                              _controllerPhone.text.startsWith("+998"));
                        },
                        cursorColor: const Color(0xffe95757),
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
                          backgroundColor: const Color(0xffe95757),
                          disabledBackgroundColor: (buttonState)
                              ? const Color(0xffe95757)
                              : const Color(0xfff58181),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // Rounded corners
                          ),
                        ),
                        onPressed: () {
                          // Define your onPressed action here
                          if (buttonState) {
                            widget.contactData.name = _controllerName.text;
                            widget.contactData.phoneNumber =
                                _controllerPhone.text;
                            // MyHiveHelper.updateContact(ContactModel(_controllerName.text, _controllerPhone.text));
                            context
                                .read<UpdateBloc>()
                                .add(UpdateContactData(widget.contactData));
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
                          'Update',
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
