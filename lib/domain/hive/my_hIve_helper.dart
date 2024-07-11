import 'package:flutter_contact_sqflite/data/model/auth_model.dart';
import 'package:flutter_contact_sqflite/data/model/contact_model.dart';
import 'package:flutter_contact_sqflite/data/pref/my_shared.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class MyHiveHelper {
  static String boxName = MyShared.getEmail();
  static const String authBoxName = "Auth";
  static Box<ContactModel>? boxContact;
  static late final Box<AuthModel> boxAuth;

  static Future<void> authInit() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(AuthModelAdapter());
    Hive.registerAdapter(ContactModelAdapter());
    boxAuth = await Hive.openBox<AuthModel>(authBoxName);
    init();
  }

  static Future<void> init() async {
    print(MyShared.getEmail());
    boxContact = await Hive.openBox<ContactModel>(boxName);
  }

  static bool addContact(ContactModel contact) {
    try {
      boxContact!.add(contact);
      return true;
    } catch (e) {
      print('Error adding contact: $e');
    return false;
    }
  }

  static void deleteContact(ContactModel contact) {
    try {
      contact.delete();
    } catch (e) {
      print('Error deleting contact: $e');
    }
  }

  static bool updateContact(ContactModel contact) {
    try {
      contact.save();
      return true;
    } catch (e) {
      print('Error updating contact: $e');
      return false;
    }
  }

  static List<ContactModel> getAllContact() {
    if (boxContact == null) return [];
    // TODO yoqmadi
    return boxContact!.values.toList();
  }

  static bool createUser(AuthModel authModel) {
    try {
      boxAuth.put(authModel.email, authModel);
      return true;
    } catch (e) {
      print('Error creating user: $e');
      return false;
    }
  }

  static void unRegister() {
    boxAuth.delete(MyShared.getEmail());
  }

  static bool signIn(AuthModel authModel) {
    try {
      var user = boxAuth.get(authModel.email);
      print(user?.password);

      if (user != null && user.password == authModel.password) {
        return true;
      }

      return false;
    } catch (e) {
      print('Error signing in: $e');
      return false;
    }
  }
}

/*
class MyHiveHelper {
   Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
     Hive.init(dir.path);
    Hive.registerAdapter(StudentModelAdapter());
    await Hive.openBox('Example');
  }

  static void addElement(dynamic element, dynamic key) {
    final box = Hive.box('Example');
     box.put(key, element);
  }
  static void clearBox(){
    final box = Hive.box('Example');
    box.clear();
  }
  static dynamic getElement(dynamic key) {
    final box = Hive.box('Example');
    return box.get(key, defaultValue: "NULL");
  }

  static void updateElement(dynamic key, dynamic element) {
    final box = Hive.box('Example');
    box.put(key, element);
  }

  static void addElement1(dynamic element) {
    final box = Hive.box('Example');
    box.add(element);
  }

  static void update(dynamic element) {
    final box = Hive.box('Example');
    for (int i = 0; i < box.length; i++) {
      if (box.getAt(i) == element) {
        box.putAt(i, element);
      }
    }
  }

  static List<dynamic> getAllValues() {
    final box = Hive.box('Example');
    return box.values.toList();
  }

  static void delete(dynamic key) {
    final box = Hive.box('Example');
    box.delete(key);
  }

  static void addStudent(StudentModel studentModel) {
    final box = Hive.box('Example');
    box.add(studentModel);
  }

  static void updateStudent(StudentModel studentModel){
   studentModel.save();
  }

/*
  * box.put('DDD', ['String','Ster']);
    box.putAll({'key':12,'EXE':15, 14:25});
    * */
}

 */
