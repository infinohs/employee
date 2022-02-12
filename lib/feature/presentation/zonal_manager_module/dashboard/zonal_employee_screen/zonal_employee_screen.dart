import 'dart:convert';

import 'package:employee/core/app_constant.dart';
import 'package:employee/feature/data/local/local_index.dart';
import 'package:employee/feature/data/local/shared_pref.dart';
import 'package:employee/feature/data/remote/http_client_helper.dart';
import 'package:employee/feature/presentation/domain/active_complaints_model.dart';
import 'package:employee/feature/presentation/domain/pending_complaint_model.dart';
import 'package:employee/feature/presentation/domain/solved_complaint_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ZonalEmployeeScreen extends StatefulWidget {
  const ZonalEmployeeScreen({Key? key}) : super(key: key);

  @override
  _ZonalEmployeeScreenState createState() => _ZonalEmployeeScreenState();
}

class _ZonalEmployeeScreenState extends State<ZonalEmployeeScreen> {
  ActiveComplaintsModel activeComplaintsModel = ActiveComplaintsModel();
  SolvedComplaintModel solvedComplaintModel = SolvedComplaintModel();
  PendingComplaintModel pendingComplaintModel = PendingComplaintModel();

  @override
  void initState() {
    super.initState();
    getComplaintActiveApi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Card(
              child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Channel Partner",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("countActiveComplaints"),
                  radius: 10,
                )
              ],
            ),
          )),
          SizedBox(
            height: 10,
          ),
          Card(
              child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Engineer",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("countActiveComplaints"),
                  radius: 10,
                )
              ],
            ),
          )),
          SizedBox(
            height: 10,
          ),
          Card(
              child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Field Supervisor",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("countActiveComplaints"),
                  radius: 10,
                )
              ],
            ),
          )),
          SizedBox(
            height: 10,
          ),
          Card(
              child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Technical Team",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("countActiveComplaints"),
                  radius: 10,
                )
              ],
            ),
          )),
          SizedBox(
            height: 10,
          ),
          Card(
              child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ground Worker",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("countActiveComplaints"),
                  radius: 10,
                )
              ],
            ),
          )),
        ],
      ),
    ));
  }

  getComplaintActiveApi() async {
    EasyLoading.show(status: AppConstant.loadingMessage);
    int token = await SharedPref().getIntValue(LocalIndex().UserId);
    HttpClientHelper().getZonalResponse(token.toString()).then((value) {
      if (value.statusCode == 200) {
        activeComplaintsModel =
            ActiveComplaintsModel.fromJson(jsonDecode(value.body));
        if (activeComplaintsModel.active!.isNotEmpty)
          activeComplaintsModel.active!.length;
      }
      EasyLoading.dismiss();
      setState(() {});
    });
  }
}
