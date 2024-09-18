import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.email,
    required this.name,
  });

  final String name;
  final String email;

  static Map<String, dynamic> toFireStore(UserModel userInfo) {
    return {
      'name': userInfo.name,
      'email': userInfo.email,
    };
  }

  @override
  List<Object?> get props => [email, name];
}
