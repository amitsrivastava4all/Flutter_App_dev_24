import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp_brainmentors/i18n/locale_keys.g.dart';
import 'package:todoapp_brainmentors/modules/user/views/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isAnim = false;
  void _moveToLogin() {
    Timer(Duration(seconds: 3), () {
      // Routing
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return Login();
      }));
    });
  }

  void _setAnimationTimer() {
    Timer(Duration(seconds: 2), () {
      setState(() {
        isAnim = true;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setAnimationTimer();
    _moveToLogin();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/todo.jpg'))),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    width: isAnim ? 0.0 : (deviceSize.width * 0.60),
                    height: isAnim ? 0.0 : (deviceSize.height * 0.15),
                    duration: Duration(seconds: 1),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.red,
                              spreadRadius: 10,
                              blurRadius: 20)
                        ],
                        gradient: LinearGradient(colors: [
                          Colors.black,
                          Colors.blue,
                          Colors.purple
                        ])),
                    child: Text(
                      LocaleKeys.splashmessage.tr(),
                      style: GoogleFonts.pacifico(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CircularProgressIndicator(),
                  SizedBox(
                    height: deviceSize.height * 0.50,
                  ),
                  Text(
                    'Powered by Brain Mentors',
                    style: GoogleFonts.aBeeZee(fontSize: 20),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
