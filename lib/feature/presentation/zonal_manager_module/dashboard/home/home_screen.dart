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

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ActiveComplaintsModel activeComplaintsModel = ActiveComplaintsModel();
  SolvedComplaintModel solvedComplaintModel = SolvedComplaintModel();
  PendingComplaintModel pendingComplaintModel = PendingComplaintModel();

  int countActiveComplaints = 0;
  int countSolvedComplaints = 0;
  int countPendingComplaints = 0;
  int selectComplaintCount = 1;

  @override
  void initState() {
    super.initState();
    getComplaintActiveApi();
    getComplaintComplitedApi();
    getComplaintPendingApi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Column(
        children: [
          Card(
              child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: Column(
              children: [
                Text(
                  "Active\nComplaints",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
                SizedBox(
                  height: 8,
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("$countActiveComplaints"),
                  radius: 10,
                )
              ],
            ),
          )),
          Card(
              child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: Column(
              children: [
                Text(
                  "Solved\nComplaints",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
                SizedBox(
                  height: 8,
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("$countSolvedComplaints"),
                  radius: 10,
                )
              ],
            ),
          )),
          Card(
              child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: Column(
              children: [
                Text(
                  "Pending\nComplaints",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
                SizedBox(
                  height: 8,
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("$countPendingComplaints"),
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
    HttpClientHelper().getComplaintActive(token.toString()).then((value) {
      if (value.statusCode == 200) {
        activeComplaintsModel =
            ActiveComplaintsModel.fromJson(jsonDecode(value.body));
        if (activeComplaintsModel.active!.isNotEmpty)
          countActiveComplaints = activeComplaintsModel.active!.length;
      }
      EasyLoading.dismiss();
      setState(() {});
    });
  }

  getComplaintComplitedApi() async {
    EasyLoading.show(status: AppConstant.loadingMessage);
    int token = await SharedPref().getIntValue(LocalIndex().UserId);
    HttpClientHelper().getComplaintComplited(token.toString()).then((value) {
      if (value.statusCode == 200) {
        solvedComplaintModel =
            SolvedComplaintModel.fromJson(jsonDecode(value.body));
      }
      EasyLoading.dismiss();
      setState(() {});
    });
  }

  getComplaintPendingApi() async {
    EasyLoading.show(status: AppConstant.loadingMessage);
    int token = await SharedPref().getIntValue(LocalIndex().UserId);
    HttpClientHelper().getComplaintPending(token.toString()).then((value) {
      if (value.statusCode == 200) {
        pendingComplaintModel =
            PendingComplaintModel.fromJson(jsonDecode(value.body));
      }
      EasyLoading.dismiss();
      setState(() {});
    });
  }
}
