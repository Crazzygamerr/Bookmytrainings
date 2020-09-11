import 'dart:convert';
import 'dart:typed_data';

import 'package:Bookmytrainings/Utility/FutureProvider.dart';
import 'package:Bookmytrainings/Utility/sharedPref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'package:Bookmytrainings/Widgets/ScaffoldWidgets/Profile.dart';
import 'package:Bookmytrainings/Widgets/ScaffoldWidgets/About.dart';
import 'package:Bookmytrainings/Widgets/UnderDev/EditProfile.dart';
import 'package:Bookmytrainings/Widgets/ScaffoldWidgets/ProfileImage.dart';

class UserProfile extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _UserProfileState();
  }

}

class _UserProfileState extends State<UserProfile>{

    String s = "Assets/User.png";
    String s1 = "Assets/User.png";
    Uint8List u;

    @override
  void initState() {
    super.initState();
    loadPrefs();
    SharedPref.getImgFromPref().then((uL){
        String t;
        if(u != null)
            t = base64Encode(u);
        if(uL != null && uL != t)
            setState(() {
                u = base64Decode(uL);
            });
    });
  }

  String name,email, id;

  loadPrefs() async {
      SharedPref pref = new SharedPref();
      name = await pref.getName();
      email = await pref.getEmail();
  }


  @override
  Widget build(BuildContext context1) {

      ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);
    MediaQueryData m = MediaQuery.of(context1);


    return Container(
        decoration: BoxDecoration(color: (s == "Assets/User.png" && u == null) ? Colors.lightBlueAccent : Colors.transparent,
                shape: BoxShape.circle,
        ),
        padding: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(2),
                ScreenUtil().setHeight(2),
                ScreenUtil().setWidth(2),
                ScreenUtil().setHeight(2)
        ),
        child: GestureDetector(
            onTap: (){
                FutureProvider.of(context).focusNode.unfocus();
                _showSheet(
                    m,
                    context1,
                    (String uL){
                        setState(() {
                        if(uL != null)
                            u = base64Decode(uL);
                        });
                    },
                    name,
                    email,
                );
            },
            child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: (u == null) ? AssetImage(s) : MemoryImage(u),
                radius: (s == "Assets/User.png" && u == null)?  ScreenUtil().setWidth(24):22,
            ),
        ),
    );
  }

  PageController pPageCon = new PageController(initialPage: 0);

  _showSheet(MediaQueryData m, BuildContext context1, Function func, String name, String email) {

      var sheet;
      sheet = showModalBottomSheet(
              isScrollControlled: true,
              enableDrag: true,
              context: context1,
              backgroundColor: Colors.transparent,
              barrierColor: Colors.black.withOpacity(0.85),
              builder: (context) {
                  return StatefulBuilder(
                          builder: (BuildContext context, StateSetter setSheetState ) {

                              ProfileImage profileImage = ProfileImage(pPageCon, u);
                              /*AddProfileImage addProfileImage = AddProfileImage((String u){
                                  profileImage.setSt(u);
                              },
                                  (String u){
                                        func(u);
                                  },
                                      pPageCon,
                              );*/

                              return WillPopScope(
                                  onWillPop: () async {
                                      if(pPageCon.page == 0)
                                          return true;
                                      else{
                                          pPageCon.jumpToPage(0);
                                          return false;
                                      }
                                  },
                                  child: SafeArea(
                                    child: SingleChildScrollView(
                                      child: Container(
                                          height: ScreenUtil().setHeight(588),
                                          color: Colors.transparent,
                                          child: Stack(
                                              children: <Widget>[

                                                  Positioned(
                                                      child: Column(
                                                        children: [

                                                          SizedBox(
                                                              height: ScreenUtil().setHeight(44),
                                                          ),

                                                          Container(
                                                              height: ScreenUtil().setHeight(544),
                                                              width: ScreenUtil().setWidth(360),
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius.circular(10),
                                                                      topRight: Radius.circular(10),
                                                                  ),
                                                                  color: Colors.white,
                                                              ),
                                                              child: Column(
                                                                children: [

                                                                  SizedBox(
                                                                      height: ScreenUtil().setHeight(60),
                                                                  ),

                                                                  Container(
                                                                      width: m.size.width,
                                                                      //color: Colors.yellow,
                                                                      height: ScreenUtil().setHeight(480),
                                                                      child: PageView(
                                                                          controller: pPageCon,
                                                                          physics: new NeverScrollableScrollPhysics(),
                                                                          children: <Widget>[

                                                                              Profile(
                                                                                  (int index){
                                                                                        pPageCon.jumpToPage(index);
                                                                                  },
                                                                                  name,
                                                                                  email,
                                                                              ),

                                                                              EditProfile(
                                                                                (int index) {
                                                                                  pPageCon.jumpToPage(index);
                                                                                },
                                                                                id,
                                                                                name,
                                                                                email,
                                                                              ),

                                                                              AboutBMT((int index){
                                                                                  pPageCon.jumpToPage(index);
                                                                              }),

                                                                              /*HelpAndFeedback((int index){
                                                                                  pPageCon.jumpToPage(index);
                                                                              }),*/

                                                                          ],
                                                                      ),
                                                                  ),
                                                                ],
                                                              ),
                                                          ),
                                                        ],
                                                      ),
                                                      top: 0,
                                                      left: 0,
                                                  ),

                                                  Positioned(
                                                      child: Row(
                                                          children: <Widget>[

                                                              SizedBox(
                                                                  width: ScreenUtil().setWidth(136),
                                                              ),

                                                              profileImage,

                                                          ],
                                                      ),
                                                      top: 0,
                                                      left: 0,
                                                  ),
                                                  //TODO: Compete the addProfileImage button with a ability to store the image in database
                                                  /*Positioned(
                                                      child: Row(
                                                          crossAxisAlignment:  CrossAxisAlignment.center,
                                                          children: <Widget>[

                                                              SizedBox(
                                                                  width: ScreenUtil().setWidth(195),
                                                                  height: ScreenUtil().setHeight(132),
                                                              ),

                                                              addProfileImage,

                                                          ],
                                                      ),
                                                      top: 0,
                                                      left: 0,
                                                  ),*/

                                                  Positioned(
                                                      child: Container(
                                                          width: ScreenUtil().setWidth(45),
                                                          height: ScreenUtil().setHeight(95),
                                                          child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: <Widget>[
                                                                  SizedBox(
                                                                      height: ScreenUtil().setHeight(48),
                                                                      width: ScreenUtil().setWidth(65),
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: (){
                                                                        Navigator.pop(context);
                                                                    },
                                                                    child: Container(
                                                                        width: ScreenUtil().setWidth(45),
                                                                        height: ScreenUtil().setHeight(45),
                                                                        alignment: Alignment.topLeft,
                                                                        child: Icon(
                                                                            Icons.cancel,
                                                                            size: ScreenUtil().setWidth(40),
                                                                            color: Colors.redAccent,
                                                                        ),
                                                                    ),
                                                                  ),
                                                              ],
                                                          ),
                                                          //color: Colors.green,
                                                      ),
                                                      top: 0,
                                                      right: 0,
                                                  ),


                                              ],
                                          ),
                                      ),
                                    ),
                                  ),
                              );
                          });
              }
      );

  }

}

