import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:employee/core/app_constant.dart';
import 'package:employee/core/utils.dart';
import 'package:employee/feature/data/remote/http_client_helper.dart';
import 'package:employee/feature/presentation/dashboard/home/domain/services_model.dart';

class ServiceDetailScreen extends StatefulWidget {
  Services service;

  ServiceDetailScreen(this.service);

  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  late TextEditingController _detailController;

  @override
  void initState() {
    super.initState();
    _detailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _detailController.dispose();
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            height: 52,
            color: Colors.blue,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
                Text(
                  widget.service.servicesName!,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Service Name"),
                      Text(widget.service.servicesName!),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Service Price"),
                      Text(widget.service.price!),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Service igst"),
                      Text(widget.service.igst!),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Service Cgst"),
                      Text(widget.service.cgst!),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Service Sgst"),
                      Text(widget.service.sgst!),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Final Price"),
                      Text((double.parse(widget.service.price!) +
                              double.parse(widget.service.price!) +
                              double.parse(widget.service.price!) +
                              double.parse(widget.service.price!))
                          .toString()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              maxLines: 6,
              controller: _detailController,
              decoration:
                  InputDecoration(labelText: 'Description ', counterText: ""),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            primary: Colors.blue,
            backgroundColor: Colors.blue,
          ),
          onPressed: () {
            complaintBookApi();
          },
          child: Text(
            'Book Complaint',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    ));
  }

  complaintBookApi() {
    EasyLoading.show(status: AppConstant.loadingMessage);
    HttpClientHelper()
        .setComplaintApi(widget.service.servicesName!, widget.service.id!,
            _detailController.text.toString())
        .then((value) {
      EasyLoading.dismiss();
      if (value.statusCode == 200) {
        Utils().snackShow(context, "Complaint Raised");
        Navigator.pop(context);
      } else {
        Utils().snackShow(context, "failed, to raised complaint");
      }
    });
  }
}
