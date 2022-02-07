import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:employee/core/app_constant.dart';
import 'package:employee/core/utils.dart';
import 'package:employee/feature/data/local/local_index.dart';
import 'package:employee/feature/data/local/shared_pref.dart';
import 'package:employee/feature/data/remote/apis_constants.dart';
import 'package:employee/feature/data/remote/http_client_helper.dart';
import 'package:employee/feature/presentation/login_screen/login_screen.dart';
import 'package:employee/feature/presentation/profile_screen/detail_model.dart';
import 'package:employee/feature/presentation/profile_screen/profile_update_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  DetailModel detailModel = DetailModel();
  late File imageLoadFromGallary;
  int imageHolder = 0;

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();
    getProfileDetailApi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
          ),
          InkWell(
            onTap: () {
              loadImageFromLocalStorage();
            },
            child: getImageHolder(),
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
                    enabled: false,
                    maxLines: 1,
                    controller: _userNameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: UnderlineInputBorder(),
                      counterText: "",
                    ),
                    enableSuggestions: false,
                    autocorrect: false,
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
                    enabled: false,
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
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(Icons.mail),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 250,
                child: Container(
                  child: TextFormField(
                    enabled: false,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    maxLength: 10,
                    controller: _emailController,
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
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                heroTag: '3345',
                onPressed: () {
                  updateProfileApiCall();
                },
                icon: Icon(Icons.login),
                label: Text("SAVE"),
              ),
              SizedBox(
                width: 20,
              ),
              FloatingActionButton.extended(
                heroTag: '456',
                onPressed: () {
                  logout();
                },
                icon: Icon(Icons.contact_page_rounded),
                label: Text("LOGOUT"),
              )
            ],
          )
        ],
      ),
    ));
  }

  logout() {
    SharedPref().clearAllStorage();
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return LoginScreen();
    }));
  }

  updateProfileApiCall() {
    EasyLoading.show(status: AppConstant.loadingMessage);

    updateProfileDetailApi(_userNameController.text, _mobileController.text,
            _emailController.text, imageLoadFromGallary)
        .then((value) {
      EasyLoading.dismiss();
      http.Response.fromStream(value).then((onValue) {
        if (value.statusCode == 200) {
          Profile_update_model update =
              Profile_update_model.fromJson(json.decode(onValue.body));
          if (update.success!) {
             Utils().snackShow(context, "Succeed");
          }
        }
      });
    });
  }

  loadImageFromLocalStorage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image?.path != null) {
      imageLoadFromGallary = File(image!.path);
      setState(() {
        if (imageLoadFromGallary != null) {
          imageHolder = 2;
        }
      });
    }
  }

  getProfileDetailApi() async {
    EasyLoading.show(status: AppConstant.loadingMessage);
    HttpClientHelper().getProfileDetailApi().then((value) {
      if (value.statusCode == 200) {
        detailModel = DetailModel.fromJson(jsonDecode(value.body));
      }
      EasyLoading.dismiss();
      setState(() {
        _userNameController.text = detailModel.user!.fullName!;
        _mobileController.text = detailModel.user!.mobile!;
        _emailController.text = detailModel.user!.email!;
        if (detailModel.user!.profileImg != null) {
          imageHolder = 1;
        }
      });
    });
  }

  getImageHolder() {
    switch (imageHolder) {
      case 0:
        return ClipOval(
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            width: 100,
            height: 100,
            placeholder: (context, url) => CircularProgressIndicator(),
            imageUrl: "",
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        );
      case 1:
        return ClipOval(
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            width: 100,
            height: 100,
            placeholder: (context, url) => CircularProgressIndicator(),
            imageUrl: "http://admin.arkayahomecare.com/img_service/${detailModel.user!.profileImg!}",
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        );
      case 2:
        return ClipOval(
          child: Image.file(
            imageLoadFromGallary,
            width: 100.0,
            height: 100.0,
            fit: BoxFit.fitHeight,
          ),
        );
    }
  }

  updateProfileDetailApi(
      String userName, String mobile, String email, File ImageFile) async {
    int userId = await SharedPref().getIntValue(LocalIndex().UserId);
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiConstants.updateUserDetail));
    request.files.add(http.MultipartFile(
        'file', ImageFile.readAsBytes().asStream(), ImageFile.lengthSync(),
        filename: ImageFile.path.split("/").last));
    request.fields["id"] = userId.toString();
    return await request.send();
  }
}
