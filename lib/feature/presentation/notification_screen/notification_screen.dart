import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:employee/core/app_constant.dart';
import 'package:employee/feature/data/local/local_index.dart';
import 'package:employee/feature/data/local/shared_pref.dart';
import 'package:employee/feature/data/remote/http_client_helper.dart';
import 'package:employee/feature/presentation/notification_screen/domain/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationModel notificationModel = NotificationModel();

  @override
  void initState() {
    super.initState();
    getNotificationApi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView.builder(
      shrinkWrap: true,
      itemCount: notificationModel.notifications != null
          ? notificationModel.notifications!.length
          : 0,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.all(16),
        child: ListTile(
          title: Text(
              notificationModel.notifications!.elementAt(index).complaintId!),
          subtitle: Text(
              "${notificationModel.notifications!.elementAt(index).message!}"),
          tileColor: Colors.lightBlue[100],
        ),
      ),
    ));
  }

  getNotificationApi() async {
    EasyLoading.show(status: AppConstant.loadingMessage);
    int token = await SharedPref().getIntValue(LocalIndex().UserId);
    String flag = await SharedPref().getStringValue(LocalIndex().is_owner);
    HttpClientHelper()
        .getNotificationCall(token.toString(), flag)
        .then((value) {
      if (value.statusCode == 200) {
        notificationModel = NotificationModel.fromJson(jsonDecode(value.body));
      }
      EasyLoading.dismiss();
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }
}
