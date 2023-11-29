import 'dart:async';

import 'package:flutter/material.dart';

import '../HomeScreen/mainscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                MainScreen()
            )
        )
    );
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
            child:testing()

        ),
      ),

    );
  }

  Widget testing(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
            flex:1,
            child: Container(

              // height: MediaQuery.of(context).size.height*0.2,
              //   color: Colors.black,
            )),
        Expanded(
          flex: 6,
          child:Container(
            // height: MediaQuery.of(context).size.height*0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/icontext.png',

                ),

              ],
            ),
          ),),
        Expanded(
          flex: 3,
          child: Container(
              height: MediaQuery.of(context).size.height*0.2,
              alignment: Alignment.bottomCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(

                    child: Image.asset(
                      fit: BoxFit.cover,
                      'assets/images/splashimage.png',

                    ),
                  ),

                ],

              )

          ),
        ),
      ],);
  }

}
