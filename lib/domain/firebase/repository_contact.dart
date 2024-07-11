import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/model/contact_data.dart';

class RepositoryContact {
  /*Stream<List<ContactData>> getContacts() {
    return FirebaseFirestore.instance.collection('contacts').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => ContactData.fromFireStore(doc.data(), doc.id))
            .toList());
  }*/

  Future<bool> addContact(String name, String phoneNumber) async {
    try {
      await FirebaseFirestore.instance
          .collection('contacts')
          .doc()
          .set({'name': name, 'phoneNumber': phoneNumber});
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<void> deleteContact(String docId) async {
    FirebaseFirestore.instance.collection('contacts').doc(docId).delete();
  }

  Future<bool> updateContact(
      String docId, String name, String phoneNumber) async {
    try {
      FirebaseFirestore.instance
          .collection('contacts')
          .doc(docId)
          .update({'name': name, 'phoneNumber': phoneNumber});
      return true;
    } catch (error) {
      return false;
    }
  }
}
