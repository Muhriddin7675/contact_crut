import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  Future<bool> signIn(String email, String password) async {
    try {
      var user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // print("name: " + "${user.user?.emailVerified}");
      return true;
    } catch (error) {
      print("Error signIn: $error");
      return false;
    }
  }
  Future<bool> createUser(String emailAddress,String password) async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return true;
    }  catch (error) {
      print("Error createUser: $error");
      return false;
    }
  }

  void logOut() {
    final user = FirebaseAuth.instance.currentUser;
    print(user?.emailVerified);
    FirebaseAuth.instance.signOut();
  }
}
