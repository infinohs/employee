import 'package:employee/feature/data/local/local_index.dart';
import 'package:employee/feature/data/local/shared_pref.dart';
import 'package:employee/feature/presentation/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    await SharedPref().putStringValue(
                        LocalIndex().user_type, LocalIndex().ZonalManager);

                    redirectToLogin();
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/jpg/ic_zonal_manager.jpg",
                          height: 42,
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text("Zonal Manager")
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await SharedPref().putStringValue(
                        LocalIndex().user_type, LocalIndex().ChannelPartner);

                    redirectToLogin();
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/jpg/ic_channel_partner.jpg",
                          height: 42,
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text("Channel Partner")
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await SharedPref().putStringValue(
                        LocalIndex().user_type, LocalIndex().Engineer);

                    redirectToLogin();
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/jpg/ic_engineer.png",
                          height: 42,
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text("Engineer")
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await SharedPref().putStringValue(
                        LocalIndex().user_type, LocalIndex().FieldSupervior);

                    redirectToLogin();
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/jpg/ic_field_supervisor.png",
                          height: 42,
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text("Field Supervior")
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await SharedPref().putStringValue(LocalIndex().user_type,
                        LocalIndex().TechnicalTeamMember);

                    redirectToLogin();
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/jpg/ic_technical_team_member.png",
                          height: 42,
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text("Technical Team Member")
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await SharedPref().putStringValue(
                        LocalIndex().user_type, LocalIndex().GroundWorker);
                    redirectToLogin();
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/jpg/ic_ground_worker.png",
                          height: 42,
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text("Ground Worker")
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await SharedPref().putStringValue(
                        LocalIndex().user_type, LocalIndex().bpo);
                    redirectToLogin();
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/jpg/ic_bpo.jpg",
                          height: 42,
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text("BPO")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  redirectToLogin() {
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return LoginScreen();
    }));
  }
}
