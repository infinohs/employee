import 'dart:convert';

import 'package:employee/core/app_colors.dart';
import 'package:employee/core/app_constant.dart';
import 'package:employee/core/utils.dart';
import 'package:employee/feature/data/local/local_index.dart';
import 'package:employee/feature/data/local/shared_pref.dart';
import 'package:employee/feature/data/remote/apis_constants.dart';
import 'package:employee/feature/data/remote/http_client_helper.dart';
 import 'package:employee/feature/presentation/guard_member_screen/guard_member_sceen.dart';
import 'package:employee/feature/presentation/login_screen/domain/guard_login_model.dart';
import 'package:employee/feature/presentation/login_screen/domain/login_model.dart';
import 'package:employee/feature/presentation/zonal_manager_module/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _value = 1;
  late TextEditingController _mobileController;
  late TextEditingController _passwordController;

  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _mobileController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appTheame,
          title: Text("Login"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "assets/icon/ic_launcher.png",
                    height: 100,
                  ),
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
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 1,
                          controller: _mobileController,
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
                    Icon(Icons.lock),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 250,
                      child: Container(
                        child: TextFormField(
                          maxLines: 1,
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: UnderlineInputBorder(),
                            counterText: "",
                          ),
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton.extended(
                      heroTag: 'fsefedf',
                      onPressed: () {
                        apiLoginCall();
                      },
                      icon: Icon(Icons.login),
                      label: Text("Login"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "assets/jpg/login_bottom_image.jpeg",
                  height: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }

  apiLoginCall() async {
    if (validation()) {
      String userType =
          await SharedPref().getStringValue(LocalIndex().user_type);

      switch (userType) {
        case 'Zonal Manager':
          zonalManagerLoginApi();
          break;
        case "Guade":
          GuadeLoginApi();
          break;
      }
    }
  }

  bool validation() {
    if (_mobileController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _value != 0) return true;
    Utils().snackShow(context, "Enter valid Mobile / Password");
    return false;
  }

  zonalManagerLoginApi() {
    EasyLoading.show(status: AppConstant.loadingMessage);
    HttpClientHelper()
        .getLoginApi(
            url: ApiConstants.zonalLogin,
            mobileNumber: _mobileController.text,
            password: _passwordController.text)
        .then((value) {
      EasyLoading.dismiss();
      if (value.statusCode == 200 ) {
        Utils().snackShow(context, "Succeed");
        LoginModel loginModel = LoginModel.fromJson(jsonDecode(value.body));
        SharedPref().putBoolValue(LocalIndex().isLogin, true);
        SharedPref().putIntValue(LocalIndex().UserId, loginModel.id!);
        SharedPref()
            .putStringValue(LocalIndex().username, loginModel.username!);
        SharedPref()
            .putStringValue(LocalIndex().password, loginModel.password!);
        SharedPref().putStringValue(LocalIndex().email, loginModel.email!);
        SharedPref().putStringValue(LocalIndex().mobile, loginModel.mobile!);
        SharedPref()
            .putStringValue(LocalIndex().profile_img, loginModel.profileImg!);
        SharedPref().putStringValue(LocalIndex().city_id, loginModel.cityId!);
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (BuildContext context) {
          return DashboardScreen();
        }));
      } else {
        Utils().snackShow(context, "Login failed");
      }
    });
  }

  void GuadeLoginApi() {
    EasyLoading.show(status: AppConstant.loadingMessage);
    HttpClientHelper()
        .getLoginApi(
            url: ApiConstants.guadeLogin,
            mobileNumber: _mobileController.text,
            password: _passwordController.text)
        .then((value) {
      EasyLoading.dismiss();
      if (value.statusCode == 200 || value.statusCode == 202) {
        Utils().snackShow(context, "Succeed");
        SharedPref().putBoolValue(LocalIndex().isGuardLogin, true);
        GuardLoginModel response =
            GuardLoginModel.fromJson(jsonDecode(value.body));
        SharedPref()
            .putIntValue(LocalIndex().UserId, response.securityGuard!.id!);
        SharedPref().putStringValue(
            LocalIndex().username, response.securityGuard!.name!);
        SharedPref()
            .putStringValue(LocalIndex().email, response.securityGuard!.email!);
        SharedPref().putStringValue(
            LocalIndex().mobile, response.securityGuard!.mobile!);
        SharedPref().putStringValue(
            LocalIndex().profile_img, response.securityGuard!.image!);
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (BuildContext context) {
          return GuardMemberScreen();
        }));
      } else {
        Utils().snackShow(context, "Login failed");
      }
    });
  }
}
