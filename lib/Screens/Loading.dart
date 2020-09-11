import 'dart:async';
import 'dart:ui';

import 'package:Bookmytrainings/Utility/sharedPref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'HomeScreen.dart';
import 'OnboardingScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //Stream<QuerySnapshot> loadBanners;

  @override
  void initState(){
      super.initState();
      setT();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          FocusScope.of(context).unfocus();
      });
  }

  void setT() async {
      //loadBanners = await FirebaseFirestore.instance.collection("Banners").orderBy("id").snapshots();
      SharedPref pref = new SharedPref();
      bool b = await pref.getUserLogin();
      var abc = await Future.delayed(Duration(seconds: 3)).then((value) => (){
          return null;
      });
      if(b){
          Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
      } else {
          Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => Onboarding()), (route) => false);
      }
  }

  @override
  Widget build(BuildContext context) {

      ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);
      MediaQueryData m = MediaQuery.of(context);
      SystemChrome.setEnabledSystemUIOverlays([]);
      SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
      ]);

      return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Container(
              width: ScreenUtil().setWidth(360),
              height: ScreenUtil().setHeight(640),
              decoration: BoxDecoration(
                  image: DecorationImage(image: new AssetImage("Assets/SSBack.jpg"), fit: BoxFit.cover),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                      Container(child: SpinKitCircle(color: Colors.redAccent,)),

                      Padding(
                          padding: EdgeInsets.all(m.size.height/17),
                          child: Text("Copyright © 2011-2020 \nAll Rights Reserved",
                              style: TextStyle(fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                              textWidthBasis: TextWidthBasis.longestLine,
                          ),
                      ),

                  ],
              ),
          ),
      );
  }

}
