import 'package:shared_preferences/shared_preferences.dart';

class MyShared {
  static late final SharedPreferences prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void setHasLogin(bool hasLogin) async {
    prefs.setBool("LOGIN", hasLogin);
  }

  bool getHasLogin() {
    return prefs.getBool("LOGIN") ?? false;
  }

  static void setEmail(String emil) async {
    prefs.setString("Email", emil);
  }

  static String getEmail() {
    return prefs.getString("Email") ?? "";
  }


  void addContact(String name, String phoneNumber) async {
    List<String> contacts = prefs.getStringList('contacts') ?? [];
    contacts.add('$name:$phoneNumber');
    await prefs.setStringList('contacts', contacts);
  }

  List<String> getContacts() {
    return prefs.getStringList('contacts') ?? [];
  }

  void updateContact(String oldName, String newName, String newPhoneNumber,
      String oldPhoneNumber) async {
    List<String> contacts = prefs.getStringList('contacts') ?? [];

    for (int i = 0; i < contacts.length; i++) {
      if (contacts[i].startsWith('$oldName:$oldPhoneNumber')) {
        contacts[i] = '$newName:$newPhoneNumber';
        break;
      }
    }

    await prefs.setStringList('contacts', contacts);
  }

  void deleteContact(String name, String phone) async {
    List<String> contacts = prefs.getStringList('contacts') ?? [];

    contacts.removeWhere((contact) => contact.startsWith('$name:$phone'));

    await prefs.setStringList('contacts', contacts);
  }
}
