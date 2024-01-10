import 'dart:async';

import 'package:bingevibes/Pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:bingevibes/Pages/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcomepage extends StatefulWidget {
  const Welcomepage({super.key});

  @override
  State<Welcomepage> createState() => WelcomepageState();
}

class WelcomepageState extends State<Welcomepage> {
  static const String KEYLOGIN = "login";
  @override
  void initState() {
    super.initState();
    moveToNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    'lib/Images/Playcoin.jpeg',
                    height: 250,
                    width: 250,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Ye dil Maange More',
                  style: TextStyle(
                      fontFamily: 'GreatVibes',
                      fontSize: 30,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 140,
                ),
                const Text(
                  'A proud',
                  style: TextStyle(
                      fontFamily: 'Solitreo',
                      fontSize: 16,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'MAKE IN INDIA',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Product',
                  style: TextStyle(
                      fontFamily: 'Solitreo',
                      fontSize: 16,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void moveToNext() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(KEYLOGIN);

    Timer(
      const Duration(seconds: 3),
      () {
        if (isLoggedIn != null) {
          if (isLoggedIn) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MyHome()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignIn()),
            );
          }
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignIn()),
          );
        }
      },
    );
    setState(() {});
  }
}
