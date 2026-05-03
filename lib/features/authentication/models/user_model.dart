import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String name;
  final String email;
  final String token;
  final bool isLoggedIn;

  UserModel({
    required this.name,
    required this.email,
    required this.token,
    this.isLoggedIn = true,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
