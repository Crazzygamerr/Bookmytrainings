import 'package:Bookmytrainings/Screens/LoginScreens.dart';
import 'package:Bookmytrainings/Utility/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:app_review/app_review.dart';

class Profile extends StatefulWidget {

  final changePage;
  final name,email;

  @override
  _ProfileState createState() => _ProfileState();

  Profile(this.changePage, this.name, this.email);

}

class _ProfileState extends State<Profile> with AutomaticKeepAliveClientMixin<Profile> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);
    return Container(
        padding: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(8),
                ScreenUtil().setHeight(8),
                ScreenUtil().setWidth(8),
                ScreenUtil().setHeight(8)
        ),
        height: ScreenUtil().setHeight(425),
        width: ScreenUtil().setWidth(360),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                Text("${widget.name}",
                    style: TextStyle(fontSize: ScreenUtil().setSp(20),
                        fontWeight: FontWeight.w700
                    ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 2, 0, ScreenUtil().setHeight(15)),
                  child: Text("${widget.email}",
                      style: TextStyle(fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w400
                      ),
                  ),
                ),

                // Complete the EditProfile window and add this button
                /*Container(
                  decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.black.withOpacity(0.4),),
                                right: BorderSide(color: Colors.black.withOpacity(0.4),),
                                left: BorderSide(color: Colors.black.withOpacity(0.4),),
                                bottom: BorderSide(color: Colors.black.withOpacity(0.4),),
                        ),
                  ),
                  width: ScreenUtil().setWidth(110),
                  height: ScreenUtil().setHeight(32),
                  child: FlatButton(
                      child: Text("MY PROFILE",
                          style: TextStyle(fontSize: ScreenUtil().setSp(11),
                              fontWeight: FontWeight.w400,
                          ),
                      ),
                      color: Colors.white,
                      onPressed: () {
                          setState(() {
                              widget.changePage(1);
                          });
                      },
                  ),
                ),*/

                SizedBox(
                    height: ScreenUtil().setHeight(15),
                ),

                Container(
                    height: 1,
                    width: ScreenUtil().setWidth(360),
                    color: Colors.black.withOpacity(0.1),
                ),

                Container(
                    height: ScreenUtil().setHeight(56),
                    width: ScreenUtil().setWidth(360),
                  child: FlatButton(
                      child: Text("ABOUT BOOKMYTRAININGS",
                          style: TextStyle(fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w400,
                          ),
                      ),
                      color: Colors.white,
                      onPressed: () {
                          setState(() {
                              widget.changePage(2);
                          });
                      },
                  ),
                ),

                Container(
                    height: 1,
                    width: ScreenUtil().setWidth(360),
                    color: Colors.black.withOpacity(0.1),
                ),

                Container(
                    height: ScreenUtil().setHeight(56),
                    width: ScreenUtil().setWidth(360),
                    child: FlatButton(
                        child: Text("RATE APP",
                            style: TextStyle(fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w400,
                            ),
                        ),
                        color: Colors.white,
                        onPressed: () {
                            AppReview.requestReview.then((value) => (){
                                Fluttertoast.showToast(msg: "Thank you for your review!",
                                    textColor: Colors.black,
                                    fontSize: ScreenUtil().setSp(20),
                                    toastLength: Toast.LENGTH_LONG,
                                );
                            });
                        },
                    ),
                ),

                Container(
                    height: 1,
                    width: ScreenUtil().setWidth(360),
                    color: Colors.black.withOpacity(0.1),
                ),

                Container(
                    height: ScreenUtil().setHeight(56),
                    width: ScreenUtil().setWidth(360),
                    child: FlatButton(
                        child: Text("SHARE BOOKMYTRAININGS APP",
                            style: TextStyle(fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w400,
                            ),
                        ),
                        color: Colors.white,
                        onPressed: () {
                            setState(() {
                                Share.share("Discover and book trainings to boost your career. "
                                            "Download Bookmytrainings app at "
                                        "https://play.google.com/store/apps/"
                                        "details?id=com.mobile.Bookmytrainings");
                            });
                        },
                    ),
                ),

                Container(
                    height: 1,
                    width: ScreenUtil().setWidth(360),
                    color: Colors.black.withOpacity(0.1),
                ),

                /*Container(
                    height: ScreenUtil().setHeight(56),
                    width: ScreenUtil().setWidth(360),
                  child: FlatButton(
                      child: Text("HELP & FEEDBACK",
                          style: TextStyle(fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w400,
                          ),
                      ),
                      color: Colors.white,
                      onPressed: () {
                          setState(() {
                              widget.changePage(3);
                          });
                      },
                  ),
                ),*/

                Container(
                    height: ScreenUtil().setHeight(56),
                    width: ScreenUtil().setWidth(360),
                    child: FlatButton(
                        child: Text("PRIVACY POLICY",
                            style: TextStyle(fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w400,
                            ),
                        ),
                        color: Colors.white,
                        onPressed: () async {
                            await launch("https://www.bookmytrainings.com/website-terms-of-use-privacy-policy");
                        },
                    ),
                ),

                Container(
                    height: 1,
                    width: ScreenUtil().setWidth(360),
                    color: Colors.black.withOpacity(0.1),
                ),

                SizedBox(
                    height: ScreenUtil().setHeight(50),
                ),

                Container(
                    height: ScreenUtil().setHeight(32),
                    width: ScreenUtil().setWidth(100),
                  child: RaisedButton(
                      elevation: 0.0,
                      child: Text("LOG OUT",
                          style: TextStyle(color: Colors.white,
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w400
                          ),
                      ),
                      color: Colors.black,
                      onPressed: () {
                          SharedPref pref = new SharedPref();
                          pref.setUserLogin(false);
                          Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => LoginScreens()), (route) => false);
                      },
                  ),
                ),

            ],
        ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
