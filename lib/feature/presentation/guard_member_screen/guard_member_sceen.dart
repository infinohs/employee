import 'package:flutter/material.dart';

class GuardMemberScreen extends StatefulWidget {
  @override
  _GuardMemberScreenState createState() => _GuardMemberScreenState();
}

class _GuardMemberScreenState extends State<GuardMemberScreen> {
  TextEditingController ownerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: ownerName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter owner name..',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.red,
                        ),
                      ))
            ],
          ),
        ),
      ),
    ));
  }
}
