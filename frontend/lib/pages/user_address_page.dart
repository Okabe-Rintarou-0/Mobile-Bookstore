import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:mobile_bookstore/components/common/btn.dart';
import 'package:mobile_bookstore/components/common/text_avatar.dart';
import 'package:mobile_bookstore/model/address.dart';
import 'package:mobile_bookstore/utils/response_utils.dart';

import '../api/api.dart';

class UserAddressPage extends StatefulWidget {
  const UserAddressPage({super.key});

  @override
  State<StatefulWidget> createState() => _UserAddressPageState();
}

class _UserAddressPageState extends State<UserAddressPage> {
  List<AddressInfo> addresses = [];

  bool isManaging = false;

  int groupValue = -1;

  @override
  void initState() {
    super.initState();
    Api.getAddresses().then((addresses) {
      setState(() {
        this.addresses = addresses;
        try {
          groupValue = addresses.firstWhere((addr) => addr.isDefault).id;
        } catch (_) {
          groupValue = -1;
        }
      });
    });
  }

  Widget defaultView(List<AddressInfo> addresses) => Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          children: addresses.map((addr) => addressTile(addr)).toList(),
        ),
      );

  Widget manageView(List<AddressInfo> addresses) => Column(
        children: addresses
            .map((addr) => Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: addressTile(addr),
                ))
            .toList(),
      );

  Widget infoRow(AddressInfo addr) {
    Widget avatar = addr.isDefault
        ? const DefaultAddressAvatar(
            colors: [Color(0xFFFF7800), Color(0xFFFF4B00)],
            height: 40,
          )
        : TextAvatar(
            text: addr.name.characters.first,
            height: 40,
            colors: const [Color(0xFFFFF0E9), Color(0xFFFFDBCF)],
            textColor: const Color(0xFFF85206));
    Widget tile = ListTile(
        title: Row(
          children: [
            Text(
              addr.name,
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
            const SizedBox(width: 5),
            Text(
              addr.tel,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            )
          ],
        ),
        subtitle: Text(
          addr.address,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ));

    return Row(children: [
      Expanded(flex: 1, child: avatar),
      Expanded(flex: 6, child: tile)
    ]);
  }

  Widget addressTile(AddressInfo addr) {
    Widget info = infoRow(addr);

    if (!isManaging) {
      return info;
    }

    Widget radioBtn = Row(
      children: [
        Radio<int>(
            value: addr.id,
            groupValue: groupValue,
            onChanged: (value) {
              if (value != null) {
                Api.changeDefaultAddress(groupValue, value).then((res) {
                  ResponseUtils.handleResponse(context, res, onSucceed: () {
                    setState(() {
                      if (groupValue > 0) {
                        final idx =
                            addresses.indexWhere((addr) => addr.isDefault);
                        if (idx >= 0) {
                          addresses[idx].isDefault = false;
                        }
                      }
                      addresses
                          .firstWhere((addr) => addr.id == value)
                          .isDefault = true;
                      groupValue = value;
                    });
                  });
                });
              }
            }),
        const Text("默认地址", style: TextStyle(color: Colors.grey, fontSize: 12))
      ],
    );

    Widget deleteBtn = TextButton(
        onPressed: () {
          Api.deleteAddress(addr.id).then((res) {
            ResponseUtils.handleResponse(context, res, onSucceed: () {
              setState(() {
                addresses.remove(addr);
              });
            });
          });
        },
        child: const Text("删除",
            style: TextStyle(color: Colors.grey, fontSize: 12)));

    return Column(
      children: [
        info,
        const Divider(
          color: Color(0xFFF0F0F0),
          thickness: 1.5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [radioBtn, deleteBtn],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget manageBtn = TextButton(
        onPressed: () {
          setState(() {
            isManaging = true;
          });
        },
        child: const Text("管理",
            style: TextStyle(color: Color(0xFFF85206), fontSize: 15)));

    Widget finishBtn = TextButton(
        onPressed: () {
          setState(() {
            isManaging = false;
          });
        },
        child: const Text("完成",
            style: TextStyle(color: Color(0xFFF85206), fontSize: 15)));

    AppBar appBar = AppBar(
      title: const Text("我的收货地址"),
      actions: [isManaging ? finishBtn : manageBtn],
    );

    Widget addAddressBtn = GradientColorButton(
        onPressed: () {},
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        text: const Text("添加收货地址", style: TextStyle(color: Colors.white)),
        colors: const [Color(0xFFFF7800), Color(0xFFFF4B00)]);

    Widget body = Container(
        height: double.infinity,
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
            color: Color(0xFFF0F0F0),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: SingleChildScrollView(
            child:
                isManaging ? manageView(addresses) : defaultView(addresses)));

    return Scaffold(
      appBar: appBar,
      body: body,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          color: Colors.transparent,
          width: double.infinity,
          child: addAddressBtn,
        ),
      ),
    );
  }
}
