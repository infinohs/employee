import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee/core/app_constant.dart';
import 'package:employee/core/utils.dart';
import 'package:employee/feature/data/local/local_index.dart';
import 'package:employee/feature/data/local/shared_pref.dart';
import 'package:employee/feature/data/remote/http_client_helper.dart';
import 'package:employee/feature/presentation/guard_member_screen/domain/flats_model.dart';
import 'package:employee/feature/presentation/guard_member_screen/guard_form_screen.dart';
import 'package:employee/feature/presentation/is_guarde_screen/is_guarde_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class GuardMemberScreen extends StatefulWidget {
  @override
  _GuardMemberScreenState createState() => _GuardMemberScreenState();
}

class _GuardMemberScreenState extends State<GuardMemberScreen> {
  TextEditingController ownerName = TextEditingController();
  List<Flats?> mFlats = [];
  late FlatsModel response;

  @override
  void initState() {
    super.initState();
    loadSocirtyApis();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Flat Listing"),
        actions: [
          GestureDetector(
              onTap: () {
                logoff();
              },
              child: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                child: TextField(
                  controller: ownerName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter owner name..',
                  ),
                  onChanged: (value) {
                    filterWithValue(value);
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                  itemCount: mFlats.length,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) {
                            return GuardFormScreen(mFlats.elementAt(index));
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Container(
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipOval(
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      width: 62,
                                      height: 62,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      imageUrl:
                                          "http://admin.arkayahomecare.com/society_owner_profile_pic/${mFlats.elementAt(index)?.profileImg!}",
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(mFlats.elementAt(index)!.fullName!),
                                      Text(mFlats.elementAt(index)!.cityId!),
                                    ],
                                  ),
                                  Text(mFlats.elementAt(index)!.mobile!)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
            ],
          ),
        ),
      ),
    ));
  }

  loadSocirtyApis() async {
    int guardId = await SharedPref().getIntValue(
      LocalIndex().UserId,
    );
    EasyLoading.show(status: AppConstant.loadingMessage);
    HttpClientHelper()
        .getFlats(
      securityGuardId: guardId.toString(),
    )
        .then((value) {
      EasyLoading.dismiss();
      if (value.statusCode == 200 || value.statusCode == 202) {
        SharedPref().putBoolValue(LocalIndex().isGuardLogin, true);
        response = FlatsModel.fromJson(jsonDecode(value.body));
        mFlats.addAll(response.flats!);
      } else {
        Utils().snackShow(context, "Login failed");
      }
      setState(() {});
    });
  }

  void logoff() async {
    await SharedPref().clearAllStorage();
    Navigator.of(context)
        .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
      return IsGuardeScreen();
    }));
  }

  void filterWithValue(String value) {
    mFlats.addAll(response.flats!);
    mFlats.removeWhere((element) => element!.fullName!.contains(value));
    setState(() {});
  }
}
