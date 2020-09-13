import 'package:Bookmytrainings/Utility/FutureProvider.dart';
import 'package:Bookmytrainings/Utility/SignIn.dart';
import 'package:Bookmytrainings/Utility/sharedPref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Bookmytrainings/Widgets/HomePageWidgets/HomeAppBar.dart';
import 'package:Bookmytrainings/Widgets/Menus/Dashboard.dart';
import 'package:Bookmytrainings/Widgets/Menus/MyBookings.dart';
import 'package:Bookmytrainings/Widgets/Menus/Payments.dart';
import 'package:Bookmytrainings/Widgets/Menus/Chat.dart';
import 'package:Bookmytrainings/Widgets/HomePageWidgets/BottomAppBar.dart';


class HomeScreen extends StatefulWidget {

    @override
    State<StatefulWidget> createState() {
        return _HomeScreenState();
    }

    HomeScreen();

}

class _HomeScreenState extends State<HomeScreen> {

    FocusNode focusNode;

    @override
    void initState() {
        super.initState();
        getMail();
        focusNode = FocusNode();
    }

    getMail() async {
        SharedPref pref = new SharedPref();
        var email = await pref.getEmail();
        var name = await pref.getName();
        var password = await pref.getPassword();
        SignIn authorisation = new SignIn();
        authorisation.userAuth(email, password, name);

        //authorisation.createUser(email, name);
    }

    @override
    Widget build(BuildContext context) { ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);

        //ScreenUtil.instance = ScreenUtil()..init(context);
        //ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true)..init(context);
        PageController hPageCon = new PageController(initialPage: 0);
        SystemChrome.setEnabledSystemUIOverlays([]);
        SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
        ]);

        return FutureProvider(
          focusNode: focusNode,
          child: SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                extendBodyBehindAppBar: true,
                appBar: HomeAppBar(),
                body: Container(
                  width: ScreenUtil().setWidth(360),
                  height: ScreenUtil().setHeight(640),
                  decoration: BoxDecoration(color: Colors.white,
                          image: DecorationImage(image: AssetImage("Assets/OnboardingBack/drawable-xhdpi/OnBack-op3.png"),
                                  fit: BoxFit.contain,
                                  alignment: Alignment.topCenter
                          ),),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                      SizedBox(
                          height: ScreenUtil().setHeight(80),
                      ),

                      Container(
                          height: ScreenUtil().setHeight(480),
                          child: PageView(
                            controller: hPageCon,
                            physics: new NeverScrollableScrollPhysics(),
                            children: <Widget>[

                                Dashboard(),

                                MyBookings(),

                                Payments(),

                                Chat(),

                            ],
                        ),
                      ),

                      HomeBottomAppBar((int index){
                          hPageCon.jumpToPage(index);
                      }),

                    ],
                  ),
                ),
            ),
          ),
        );
    }

}