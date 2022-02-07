import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:employee/core/app_constant.dart';
import 'package:employee/feature/data/local/local_index.dart';
import 'package:employee/feature/data/local/shared_pref.dart';
import 'package:employee/feature/data/remote/http_client_helper.dart';
import 'package:employee/feature/presentation/domain/active_complaints_model.dart';
import 'package:employee/feature/presentation/domain/pending_complaint_model.dart';
import 'package:employee/feature/presentation/domain/solved_complaint_model.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({Key? key}) : super(key: key);

  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
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
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: (){
                setState(() {
                  selectComplaintCount=1;
                });
              },
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
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
            ),
            InkWell(
              onTap: (){
                setState(() {
                  selectComplaintCount=2;
                });
              },
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
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
            ),
            InkWell(
              onTap: (){
                setState(() {
                  selectComplaintCount=3;
                });
              },
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
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
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: getSelectedComplaintWidget(),
        ),
      ],
    ));
  }

  getSelectedComplaintWidget() {
    switch (selectComplaintCount) {
      case 1:
        return ListView.builder(
          shrinkWrap: true,
          itemCount: activeComplaintsModel.active != null
              ? activeComplaintsModel.active!.length
              : 0,
          itemBuilder: (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(activeComplaintsModel.active!
                  .elementAt(index)
                  .complaintName!),
              subtitle: Text(
                  "Price :  ${activeComplaintsModel.active!.elementAt(index).price!}"),
              tileColor: Colors.lightBlue[100],
            ),
          ),
        );
      case 2:
        return ListView.builder(
          shrinkWrap: true,
          itemCount: solvedComplaintModel.completed != null
              ? solvedComplaintModel.completed!.length
              : 0,
          itemBuilder: (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(solvedComplaintModel.completed!
                  .elementAt(index)
                  .complaintName!),
              subtitle: Text(
                  "Price :  ${solvedComplaintModel.completed!.elementAt(index).price!}"),
              tileColor: Colors.lightBlue[100],
            ),
          ),
        );
      case 3:
        return ListView.builder(
          shrinkWrap: true,
          itemCount: pendingComplaintModel.request != null
              ? pendingComplaintModel.request!.length
              : 0,
          itemBuilder: (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(pendingComplaintModel.request!
                  .elementAt(index)
                  .complaintName!),
              subtitle: Text(
                  "Price :  ${pendingComplaintModel.request!.elementAt(index).price!}"),
              tileColor: Colors.lightBlue[100],
            ),
          ),
        );
      default:
        return Container();
    }
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
