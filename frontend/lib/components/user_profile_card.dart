import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_bookstore/constants.dart';
import 'package:mobile_bookstore/model/user.dart';
import 'package:mobile_bookstore/utils/image_utils.dart';

import '../api/api.dart';

class UserProfileCard extends StatelessWidget {
  UserProfileCard({super.key, required this.profile});

  final UserProfile profile;

  final ImagePicker _picker = ImagePicker();

  void uploadImage(BuildContext context) {
    // Pick an image
    _picker.pickImage(source: ImageSource.gallery).then((image) => {
          if (image == null)
            {BrnToast.show('取消上传', context)}
          else
            {
              Api.uploadImage(image.path).then((succeed) => {
                    if (succeed)
                      {BrnToast.show('上传成功', context)}
                    else
                      {BrnToast.show('上传失败', context)}
                  })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget avatar = GestureDetector(
        onLongPress: () {
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext ctx) {
                return BrnCommonActionSheet(
                  actions: [
                    BrnCommonActionSheetItem(
                      '上传新头像',
                      actionStyle: BrnCommonActionSheetItemStyle.normal,
                    ),
                    BrnCommonActionSheetItem(
                      '保存头像',
                      actionStyle: BrnCommonActionSheetItemStyle.normal,
                    )
                  ],
                  clickCallBack: (
                    int index,
                    BrnCommonActionSheetItem actionEle,
                  ) {
                    switch (index) {
                      case 0:
                        uploadImage(context);
                        break;
                      case 1:
                        ImageUtils.saveNetworkImage(
                            "$apiPrefix${profile.avatar}", "avatar").then((succeed) => BrnToast.show("保存成功", context));
                        break;
                    }
                  },
                );
              });
        },
        child: CircleAvatar(
          radius: 50,
          backgroundImage: profile.avatar.isNotEmpty
              ? NetworkImage("$apiPrefix${profile.avatar}")
              : null,
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
