import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class HomeBottomAppBar extends StatefulWidget {
    
  final Function jumpPage;
    
    @override
  _HomeBottomAppBarState createState() => _HomeBottomAppBarState();
  
  HomeBottomAppBar(this.jumpPage);
  
}

class _HomeBottomAppBarState extends State<HomeBottomAppBar> {

    int homePageNum = 0;
    
  @override
  Widget build(BuildContext context) {

  ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);

  return Container(
        height: ScreenUtil().setHeight(68),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
                InkWell(
                    borderRadius: BorderRadius.circular(180),
                    onTap: () {
                        setState(() {
                            homePageNum = 0;
                            widget.jumpPage(homePageNum);
                        });
                    },
                    child: Container(
                        height: ScreenUtil().setHeight(75),
                        width: ScreenUtil().setWidth(75),
                        decoration: BoxDecoration(shape: BoxShape.circle,
                            color: (homePageNum == 0)?Colors.grey.withOpacity(0.1) : Colors.transparent,
                        ),
                        //padding: EdgeInsets.all(8),
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Container(
                                    width: ScreenUtil().setWidth(25),
                                    height: ScreenUtil().setHeight(20),
                                    child: Image.asset(
                                            (homePageNum == 0)? "Assets/redAppbarIcon1/drawable-xhdpi/transportationRed.png":
                                            "Assets/AppbarIcon1/drawable-xhdpi/transportation.png"
                                    ),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: ScreenUtil().setHeight(7),
                                ),
                                Text("COURSES",
                                        style: TextStyle(color: (homePageNum == 0)? Colors.red : Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: ScreenUtil().setSp(11)
                                        )
                                ),
                            ],
                        ),
                    ),
                ),
                InkWell(
                    borderRadius: BorderRadius.circular(180),
                    onTap: () {
                        setState(() {
                            homePageNum = 1;
                            widget.jumpPage(homePageNum);
                        });
                    },
                    child: Container(
                        height: ScreenUtil().setHeight(75),
                        width: ScreenUtil().setWidth(75),
                        decoration: BoxDecoration(shape: BoxShape.circle,
                                color: (homePageNum == 1)?Colors.grey.withOpacity(0.1) : Colors.transparent
                        ),
                        //padding: EdgeInsets.all(8),
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Container(
                                    width: ScreenUtil().setWidth(25),
                                    height: ScreenUtil().setHeight(20),
                                    child: Image.asset(
                                            (homePageNum == 1)? "Assets/redAppbarIcon2/drawable-xhdpi/checkRed.png":
                                            "Assets/AppbarIcon2/drawable-xhdpi/check.png"
                                    ),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: ScreenUtil().setHeight(7),
                                ),
                                Text("BOOKINGS",
                                        style: TextStyle(color: (homePageNum == 1)? Colors.red : Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: ScreenUtil().setSp(11)
                                        )
                                ),
                            ],
                        ),
                    ),
                ),
                InkWell(
                    borderRadius: BorderRadius.circular(180),
                    onTap: () {
                        setState(() {
                            homePageNum = 2;
                            widget.jumpPage(homePageNum);
                        });
                    },
                    child: Container(
                        height: ScreenUtil().setHeight(75),
                        width: ScreenUtil().setWidth(75),
                        decoration: BoxDecoration(shape: BoxShape.circle,
                                color: (homePageNum == 2)?Colors.grey.withOpacity(0.1) : Colors.transparent
                        ),
                        //padding: EdgeInsets.all(8),
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Container(
                                    width: ScreenUtil().setWidth(25),
                                    height: ScreenUtil().setHeight(20),
                                    child: Image.asset(
                                            (homePageNum == 2)? "Assets/redAppbarIcon3/drawable-xhdpi/moneyRed.png":
                                            "Assets/AppbarIcon2/drawable-xhdpi/money.png"
                                    ),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: ScreenUtil().setHeight(7),
                                ),
                                Text("PAYMENTS",
                                        style: TextStyle(color: (homePageNum == 2)? Colors.red : Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: ScreenUtil().setSp(11)
                                        )
                                ),
                            ],
                        ),
                    ),
                ),
                InkWell(
                    borderRadius: BorderRadius.circular(180),
                    onTap: () {
                        setState(() {
                            homePageNum = 3;
                            widget.jumpPage(homePageNum);
                        });
                    },
                    child: Container(
                        height: ScreenUtil().setHeight(75),
                        width: ScreenUtil().setWidth(75),
                        decoration: BoxDecoration(shape: BoxShape.circle,
                                color: (homePageNum == 3)?Colors.grey.withOpacity(0.1) : Colors.transparent
                        ),
                        //padding: EdgeInsets.all(8),
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Container(
                                        width: ScreenUtil().setWidth(25),
                                        height: ScreenUtil().setHeight(20),
                                        child: Icon(Icons.chat,
                                                size: ScreenUtil().setWidth(20),
                                                color:(homePageNum == 3)? Colors.red : Colors.black
                                        )
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: ScreenUtil().setHeight(7),
                                ),
                                Text("CHAT",
                                        style: TextStyle(color: (homePageNum == 3)? Colors.red : Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: ScreenUtil().setSp(11)
                                        )
                                ),
                            ],
                        ),
                    ),
                ),
            ],
        ),
    );
  }
  
}
