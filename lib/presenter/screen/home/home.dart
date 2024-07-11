import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contact_sqflite/domain/hive/my_hIve_helper.dart';

import '../../../data/model/contact_data.dart';
import '../../../data/pref/my_shared.dart';
import '../../../domain/firebase/repository_auth.dart';
import '../../dialog/dialog_delete.dart';
import '../../dialog/dialog_log_out.dart';
import '../add/add_bloc.dart';
import '../add/add_contact.dart';
import '../login/login.dart';
import '../login/login_bloc.dart';
import '../update/update_bloc.dart';
import '../update/update_contact.dart';
import 'Item_contact.dart';
import 'home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MyShared myShared = MyShared();
  late Stream<List<ContactData>> contactStream;
  var auth = Auth();

  @override
  void initState() {
    super.initState();
    // contactStream = repositoryContact.getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(InitContactList()),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text(
                "My Contacts",
                style: TextStyle(color: Colors.black45),
              ),
              actions: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36.0),
                            ),
                            elevation: 0.0,
                            backgroundColor: Colors.transparent,
                            child: dialogLogOut(context, () {
                              //logout
                              auth.logOut();
                              myShared.setHasLogin(false);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => LoginBloc(),
                                    child: const LoginScreen(),
                                  ),
                                ),
                              );
                            }, () {
                              MyHiveHelper.unRegister();

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => LoginBloc(),
                                    child: const LoginScreen(),
                                  ),
                                ),
                              );
                              //unRegister
                            }),
                          );
                        },
                      );
                    },
                    child: Image.asset("assets/ic_logout.png"),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state is ContactsLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is ContactsError) {
                              return Center(
                                child: Text(
                                  state.message,
                                  style: const TextStyle(
                                      fontSize: 24, color: Colors.red),
                                ),
                              );
                            } else if (state is ContactsLoaded) {
                              return ListView.builder(
                                itemCount: state.contacts.length,
                                itemBuilder: (ctx, index) {
                                  return ItemContact(
                                    name: state.contacts[index].name,
                                    phoneNumber:
                                        state.contacts[index].phoneNumber,
                                    onClickItem: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext ctx2) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(36.0),
                                            ),
                                            elevation: 0.0,
                                            backgroundColor: Colors.transparent,
                                            child: dialogContent(
                                              context,
                                              state.contacts[index].name,
                                              () {
                                                Navigator.of(context).pop();
                                                context.read<HomeBloc>().add(
                                                      DeleteContact(state
                                                          .contacts[index]),
                                                    );
                                                context
                                                    .read<HomeBloc>()
                                                    .add(InitContactList());
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    onClickMore: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (context) => UpdateBloc(),
                                            child: UpdateContact(
                                              contactData:
                                                  state.contacts[index],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                child: Text(
                                  "No data available",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.red),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => AddBloc(),
                            child: const AddContact(),
                          ),
                        ),
                      );
                      if (result == true) {
                        context.read<HomeBloc>().add(InitContactList());
                      }

                      print("result : $result");
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.add_circle,
                        color: Color(0xffe95757),
                        size: 72,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
