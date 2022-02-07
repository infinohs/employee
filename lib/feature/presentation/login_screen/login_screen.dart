import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:employee/core/app_colors.dart';
import 'package:employee/core/app_constant.dart';
import 'package:employee/core/utils.dart';
import 'package:employee/feature/data/local/local_index.dart';
import 'package:employee/feature/data/local/shared_pref.dart';
import 'package:employee/feature/data/remote/http_client_helper.dart';
import 'package:employee/feature/presentation/dashboard/dashboard_screen.dart';
import 'package:employee/feature/presentation/login_screen/domain/login_model.dart';
import 'package:employee/feature/presentation/rigistration_screen/registration_screen.dart';

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
                Image.asset(
                  "assets/jpg/img_delivering.jpg",
                  height: 200,
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButton(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.appTheame,
                    ),
                    value: _value,
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
                        _value = int.parse(value.toString());
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
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          maxLength: 10,
                          controller: _mobileController,
                          decoration: const InputDecoration(
                              labelText: 'Mobile number',
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
                  children: [Text("Forget Password")],
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
                      label: Text("Sing in"),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    FloatingActionButton.extended(
                      heroTag: 'fsdf',
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) {
                          return RegistrationScreen();
                        }));
                      },
                      icon: Icon(Icons.contact_page_rounded),
                      label: Text("Sing up"),
                    )
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
    _mobileController.dispose();
    super.dispose();
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }

  apiLoginCall() {
    if (validation()) {
      EasyLoading.show(status: AppConstant.loadingMessage);
      HttpClientHelper()
          .getLoginApi(
              mobileNumber: _mobileController.text,
              password: _passwordController.text)
          .then((value) {
        EasyLoading.dismiss();
        if (value.statusCode == 200 || value.statusCode == 202) {
          Utils().snackShow(context, "Succeed");
          LoginModel loginModel = LoginModel.fromJson(jsonDecode(value.body));
          SharedPref().putBoolValue(LocalIndex().isLogin, true);
          SharedPref().putIntValue(LocalIndex().UserId, loginModel.id!);
          SharedPref()
              .putStringValue(LocalIndex().societyId, loginModel.societyId!);
          SharedPref()
              .putStringValue(LocalIndex().username, loginModel.username!);
          SharedPref()
              .putStringValue(LocalIndex().password, loginModel.password!);
          SharedPref().putStringValue(LocalIndex().email, loginModel.email!);
          SharedPref().putStringValue(LocalIndex().mobile, loginModel.mobile!);
          SharedPref()
              .putStringValue(LocalIndex().profile_img, loginModel.profileImg!);
          SharedPref().putStringValue(LocalIndex().city_id, loginModel.cityId!);
          SharedPref()
              .putStringValue(LocalIndex().full_name, loginModel.fullName!);
          SharedPref()
              .putStringValue(LocalIndex().is_owner, loginModel.isOwner!);
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (BuildContext context) {
            return DashboardScreen();
          }));
        } else {
          Utils().snackShow(context, "Login failed");
        }
      });
    }
  }

  bool validation() {
    if (_mobileController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _value != 0) return true;
    Utils().snackShow(context, "Enter valid Mobile / Password");
    return false;
  }
}
