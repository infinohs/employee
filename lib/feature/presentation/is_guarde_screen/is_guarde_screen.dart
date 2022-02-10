import 'package:employee/feature/data/local/local_index.dart';
import 'package:employee/feature/data/local/shared_pref.dart';
import 'package:employee/feature/presentation/login_screen/login_screen.dart';
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
          GestureDetector(
            onTap: () async {
              await SharedPref()
                  .putStringValue(LocalIndex().user_type, LocalIndex().Guade);

              Navigator.of(context).pushReplacement(
                  new MaterialPageRoute(builder: (BuildContext context) {
                return LoginScreen();
              }));
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Container(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/jpg/ic_bpo.jpg",
                      height: 42,
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text("Guard")
                  ],
                ),
              ),
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
