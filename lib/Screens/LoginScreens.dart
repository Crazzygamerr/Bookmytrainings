import 'package:Bookmytrainings/Utility/FutureProvider.dart';
import 'package:Bookmytrainings/Utility/Banner_Model.dart';
import 'package:Bookmytrainings/Utility/pHp.dart';
import 'package:Bookmytrainings/Widgets/Menus/Login.dart';
import 'package:Bookmytrainings/Widgets/Menus/OTP.dart';
import 'package:Bookmytrainings/Widgets/Menus/Register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreens extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _LoginScreensState();
  }

}


class _LoginScreensState extends State<LoginScreens> {

  PageController pageCon = new PageController(initialPage: 1);
  Stream<QuerySnapshot> loadBanners;

  @override
  Widget build(BuildContext context) {

      ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);
      SystemChrome.setEnabledSystemUIOverlays([]);
      SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
      ]);

      return FutureProvider(
        pageCon: pageCon,
        //loadBanners: loadBanners,
        child: WillPopScope(
            onWillPop: () async {
                if(pageCon.page == 0 || pageCon.page == 1)
                    return true;
                else {
                    pageCon.jumpToPage(1);
                    return false;
                }
            },
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                body: Container(
                  height: ScreenUtil().setHeight(640),
                  width: ScreenUtil().setWidth(360),
                  child: SafeArea(
                      child: PageView(
                            controller: pageCon,
                            physics: NeverScrollableScrollPhysics(),
                            children: [

                                Register(),

                                Login(),

                                OTP(),

                            ],
                        ),
                  ),
                ),
            ),
        ),
    );
  }

}
