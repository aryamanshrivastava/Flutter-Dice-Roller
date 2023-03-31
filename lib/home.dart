// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  static const _primaryColor = Color(0xff052890);
  final themeElement = ThemeData.light().copyWith(
      primaryColor: _primaryColor,
      textTheme: TextTheme(
          labelLarge: TextStyle(
        fontSize: 24.0,
        letterSpacing: 2.4,
        color: Colors.white,
      )),
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: _primaryColor)
          .copyWith(background: Colors.white));
  int wallet = 0;
  late int pickARandomFace;
  late String dieFaceAssetString1;
  late String dieFaceAssetString2;
  late AnimationController _animationController1;
  late AnimationController _animationController2;
  late ThemeData _currentTheme;

  @override
  void initState() {
    super.initState();
    _currentTheme = themeElement;
    pickARandomFace = Random().nextInt(5) + 1;
    dieFaceAssetString1 = 'assets/die_face_$pickARandomFace.svg';
    dieFaceAssetString2 = 'assets/die_face_$pickARandomFace.svg';
    _animationController1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 1,
    )..addListener(() {
        setState(() {});
      });

    _animationController2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.blueAccent,
        title: Text(
          'LET\'S ROLL IT',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              letterSpacing: 1.6,
              color: Color(0xff052890)),
        ),
        centerTitle: true,
        backgroundColor: _currentTheme.colorScheme.background,
        elevation: 10,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  wallet = 0;
                });
              },
              icon: Icon(
                Icons.restore,
                color: Color(0xff052890),
              ))
        ],
      ),
      body: Container(
        color: _currentTheme.colorScheme.secondary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: changeDieFace,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.white.withAlpha(55),
                          blurRadius: 24.0,
                          offset: Offset(0, 8))
                    ], color: null),
                    child: RotationTransition(
                        turns: _animationController1,
                        child: SvgPicture.asset(dieFaceAssetString1)),
                  ),
                ),
                GestureDetector(
                  onTap: changeDieFace,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.white.withAlpha(55),
                          blurRadius: 24.0,
                          offset: Offset(0, 8))
                    ], color: null),
                    child: RotationTransition(
                        turns: _animationController2,
                        child: SvgPicture.asset(dieFaceAssetString2)),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 48.0, right: 48.0),
              child: SizedBox(
                width: double.infinity,
                height: 80,
                child: buildElevatedButton(),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Wallet Balance ',
                    style: TextStyle(
                      fontSize: 18.0,color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '₹$wallet',
                    style: TextStyle(
                      fontSize: 18.0,color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ],
        ),
      ),
    );
  }

  Widget buildElevatedButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: _currentTheme.colorScheme.background,
        elevation: 16.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(200),
        ),
      ),
      onPressed: () {
        changeDieFace();
      },
      child: Text(
        "ROLL IT",
        style: _currentTheme.textTheme.bodyLarge,
      ),
    );
  }

  void changeDieFace() {
    setState(() {
      _animationController1.forward(from: 0);
      _animationController2.forward(from: 0);
      int die1 = Random().nextInt(6) + 1;
      int die2 = Random().nextInt(6) + 1;
      dieFaceAssetString1 = 'assets/die_face_$die1.svg';
      dieFaceAssetString2 = 'assets/die_face_$die2.svg';
      wallet += die1 + die2;
    });
  }

  @override
  void dispose() {
    _animationController1.dispose();
    _animationController2.dispose();
    super.dispose();
  }
}
