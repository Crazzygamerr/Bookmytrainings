import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Notifications extends StatefulWidget {

    @override
    State<StatefulWidget> createState() {
        return _NotificationsState();
    }

}

class _NotificationsState extends State<Notifications> {

    int notifications = 6;

    @override
    Widget build(BuildContext context) {

        ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);
        MediaQueryData m = MediaQuery.of(context);

        return Container(
            decoration: BoxDecoration(color: Colors
                    .grey, shape: BoxShape.circle),
            padding: EdgeInsets.all(1),
            child: Stack(
                    children: <Widget>[
                        CircleAvatar(child: IconButton(icon: Icon(Icons.notifications_none,
                            color: Colors.black,
                        ),
                            onPressed: () {
                                _showSheet(notifications, m);
                            },
                        ),
                            backgroundColor: Colors.white,
                            radius: 20,
                        ),
                        Positioned(
                            child: Icon(Icons.brightness_1, color: Colors.orange, size: 9,),
                            top: 1,
                            right: 1,
                        ),
                    ]
            ),
        );

    }

    _showSheet(int notifications, MediaQueryData m) {

        // ignore: unused_local_variable
        var sheet;
        sheet = showModalBottomSheet(
                isScrollControlled: true,
                enableDrag: true,
                context: context,
                backgroundColor: Colors.transparent,
                barrierColor: Colors.black.withOpacity(0.75),
                builder: (context) =>
                        Container(
                            height: ScreenUtil().setHeight(588),
                            color: Colors.transparent,
                            child: Stack(
                                children: <Widget>[

                                    Positioned(
                                        child: Container(
                                            height: ScreenUtil().setHeight(544),
                                            width: ScreenUtil().setWidth(360),
                                            padding: EdgeInsets.fromLTRB(0, 47, 0, 0),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(10),
                                                    topRight: Radius.circular(10),
                                                ),
                                                color: Colors.white,
                                            ),
                                            child: (notifications == 0) ?
                                            Column(
                                                //crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                    Container(
                                                        padding: EdgeInsets.all(16),
                                                        width: m.size.width,
                                                        child: Text("NOTIFICATIONS",
                                                            style: TextStyle(fontSize: ScreenUtil()
                                                                    .setSp(16), fontWeight: FontWeight
                                                                    .w700),
                                                            textAlign: TextAlign.start,
                                                        ),
                                                    ),

                                                    SizedBox(
                                                        height: ScreenUtil().setHeight(80),
                                                    ),

                                                    Expanded(
                                                        child: Padding(
                                                            padding: const EdgeInsets
                                                                    .fromLTRB(0, 10, 0, 8),
                                                            child: Text("No Notifications yet...",
                                                                style: TextStyle(fontSize: ScreenUtil()
                                                                        .setSp(24),
                                                                        fontWeight: FontWeight.w500,
                                                                        color: Colors.black
                                                                                .withOpacity(0.5)
                                                                ),
                                                                textAlign: TextAlign.center,
                                                            ),
                                                        ),
                                                    ),

                                                ],
                                            )
                                                    :
                                            Container(
                                                width: m.size.width,
                                                child: Column(
                                                    //crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: <Widget>[
                                                            Container(
                                                                padding: EdgeInsets
                                                                        .fromLTRB(16, 16, 16, 6),
                                                                width: m.size.width,
                                                                child: Text("NOTIFICATIONS \($notifications\)",
                                                                    style: TextStyle(fontSize: ScreenUtil()
                                                                            .setSp(16),
                                                                        fontWeight: FontWeight.w700,
                                                                    ),
                                                                    textAlign: TextAlign.start,
                                                                ),
                                                            ),

                                                            Container(
                                                                width: m.size.width,
                                                                height: ScreenUtil().setHeight(425),
                                                                child: ListView.builder(
                                                                        physics: BouncingScrollPhysics(),
                                                                        scrollDirection: Axis
                                                                                .vertical,
                                                                        itemCount: notifications,
                                                                        itemBuilder: (context, pos) {
                                                                            return Opacity(
                                                                                opacity: (pos % 2 ==0)?1:0.5,
                                                                              child: Padding(
                                                                                  padding: const EdgeInsets
                                                                                          .fromLTRB(8, 5, 8, 5),
                                                                                  child: Card(
                                                                                      elevation: 3,
                                                                                      child: Container(
                                                                                          height: ScreenUtil()
                                                                                                  .setHeight(72),
                                                                                          width: ScreenUtil()
                                                                                                  .setWidth(328),
                                                                                          padding: EdgeInsets
                                                                                                  .fromLTRB(10, 10, 10, 0),
                                                                                          child: Text("Payment has been partially made. "
                                                                                                  "Booking ID:#0001234, Lead yourself to the true "
                                                                                                  "unlimited you - Free Webinar"),
                                                                                      ),
                                                                                  ),
                                                                              ),
                                                                            );
                                                                        }
                                                                ),
                                                            ),

                                                        ]
                                                ),
                                            )

                                            ,
                                        ),
                                        top: (44/640)*m.size.height,
                                        left: 0,
                                    ),

                                    Positioned(
                                        child: Row(
                                            children: <Widget>[

                                                SizedBox(
                                                    width: ScreenUtil()
                                                            .setWidth(136),
                                                ),

                                                Container(
                                                    decoration: BoxDecoration(color: Colors
                                                            .white, shape: BoxShape.circle,
                                                            boxShadow: [
                                                                //color: Colors.white
                                                                BoxShadow(
                                                                    color: Colors.grey,
                                                                    blurRadius: 5,
                                                                    //spreadRadius: 5
                                                                )
                                                            ]
                                                    ),
                                                    height: ScreenUtil().setHeight(88),
                                                    width: ScreenUtil().setWidth(88),
                                                    padding: EdgeInsets.all(25),
                                                    child: Image
                                                            .asset("Assets/Notification/drawable-xhdpi/NotificationLogo.png",
                                                    ),
                                                ),

                                            ],
                                        ),
                                        top: 0,
                                        left: 0,
                                    ),

                                    Positioned(
                                        child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                                children: <Widget>[
                                                    SizedBox(
                                                        height: ScreenUtil()
                                                                .setHeight(35),
                                                    ),
                                                    IconButton(icon: Icon(Icons.cancel, size: 40,color: Colors.redAccent,),
                                                        onPressed: (){
                                                            Navigator.pop(context);
                                                        },
                                                    ),
                                                ],
                                            ),
                                        ),
                                        top: 0,
                                        right: 0,
                                    ),


                                ],
                            ),
                        )
        );
    }

}