import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutBMT extends StatefulWidget {

    final changePage;

    @override
    _AboutBMTState createState() => _AboutBMTState();

    AboutBMT(this.changePage);
}

class _AboutBMTState extends State<AboutBMT> with AutomaticKeepAliveClientMixin<AboutBMT> {
    @override
    Widget build(BuildContext context) {
      super.build(context);

        ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);
        return SingleChildScrollView(
          child: Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(16),
                    ScreenUtil().setHeight(16),
                    ScreenUtil().setWidth(16),
                    ScreenUtil().setHeight(16),
                ),
                  child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, ScreenUtil().setHeight(16)),
                                  width: ScreenUtil().setWidth(360),
                                  child: Text("ABOUT BOOKMYTRAININGS.COM",
                                      style: TextStyle(fontSize: ScreenUtil()
                                              .setSp(16), fontWeight: FontWeight
                                              .w700),
                                      textAlign: TextAlign.start,
                                  ),
                              ),

                              Text("Welcome to Bookmytrainings.com,\nIndia’s #1 Training Marketplace "
                                      "that provides a platform that helps individuals discover, "
                                      "evaluate and choose right course for improving their knowledge"
                                      " and skills. The portal serving individuals and corporates"
                                      " since 2011 and so far has helped 5000+ learners and 200+"
                                      " corporate HR/L&D managers.\n\nOne can find all training related"
                                      " events/workshops/conferences/seminars happenings across cities"
                                      " in India. Not only that.",
                                  style: TextStyle(fontSize: ScreenUtil().setSp(12)),
                              ),

                            SizedBox(
                              height: ScreenUtil().setHeight(50),
                            ),

                            Container(
                              height: 1,
                              width: ScreenUtil().setWidth(360),
                              color: Colors.black.withOpacity(0.25),
                            ),

                            Container(
                              width: ScreenUtil().setWidth(360),
                              padding: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(16), 0, 0),
                              child: Text("Bookmytrainings.com Private Limited\n"
                                   "#1101, “Golden Square”, 24th Main,\n"
                                   "J.P Nagar 1st Phase, Bengaluru- 560078\n"
                                   "Mobile : +91 9900095099\n",
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: ScreenUtil().setSp(12)),
                              ),
                            ),

                            Container(
                              width: ScreenUtil().setWidth(360),
                              padding: EdgeInsets.fromLTRB(0, 0, 0, ScreenUtil().setHeight(16)),
                              child: Row(
                                children: <Widget>[
                                  Text("E-mail: ",
                                      style: TextStyle(fontSize: ScreenUtil().setSp(12)),
                                  ),
                                  GestureDetector(
                                    child: Text("enquiry@bookmytrainings.net",
                                      style: TextStyle(fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.w300,
                                        decoration: TextDecoration.underline,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    onTap: (){
                                        _urlFunc("enquiry@bookmytrainings.net", "mailto:");
                                    },
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, ScreenUtil().setHeight(16)),
                              child: Row(
                                children: <Widget>[
                                  Text("Location: ",
                                      style: TextStyle(fontSize: ScreenUtil().setSp(12)),
                                  ),
                                  GestureDetector(
                                    child: Text("Google Maps",
                                      style: TextStyle(fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.w300,
                                        decoration: TextDecoration.underline,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    onTap: (){
                                      _urlFunc("https://www.google.com/maps/place/BookMyTrainings.com"
                                              "+Pvt.+Ltd/@12.9150207,77.5834857,17z/data="
                                              "!3m1!4b1!4m5!3m4!1s0x3bae1509922ee9f1:0xf34e8b1a58615f9c"
                                              "!8m2!3d12.9150207!4d77.5856744", "");
                                    },
                                  ),
                                ],
                              ),
                            ),

                            Text("Copyright © 2011-2019 Bookmytrainings.com Pvt. Ltd. | All Rights Reserved"
                                    "\nPrivacy Policy | Terms of Use",
                                style: TextStyle(fontSize: ScreenUtil().setSp(12)),
                            ),

                          ]
                  )
          ),
        );
    }

    _urlFunc(String url, String s) async{
      if(await canLaunch("$s$url")){
        await launch("$s$url");
      } else {
        Fluttertoast.showToast(msg: "Could not perform action",
          textColor: Colors.black,
          fontSize: ScreenUtil().setSp(20),
          toastLength: Toast.LENGTH_LONG,
        );
      }

    }

  @override
  bool get wantKeepAlive => true;

}
