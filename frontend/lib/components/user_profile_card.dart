import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_bookstore/constants.dart';
import 'package:mobile_bookstore/model/user.dart';

import '../api/api.dart';

class UserProfileCard extends StatelessWidget {
  UserProfileCard({super.key, required this.profile});

  final UserProfile profile;

  final ImagePicker _picker = ImagePicker();

  void uploadImage(BuildContext context) async {
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      if (context.mounted) {
        BrnToast.show('取消上传', context);
      }
    } else {
      {
        bool succeed = await Api.uploadImage(image.path);
        if (succeed) {
          if (context.mounted) {
            BrnToast.show('上传成功', context);
          }
        } else {
          if (context.mounted) {
            BrnToast.show('上传失败', context);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget avatar = GestureDetector(
        onTap: () {
          uploadImage(context);
        },
        child: CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage("$apiPrefix${profile.avatar}"),
          backgroundColor: Colors.transparent,
        ));

    return Container(
      color: Colors.white,
      margin: const EdgeInsets.all(10),
      child: Row(children: [
        avatar,
        Flexible(
            child: ListTile(
          title: Text(
            profile.nickname,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
          subtitle: Text(
            profile.username,
            style: const TextStyle(color: Colors.grey, fontSize: 15),
          ),
        ))
      ]),
    );
  }
}
