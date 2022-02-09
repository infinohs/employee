import 'package:employee/feature/presentation/user_list_screen/user_list_screen.dart';
import 'package:flutter/material.dart';

class IsGuardeScreen extends StatefulWidget {
  @override
  _IsGuardeScreenState createState() => _IsGuardeScreenState();
}

class _IsGuardeScreenState extends State<IsGuardeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.blue,
            padding: EdgeInsets.all(16),
            child: Text(
              "Guard",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  new MaterialPageRoute(builder: (BuildContext context) {
                return UserListScreen();
              }));
            },
            child: Container(
              color: Colors.blue,
              padding: EdgeInsets.all(16),
              child: Text(
                "Skip",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
