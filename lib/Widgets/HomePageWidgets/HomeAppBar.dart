import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Bookmytrainings/Widgets/ScaffoldWidgets/UserProfile.dart';
import 'package:Bookmytrainings/Widgets/UnderDev/Notifications.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {

  ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);
  return Container(
      height: ScreenUtil().setHeight(80),
      child: Column(
        children: [

          SizedBox(
              height: ScreenUtil().setHeight(15),
          ),

          Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                    UserProfile(),

                    SizedBox(
                        width: ScreenUtil().setWidth(40),
                    ),

                    Container(
                        color: Colors.transparent,
                      //width: 200,
                      height: ScreenUtil().setHeight(65),
                      //padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                      child: Center(
                        child: Image.asset("Assets/LOGO/drawable-xhdpi/Logo1.png",
                            height: ScreenUtil().setHeight(65),
                            //width: ScreenUtil().setWidth(130),
                        ),
                      ),
                    ),

                    SizedBox(
                        width: ScreenUtil().setWidth(75),
                    )

                    //Notifications(),

                ],
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtil().setHeight(80));

}