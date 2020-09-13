import 'dart:async';

import 'package:Bookmytrainings/Screens/HomeScreen.dart';
import 'package:Bookmytrainings/Utility/pHp.dart';
import 'package:Bookmytrainings/Utility/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTP extends StatefulWidget {

  @override
  _OTPState createState() => _OTPState();

}

class _OTPState extends State<OTP> {

  TextEditingController _pinPutController = TextEditingController();
  Php dbConn = new Php();
  int _otp, sec;
  Stream otpStream;
  String tempS = '...30';
  String email;
  double op=0;
  GlobalKey<FormState> key = new GlobalKey();

  BoxDecoration get _pinPutDecoration {
      return BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 5,
              )
          ]
      );
  }

  sendOTP() async {
      SharedPref pref = new SharedPref();
      email = await pref.getEmail();
      _otp = await dbConn.sendOTP(email);
  }

  @override
  void initState() {
    super.initState();
    sec = 30;
    WidgetsBinding.instance.addPostFrameCallback((_){
        sendOTP();
        _pinPutController.text = "";
        otpStream = new Stream.periodic(Duration(seconds: 1), (_)  => sec--);
        otpStream.map((e) {
            if(e > 0)
                return '...$e';
            else
                return '';
        }).take(31).forEach((e) {
            if(mounted)
                setState(() {
                tempS = e;
                });

        });
    });
  }

  @override
  Widget build(BuildContext context) {

  ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);

    return Container(
        height: ScreenUtil().setHeight(640),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(image: AssetImage("Assets/OnboardingBack/drawable-xhdpi/OnBack.png"),
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
        )),
        child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(15),
                        ScreenUtil().setHeight(15),
                        ScreenUtil().setWidth(15),
                        ScreenUtil().setHeight(15)
                ),
                height: ScreenUtil().setHeight(400),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                        Text("Verify OTP",
                            style: TextStyle(fontSize: ScreenUtil().setSp(27),
                            ),
                            textAlign: TextAlign.start,
                        ),

                        Padding(
                            padding: EdgeInsets.fromLTRB(
                                    ScreenUtil().setWidth(8),
                                    ScreenUtil().setHeight(10),
                                    ScreenUtil().setWidth(8),
                                    ScreenUtil().setHeight(5)
                            ),
                            child: Opacity(
                                opacity: 0.85,
                                child: Text("An OTP has to sent to $email.\nPlease verify the OTP.",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.w400
                                    ),
                                    textAlign: TextAlign.center,
                                ),
                            ),
                        ),

                        PinPut(
                            fieldsCount: 4,
                            controller: _pinPutController,
                            autofocus: true,
                            fieldsAlignment: MainAxisAlignment.center,
                            eachFieldMargin: EdgeInsets.all(10),
                            submittedFieldDecoration: _pinPutDecoration,
                            selectedFieldDecoration: _pinPutDecoration,
                            followingFieldDecoration: _pinPutDecoration.copyWith(
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.5),
                                ),
                            ),
                            onChanged: (value) {
                                key.currentState.setState(() {
                                  op = 0;
                                });
                            },
                            onSubmit: (value) {
                                if(_otp.toString() == value){
                                    SharedPref pref = new SharedPref();
                                    pref.setUserLogin(true);
                                    Navigator.pushAndRemoveUntil(
                                            context,
                                            new MaterialPageRoute(
                                                    builder: (context) => HomeScreen()
                                            ),
                                                    (route) => false
                                    );
                                } else {
                                    key.currentState.setState(() {
                                        op = 1;
                                    });
                                }
                            },
                        ),

                        Form(
                            key: key,
                          child: Opacity(
                            opacity: op,
                            child: Text("Incorrect OTP",
                                style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),

                        Padding(
                            padding: EdgeInsets.fromLTRB(
                                    ScreenUtil().setWidth(8),
                                    ScreenUtil().setHeight(8),
                                    ScreenUtil().setWidth(8),
                                    ScreenUtil().setHeight(8)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                  Text("Didn't receive an OTP? ",),
                                  GestureDetector(
                                      child: Text("Resend OTP" + tempS,
                                          style: TextStyle(fontSize: ScreenUtil().setSp(12),
                                              fontWeight: FontWeight.w300,
                                              decoration: TextDecoration.underline,
                                          ),
                                      ),
                                      onTap: (){
                                          if(sec <= 0) {
                                              sendOTP();
                                              setState(() {
                                                sec = 30;
                                              });
                                              otpStream = null;
                                              otpStream = new Stream.periodic(Duration(seconds: 1), (_)  => sec--);
                                              otpStream.map((e) {
                                                  if(e > 0)
                                                      return '...$e';
                                                  else
                                                      return '';
                                              }).take(31).forEach((e) {
                                                  if(mounted)
                                                      setState(() {
                                                          tempS = e;
                                                      });

                                              });
                                          }
                                      },
                                  ),
                              ],
                          ),
                        ),

                        RaisedButton(
                            color: Colors.black,
                            child: Text("Validate", style: TextStyle(color: Colors.white),),
                            onPressed: (){
                                if(_otp.toString() == _pinPutController.text){
                                    SharedPref pref = new SharedPref();
                                    pref.setUserLogin(true);
                                    Navigator.pushAndRemoveUntil(
                                            context,
                                            new MaterialPageRoute(
                                                    builder: (context) => HomeScreen()
                                            ),
                                                    (route) => false
                                    );
                                } else {
                                    key.currentState.setState(() {
                                        op = 1;
                                    });
                                }
                            },
                        ),
                    ],
                ),
            ),
        ),
    );
  }
}
