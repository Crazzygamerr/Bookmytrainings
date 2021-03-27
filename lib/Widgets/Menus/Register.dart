import 'package:Bookmytrainings/Utility/FutureProvider.dart';
import 'package:Bookmytrainings/Utility/pHp.dart';
import 'package:Bookmytrainings/Utility/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
    @override
    _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> with AutomaticKeepAliveClientMixin {

    @override
    void initState(){
        super.initState();
        WidgetsBinding.instance.addPostFrameCallback((_) => pageCon = FutureProvider.of(context).pageCon);
    }

    TextEditingController textCon1 = new TextEditingController();
    TextEditingController textCon2 = new TextEditingController();
    TextEditingController textCon3 = new TextEditingController();

    final _formKey1 = GlobalKey<FormState>();
    final _formKey2 = GlobalKey<FormState>();
    final _formKey3 = GlobalKey<FormState>();

    FocusNode node1 = new FocusNode();
    FocusNode node2 = new FocusNode();
    FocusNode node3 = new FocusNode();

    SharedPref pref = new SharedPref();
    bool isWriting1,isWriting2,isWriting3;
    PageController pageCon;
    Php dbConn = new Php();

    RegExp nameVal = new RegExp(r"[A-Za-z0-9@$!%*#?&]{8,}$");
    RegExp passVal = new RegExp(r"^(?=.*?[a-z])[A-Za-z0-9@$!%*#?&]{8,}$");
    RegExp mailVal = new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    String valS = "Email id is incorrect";

    @override
    Widget build(BuildContext context) {
        super.build(context);

        ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);
        var bottom = MediaQuery.of(context).viewInsets.bottom;

        return Container(
            height: ScreenUtil().setHeight(640),
            width: ScreenUtil().setWidth(360),
            //alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(image: AssetImage("Assets/OnboardingBack/drawable-xhdpi/OnBack.png"),
                        fit: BoxFit.contain,
                        alignment: Alignment.topCenter,
                    )),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                      padding: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(15),
                              0,
                              0,
                              0
                      ),
                    child: Text("Sign Up",
                        style: TextStyle(fontSize: ScreenUtil().setSp(26)),
                        textAlign: TextAlign.start,
                    ),
                  ),

                  Padding(
                      padding: EdgeInsets.only(bottom: bottom),
                      child: Container(
                          padding: EdgeInsets.fromLTRB(
                                  ScreenUtil().setWidth(15),
                                  0,
                                  ScreenUtil().setWidth(15),
                                  ScreenUtil().setHeight(15)
                          ),
                          height: ScreenUtil().setHeight(405 - bottom*0.90),
                          width: ScreenUtil().setWidth(360),
                          color: Colors.transparent,
                          child: SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                                ScreenUtil().setWidth(0),
                                                ScreenUtil().setHeight(15),
                                                ScreenUtil().setWidth(0),
                                                ScreenUtil().setHeight(10)
                                        ),
                                        child: Opacity(
                                            opacity: 0.65,
                                            child: Text("Name",
                                                style: TextStyle(fontSize: ScreenUtil().setSp(16)),
                                                textAlign: TextAlign.start,
                                            ),
                                        ),
                                    ),

                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                                ScreenUtil().setWidth(0),
                                                ScreenUtil().setHeight(0),
                                                ScreenUtil().setWidth(0),
                                                ScreenUtil().setHeight(5)
                                        ),
                                        child: Form(
                                            key: _formKey1,
                                            child: TextFormField(
                                                controller: textCon1,
                                                keyboardType: TextInputType.name,
                                                textAlign: TextAlign.start,
                                                focusNode: node1,
                                                onChanged: (String s) {
                                                    isWriting1 = true;
                                                    _formKey1.currentState.validate();
                                                },
                                                onEditingComplete: () async {
                                                    if(nameVal.hasMatch(textCon1.text)) {
                                                        node1.unfocus();
                                                        node2.requestFocus();
                                                    } else {
                                                        isWriting1 = false;
                                                        _formKey1.currentState.validate();
                                                    }
                                                },
                                                validator: (value){
                                                    if(isWriting1)
                                                        return null;
                                                    else
                                                        return "Name is invalid. Must contain at least 8 characters";
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
                                                    hintText: "Enter your full name",
                                                ),
                                            ),
                                        ),
                                    ),

                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                                ScreenUtil().setWidth(0),
                                                ScreenUtil().setHeight(15),
                                                ScreenUtil().setWidth(0),
                                                ScreenUtil().setHeight(10)
                                        ),
                                        child: Opacity(
                                            opacity: 0.65,
                                            child: Text("Email ID",
                                                style: TextStyle(fontSize: ScreenUtil().setSp(16)),
                                                textAlign: TextAlign.start,
                                            ),
                                        ),
                                    ),

                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                                ScreenUtil().setWidth(0),
                                                ScreenUtil().setHeight(0),
                                                ScreenUtil().setWidth(0),
                                                ScreenUtil().setHeight(5)
                                        ),
                                        child: Form(
                                            key: _formKey2,
                                            child: TextFormField(
                                                controller: textCon2,
                                                keyboardType: TextInputType.emailAddress,
                                                textAlign: TextAlign.start,
                                                focusNode: node2,
                                                onChanged: (String s) {
                                                    isWriting2 = true;
                                                    valS = "Email id is incorrect";
                                                    _formKey2.currentState.validate();
                                                },
                                                onEditingComplete: () async {
                                                    if(mailVal.hasMatch(textCon2.text)){
                                                        String b = await dbConn.getUser(textCon2.text.toLowerCase());
                                                        if(b == "true"){
                                                            valS = "Email id is already in use!";
                                                            isWriting2 = false;
                                                            _formKey2.currentState.validate();
                                                        } else {
                                                            node2.unfocus();
                                                            node3.requestFocus();
                                                        }
                                                    } else {
                                                        isWriting2 = false;
                                                        valS = "Email id is incorrect";
                                                        _formKey2.currentState.validate();
                                                    }
                                                },
                                                validator: (value){
                                                    if(isWriting2)
                                                        return null;
                                                    else
                                                        return valS;
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

                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                                ScreenUtil().setWidth(0),
                                                ScreenUtil().setHeight(15),
                                                ScreenUtil().setWidth(0),
                                                ScreenUtil().setHeight(10)
                                        ),
                                        child: Opacity(
                                            opacity: 0.65,
                                            child: Text("Password",
                                                style: TextStyle(fontSize: ScreenUtil().setSp(16)),
                                                textAlign: TextAlign.start,
                                            ),
                                        ),
                                    ),

                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                                ScreenUtil().setWidth(0),
                                                ScreenUtil().setHeight(0),
                                                ScreenUtil().setWidth(0),
                                                ScreenUtil().setHeight(5)
                                        ),
                                        child: Form(
                                            key: _formKey3,
                                            child: TextFormField(
                                                controller: textCon3,
                                                textAlign: TextAlign.start,
                                                focusNode: node3,
                                                autocorrect: false,
                                                obscureText: true,
                                                onChanged: (String s) {
                                                    isWriting3 = true;
                                                    _formKey3.currentState.validate();
                                                },
                                                onEditingComplete: () async {
                                                    pushOTP();
                                                },
                                                validator: (value){
                                                    if(isWriting3)
                                                        return null;
                                                    else
                                                        return "Password is invalid. Must contain at least 8 characters";
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
                                                    hintText: "Enter your password",
                                                ),
                                                inputFormatters: [
                                                      
                                                ],
                                            ),
                                        ),
                                    ),

                                    Container(
                                        padding: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(10), 0, 0),
                                        alignment: Alignment.bottomCenter,
                                        child: RaisedButton(
                                            color: Colors.black,
                                            child: Text("Sign Up", style: TextStyle(color: Colors.white),),
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
                                                Text("Already have an account? ",
                                                    style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                                ),
                                                GestureDetector(
                                                    child: Text("Log in",
                                                        style: TextStyle(fontSize: ScreenUtil().setSp(15),
                                                                fontWeight: FontWeight.w300,
                                                                decoration: TextDecoration.underline,
                                                                color: Colors.lightBlue
                                                        ),
                                                        textAlign: TextAlign.start,
                                                    ),
                                                    onTap: (){
                                                        FocusScope.of(context).unfocus();
                                                        pageCon.jumpToPage(1);
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
                ],
              ),
            ),
        );
    }

    @override
    bool get wantKeepAlive => true;

    pushOTP() async {
        FocusScope.of(context).unfocus();
        bool b1 = nameVal.hasMatch(textCon1.text);
        bool b2 = mailVal.hasMatch(textCon2.text);
        bool b3 = passVal.hasMatch(textCon3.text);

        if(b1 && b2 && b3) {
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
            String s = await dbConn.getUser(textCon2.text.toLowerCase());
            Navigator.pop(context);
            if(s == "true"){
                valS = "Email id is already in use!";
                isWriting2 = false;
                _formKey2.currentState.validate();
            } else if(s == "false") {
                if(await dbConn.registerUser(textCon1.text, textCon2.text, textCon3.text))
                    pageCon.jumpToPage(2);
                else
                    Fluttertoast.showToast(msg: "Could not create account",
                        textColor: Colors.black,
                        fontSize: ScreenUtil().setSp(20),
                        toastLength: Toast.LENGTH_LONG,
                    );
            } else {
                Fluttertoast.showToast(msg: "Could not create account",
                    textColor: Colors.black,
                    fontSize: ScreenUtil().setSp(20),
                    toastLength: Toast.LENGTH_LONG,
                );
            }
        } else {
            if(!b1) {
                isWriting1 = false;
                _formKey1.currentState.validate();
            }
            if(!b2) {
                isWriting2 = false;
                _formKey2.currentState.validate();
            }
            if(!b3) {
                isWriting3 = false;
                _formKey3.currentState.validate();
            }
        }

    }

}