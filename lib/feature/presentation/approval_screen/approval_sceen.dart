import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class ApprovalScreen extends StatefulWidget {
  @override
  _ApprovalScreenState createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: Container(
        height: 52,
        color: Colors.blue,
        child: Center(
          child: Text(
            "Verify",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Complaint S1"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Description S1 description"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Enter otp"),
              ),
              OTPTextField(
                length: 4,
                width: 300,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 16,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 10,
                style: TextStyle(fontSize: 16),
                onChanged: (pin) {
                  print("Changed: " + pin);
                },
                onCompleted: (pin) {
                  print("Completed: " + pin);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Worker Details: "),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Worker Photo: "),
              ),
              CachedNetworkImage(
                fit: BoxFit.cover,
                width: 100,
                height: 100,
                placeholder: (context, url) => CircularProgressIndicator(),
                imageUrl: "",
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Worker name  : test Ground"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Worker Contact  : 2342342343"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Worker Address  : Pune,23232"),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
