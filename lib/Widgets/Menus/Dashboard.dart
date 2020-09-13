import 'package:Bookmytrainings/Widgets/HomePageWidgets/TopCategories.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'package:Bookmytrainings/Widgets/HomePageWidgets/HomeBanner.dart';

class Dashboard extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _DashboardState();
  }

}

class _DashboardState extends State<Dashboard> with AutomaticKeepAliveClientMixin<Dashboard>{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
  super.build(context);

  ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);
    MediaQueryData m = MediaQuery.of(context);

    return Container(
        height: ScreenUtil().setHeight(470),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

              SizedBox(
                  width: m.size.width,
                  height: ScreenUtil().setHeight(12),
              ),

              HomeBanner(),

              SizedBox(
                  height: ScreenUtil().setHeight(6),
              ),

              Container(
                alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(
                          ScreenUtil().setWidth(12),
                          ScreenUtil().setHeight(0),
                          ScreenUtil().setWidth(0),
                          ScreenUtil().setHeight(0),
                  ),
                child: Text("Top Categories",
                    style: TextStyle(
                            fontSize: ScreenUtil().setSp(17),
                            fontWeight: FontWeight.w600
                    ),
                    textAlign: TextAlign.start,
                ),
              ),

              TopCategories(),

          ],
      ),
    );
  }

}