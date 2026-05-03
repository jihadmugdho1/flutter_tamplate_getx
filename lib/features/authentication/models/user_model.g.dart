// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  name: json['name'] as String,
  email: json['email'] as String,
  token: json['token'] as String,
  isLoggedIn: json['isLoggedIn'] as bool? ?? true,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'token': instance.token,
  'isLoggedIn': instance.isLoggedIn,
};
