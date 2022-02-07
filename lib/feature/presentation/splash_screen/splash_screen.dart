import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:employee/core/app_colors.dart';
import 'package:employee/feature/data/local/local_index.dart';
import 'package:employee/feature/data/local/shared_pref.dart';
import 'package:employee/feature/presentation/dashboard/dashboard_screen.dart';
import 'package:employee/feature/presentation/is_guarde_screen/is_guarde_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appTheame,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(width: 40.0),
              Text(
                'Arkaya',
                style: GoogleFonts.lobster(fontSize: 42),
              ),
              SizedBox(width: 20.0, height: 100.0),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 40.0,
                  fontFamily: 'Horizon',
                ),
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  onFinished: () async {
                    bool islogin =
                        await SharedPref().getBoolValue(LocalIndex().isLogin)!;
                    if (islogin) {
                      Navigator.of(context).pushReplacement(
                          new MaterialPageRoute(
                              builder: (BuildContext context) {
                        return DashboardScreen();
                      }));
                    } else {

                      Navigator.of(context).pushReplacement(
                          new MaterialPageRoute(
                              builder: (BuildContext context) {
                        return IsGuardeScreen();
                      }));
                    }
                  },
                  animatedTexts: [
                    RotateAnimatedText(
                      'Home',
                      textStyle: GoogleFonts.lobster(fontSize: 42),
                    ),
                    RotateAnimatedText(
                      'Care',
                      textStyle: GoogleFonts.lobster(fontSize: 42),
                    ),
                  ],
                  onTap: () {
                    print("Tap Event");
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
