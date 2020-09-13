import 'package:Bookmytrainings/Utility/FutureProvider.dart';
import 'package:Bookmytrainings/Utility/pHp.dart';
import 'package:Bookmytrainings/Utility/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with AutomaticKeepAliveClientMixin {

    @override
    void initState(){
        super.initState();
        setT();
        WidgetsBinding.instance.addPostFrameCallback((_) => pageCon = FutureProvider.of(context).pageCon);
    }

    void setT() async {
        String a = await pref.getEmail();
        setState(() {
            textCon.text = a;
        });
    }

    TextEditingController textCon = new TextEditingController(text: "");
    final _formKey = GlobalKey<FormState>();
    SharedPref pref = new SharedPref();
    bool isWriting;
    PageController pageCon;
    Php dbConn = new Php();

    RegExp mailVal = new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
      super.build(context);

  ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);
  var bottom = MediaQuery.of(context).viewInsets.bottom;

    return Container(
        height: ScreenUtil().setHeight(640),
        width: ScreenUtil().setWidth(360),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(image: AssetImage("Assets/OnboardingBack/drawable-xhdpi/OnBack.png"),
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
        )),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: bottom),
            child: Container(
                padding: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(15),
                        ScreenUtil().setHeight(15),
                        ScreenUtil().setWidth(15),
                        ScreenUtil().setHeight(15)
                ),
                color: Colors.transparent,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                        SizedBox(
                            height: ScreenUtil().setHeight(200),
                        ),

                        Text("Login",
                            style: TextStyle(fontSize: ScreenUtil().setSp(26)),
                            textAlign: TextAlign.start,
                        ),

                        Padding(
                            padding: EdgeInsets.fromLTRB(
                                    ScreenUtil().setWidth(0),
                                    ScreenUtil().setHeight(15),
                                    ScreenUtil().setWidth(0),
                                    ScreenUtil().setHeight(0)
                            ),
                            child: Opacity(
                              opacity: 0.65,
                              child: Text("Registered Email ID",
                                  style: TextStyle(fontSize: ScreenUtil().setSp(16)),
                                  textAlign: TextAlign.start,
                              ),
                          ),
                        ),

                        Padding(
                            padding: EdgeInsets.fromLTRB(
                                    ScreenUtil().setWidth(0),
                                    ScreenUtil().setHeight(15),
                                    ScreenUtil().setWidth(0),
                                    ScreenUtil().setHeight(5)
                            ),                        child: Form(
                              key: _formKey,
                              child: TextFormField(
                                  controller: textCon,
                                  keyboardType: TextInputType.emailAddress,
                                  textAlign: TextAlign.start,
                                  onChanged: (String s) {
                                      isWriting = true;
                                      _formKey.currentState.validate();
                                  },
                                  onEditingComplete: () {
                                      pushOTP();
                                  },
                                  validator: (value){
                                      if(isWriting)
                                          return null;
                                      else
                                          return "Email id is incorrect";
                                  },
                                  decoration: InputDecoration(border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                  ),
                                      contentPadding: EdgeInsets.fromLTRB(
                                              ScreenUtil().setWidth(10),
                                              ScreenUtil().setHeight(10),
                                              ScreenUtil().setWidth(10),
                                              ScreenUtil().setHeight(10)
                                      ),
                                      hintText: "Enter your email id",
                                  ),
                              ),
                          ),
                        ),

                        Container(
                            padding: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(10), 0, 0),
                            alignment: Alignment.bottomCenter,
                            child: RaisedButton(
                                color: Colors.black,
                                child: Text("Log In", style: TextStyle(color: Colors.white),),
                                onPressed: () {
                                    pushOTP();
                                },
                            ),
                        ),

                        Container(
                            padding: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(10), 0, ScreenUtil().setHeight(10)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    Text("Don't have an account? ",
                                        style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                    ),
                                    GestureDetector(
                                        child: Text("Sign up",
                                            style: TextStyle(fontSize: ScreenUtil().setSp(15),
                                                fontWeight: FontWeight.w300,
                                                decoration: TextDecoration.underline,
                                                color: Colors.lightBlue
                                            ),
                                            textAlign: TextAlign.start,
                                        ),
                                        onTap: (){
                                            FocusScope.of(context).unfocus();
                                            pageCon.jumpToPage(0);
                                        },
                                    ),
                                ],
                            ),
                        ),

                    ],
                ),
            ),
          ),
        ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  pushOTP() async {
      FocusScope.of(context).unfocus();
      if(mailVal.hasMatch(textCon.text)){
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                  content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Text("Signing you in..."),
                          CircularProgressIndicator(),
                      ],
                  ),
              ),
              barrierDismissible: false,
          );
          String b = await dbConn.getUser(textCon.text.toLowerCase());
          Navigator.pop(context);
          //Navigator.pop(context);
          if(b == "true"){
              pageCon.jumpToPage(2);
          } if(b == "false") {
              isWriting = false;
              _formKey.currentState.validate();
          } else if(b == "false"){
              Fluttertoast.showToast(msg: "Could not login",
                  textColor: Colors.black,
                  fontSize: ScreenUtil().setSp(20),
                  toastLength: Toast.LENGTH_LONG,
              );
          }
      } else {
          isWriting = false;
          _formKey.currentState.validate();
      }
  }

}
