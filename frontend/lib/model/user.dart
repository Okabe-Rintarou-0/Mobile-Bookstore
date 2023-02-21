// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

import '../constants.dart';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    this.id = -1,
    this.username = "",
    this.nickname = "",
    this.avatar = defaultAvatarUrl,
  });

  int id;
  String username;
  String nickname;
  String avatar;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        username: json["username"],
        nickname: json["nickname"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "nickname": nickname,
        "avatar": avatar,
      };
}
