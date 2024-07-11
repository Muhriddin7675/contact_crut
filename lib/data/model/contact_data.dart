/*class ContactData {
  String id;
  String name;
  String phoneNumber;

  ContactData({required this.id, required this.name, required this.phoneNumber});

  factory ContactData.fromFireStore(Map<String, dynamic> fireStoreData, String id) {
    return ContactData(
      id: id,
      name: fireStoreData['name'] ?? '',
      phoneNumber: fireStoreData['phoneNumber'] ?? '',
    );
  }
}*/

class ContactData {
  final int? id;
  final String name;
  final String phoneNumber;

  ContactData({this.id, required this.name, required this.phoneNumber});

  factory ContactData.fromJson(Map<String, dynamic> json) =>
      ContactData(id:json['id'],name: json['name'], phoneNumber: json['phoneNumber']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'phoneNumber': phoneNumber};
}