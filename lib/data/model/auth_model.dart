import 'package:hive/hive.dart';

part 'auth_model.g.dart';

@HiveType(typeId: 1)
class AuthModel extends HiveObject {
  @HiveField(0)
  final String email;
  @HiveField(1)
  final String password;

  AuthModel(this.email, this.password);
}
