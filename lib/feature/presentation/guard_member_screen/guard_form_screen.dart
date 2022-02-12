import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee/core/app_constant.dart';
import 'package:employee/core/utils.dart';
import 'package:employee/feature/data/local/local_index.dart';
import 'package:employee/feature/data/local/shared_pref.dart';
import 'package:employee/feature/data/remote/apis_constants.dart';
import 'package:employee/feature/presentation/guard_member_screen/domain/flats_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class GuardFormScreen extends StatefulWidget {
  Flats? flats;

  late File imageLoadFromGallary;

  GuardFormScreen(this.flats);

  @override
  _GuardFormScreenState createState() => _GuardFormScreenState();
}

class _GuardFormScreenState extends State<GuardFormScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobController = TextEditingController();
  late File imageLoadFromGallary;
  int imageHolder = 0;

  loadImageFromLocalStorage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image?.path != null) {
      imageLoadFromGallary = File(image!.path);
      setState(() {
        if (imageLoadFromGallary != null) {
          imageHolder = 1;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
          title: Text("Entry Form"),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    loadImageFromLocalStorage();
                  },
                  child: ClipOval(
                    child: imageHolder == 1
                        ? Image.file(
                            imageLoadFromGallary,
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.fitHeight,
                          )
                        : ClipOval(
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              imageUrl: "",
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
              controller: _nameController,
              decoration: const InputDecoration(
                  labelText: 'name',
                  border: UnderlineInputBorder(),
                  counterText: ""),
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
              maxLength: 10,
              controller: _mobController,
              decoration: const InputDecoration(
                  labelText: 'mobile',
                  border: UnderlineInputBorder(),
                  counterText: ""),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.extended(
                  heroTag: 'fsefesddf',
                  onPressed: () {
                    apiAskApprovalCall();
                  },
                  icon: Icon(Icons.login),
                  label: Text("Submit"),
                ),
              ],
            ),
          ],
        )));
  }

  void apiAskApprovalCall() {
    EasyLoading.show(status: AppConstant.loadingMessage);

    updateProfileDetailApi(
            _nameController.text, _mobController.text, imageLoadFromGallary)
        .then((value) {
      EasyLoading.dismiss();
      http.Response.fromStream(value).then((onValue) {
        if (value.statusCode == 200) {
          Utils().snackShow(context, "Succeed");
        }
      });
    });
  }

  updateProfileDetailApi(String userName, String mobile, File ImageFile) async {
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
