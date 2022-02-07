import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:employee/core/app_colors.dart';
import 'package:employee/core/app_constant.dart';
import 'package:employee/core/utils.dart';
import 'package:employee/feature/data/remote/http_client_helper.dart';
import 'package:employee/feature/presentation/rigistration_screen/domain/registration_model.dart';
import 'package:employee/feature/presentation/rigistration_screen/domain/society_list_model.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String societyListSelection = "Society";
  List<String> societyList = [];

  TextEditingController userFirstNameController = TextEditingController();
  TextEditingController userLastNameController = TextEditingController();
  TextEditingController userMobileController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  TextEditingController userConfirmPasswordController = TextEditingController();

  bool passwordVisible = false;
  List<SocietyListModel> mSocietyList = [];
  int societyOwnerTypeSelection = 1;

  int ownerType = 0;
  String cityId = "";
  String societyId = "";

  @override
  void initState() {
    super.initState();
    societyList.add("Society");
    userFirstNameController = TextEditingController();
    userLastNameController = TextEditingController();
    userMobileController = TextEditingController();
    userEmailController = TextEditingController();
    userPasswordController = TextEditingController();
    userConfirmPasswordController = TextEditingController();
    dropDownDataLoadring();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appTheame,
          title: Text("Registration"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                DropdownButton(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.appTheame,
                    ),
                    value: societyListSelection,
                    items: societyList.map((item) {
                      return DropdownMenuItem(
                        child: Text(item),
                        value: item,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        societyListSelection = value.toString();
                        selectSocityId(value.toString());
                      });
                    },
                    hint: Text(societyListSelection.toString())),
                SizedBox(
                  height: 20,
                ),
                DropdownButton(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.appTheame,
                    ),
                    value: societyOwnerTypeSelection,
                    items: const [
                      DropdownMenuItem(
                        child: Text("Society Owner"),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text("Flat Owner"),
                        value: 2,
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        societyOwnerTypeSelection = int.parse(value.toString());
                      });
                    },
                    hint: Text("Select User")),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.person),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 250,
                      child: Container(
                        child: TextFormField(
                          maxLines: 1,
                          controller: userFirstNameController,
                          decoration: const InputDecoration(
                              labelText: 'First name',
                              border: UnderlineInputBorder(),
                              counterText: ""),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.person),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 250,
                      child: Container(
                        child: TextFormField(
                          maxLines: 1,
                          controller: userLastNameController,
                          decoration: const InputDecoration(
                              labelText: 'Last name',
                              border: UnderlineInputBorder(),
                              counterText: ""),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.phone),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 250,
                      child: Container(
                        child: TextFormField(
                          maxLines: 1,
                          controller: userMobileController,
                          decoration: const InputDecoration(
                              labelText: 'Mobile Number',
                              border: UnderlineInputBorder(),
                              counterText: ""),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.email),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 250,
                      child: Container(
                        child: TextFormField(
                          maxLines: 1,
                          controller: userEmailController,
                          decoration: const InputDecoration(
                              labelText: 'Email',
                              border: UnderlineInputBorder(),
                              counterText: ""),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.password),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 250,
                      child: Container(
                        child: TextFormField(
                          maxLines: 1,
                          controller: userPasswordController,
                          decoration: const InputDecoration(
                              labelText: 'Password',
                              border: UnderlineInputBorder(),
                              counterText: ""),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.password),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 250,
                      child: Container(
                        child: TextFormField(
                          maxLines: 1,
                          controller: userConfirmPasswordController,
                          decoration: const InputDecoration(
                              labelText: 'Confirm Password',
                              border: UnderlineInputBorder(),
                              counterText: ""),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton.extended(
                      heroTag: 'fs12df',
                      onPressed: () {
                        if (validation()) {
                          registrationLoadring();
                        }
                      },
                      icon: Icon(Icons.pending_actions),
                      label: Text("Sing up"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    userFirstNameController.dispose();

    userFirstNameController.dispose();
    userLastNameController.dispose();
    userMobileController.dispose();
    userEmailController.dispose();
    userPasswordController.dispose();
    userConfirmPasswordController.dispose();
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    super.dispose();
  }

  bool validation() {
    if (societyId.length > 0 &&
        cityId.length > 0 &&
        userFirstNameController.text.isNotEmpty &&
        userLastNameController.text.isNotEmpty &&
        userMobileController.text.isNotEmpty &&
        userEmailController.text.isNotEmpty &&
        userPasswordController.text.isNotEmpty &&
        userConfirmPasswordController.text.isNotEmpty) {
      return true;
    } else {
      Utils().snackShow(context, "Enter all detail.");
      return false;
    }
  }

  dropDownDataLoadring() {
    EasyLoading.show(status: AppConstant.loadingMessage);
    HttpClientHelper().getRegistrationDropDownApi().then((value) {
      if (value.statusCode == 200) {
        dynamic response = jsonDecode(value.body);

        response.forEach((element) {
          mSocietyList.add(SocietyListModel.fromJson(element));
          societyList.add(element["society_name"]);
        });
      }
      EasyLoading.dismiss();
      setState(() {});
    });
  }

  registrationLoadring() {
    EasyLoading.show(status: AppConstant.loadingMessage);
    HttpClientHelper()
        .registrationApi(
            userFirstNameController.text.toString(),
            userLastNameController.text.toString(),
            userEmailController.text.toString(),
            userMobileController.text.toString(),
            userPasswordController.text.toString(),
            societyId,
            ownerType,
            cityId)
        .then((value) {
      EasyLoading.dismiss();
      if (value.statusCode == 200) {
        RegistrationModel registrationResponse =
            RegistrationModel.fromJson(jsonDecode(value.body));
        if (registrationResponse.success!) {
          Utils().snackShow(context, registrationResponse.message!);
        }
      } else {
        Utils().snackShow(context, "Error, try again!");
      }
      Navigator.pop(context);
      setState(() {});
    });
  }

  void selectSocityId(String? value) {
    if (value != "Society") {
      SocietyListModel result = mSocietyList.elementAt(
          mSocietyList.indexWhere((element) => element.societyName == value));

      societyId = result.id.toString();
      cityId = result.cityId!;
    } else {
      societyId = "";
      cityId = "";
    }
  }
}
