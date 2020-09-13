import 'package:Bookmytrainings/Screens/LoginScreens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/screenutil.dart';



class Onboarding extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _OnboardingState();
    }
}

class _OnboardingState extends State<Onboarding> {

    PageController pageCon = new PageController(initialPage: 0);
    int pageIndex = 0;
    List<String> but = ["Next","Next","Next","Login",];

    @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        FocusScope.of(context).unfocus();
    });
  }

    @override
    Widget build(BuildContext context) {

        MediaQueryData m = MediaQuery.of(context);
        ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);



        return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Container(
                  //height: ScreenUtil().setHeight(640),
                  //width: ScreenUtil().setWidth(360),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: new AssetImage("Assets/OnboardingBack/drawable-xhdpi/OnBack.png"),
                            fit: BoxFit.contain,
                        alignment: Alignment.topCenter,
                    ),
                ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[

                      Expanded(
                        child: PageView(
                                controller: pageCon,
                                physics: BouncingScrollPhysics(),
                                onPageChanged: (index) {
                                    setState(() {
                                        pageIndex = index;
                                    });
                                },
                                children: <Widget>[

                                    Container(
                                      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(10), 0, ScreenUtil().setWidth(10), 0),
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[

                                              Image.asset("Assets/Onboarding1/drawable-xhdpi/OnImg1.png",
                                                  width: ScreenUtil().setWidth(251),
                                                  height: ScreenUtil().setHeight(213),
                                              ),

                                              SizedBox(
                                                height: ScreenUtil().setHeight(20),
                                              ),

                                              Text("Stay up-to-date with industry",
                                                  style: TextStyle(
                                                      fontSize: ScreenUtil().setSp(27),
                                                  ),
                                                  textAlign: TextAlign.center,
                                              ),

                                              SizedBox(
                                                  height: ScreenUtil().setHeight(18),
                                              ),

                                              Opacity(
                                                  opacity: 0.65,
                                                child: Text("Enroll for the most sought-after courses in the industry today.",
                                                    style: TextStyle(fontSize: ScreenUtil().setSp(15)
                                                    ), textAlign: TextAlign.center,
                                                ),
                                              ),

                                              SizedBox(
                                                  width: m.size.width,
                                                  height: ScreenUtil().setHeight(26),
                                              ),

                                          ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB( ScreenUtil().setWidth(10), 0, ScreenUtil().setWidth(10), 0),
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[

                                              Image.asset("Assets/Onboarding2/drawable-xhdpi/OnImg2.png",
                                                  width: ScreenUtil().setWidth(251),
                                                  height: ScreenUtil().setHeight(213),
                                              ),

                                              SizedBox(
                                                  height: ScreenUtil().setHeight(20),
                                              ),

                                              Text("Top Certifications",
                                                  style: TextStyle(fontSize: ScreenUtil().setSp(27)),
                                                  textAlign: TextAlign.center,
                                              ),

                                              SizedBox(
                                                  height: ScreenUtil().setHeight(18),
                                              ),

                                              Opacity(
                                                  opacity: 0.65,
                                                  child: Text("Get trained and certified by leading industry certification bodies",
                                                      style: TextStyle(fontSize: ScreenUtil().setSp(15)
                                                      ),
                                                      textAlign: TextAlign.center,
                                                  ),
                                              ),

                                              SizedBox(
                                                  width: m.size.width,
                                                  height: ScreenUtil().setHeight(26),
                                              ),

                                          ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB( ScreenUtil().setWidth(10), 0, ScreenUtil().setWidth(10), 0),
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[

                                              Image.asset("Assets/Onboarding3/drawable-xhdpi/OnImg3.png",
                                                  width: ScreenUtil().setWidth(251),
                                                  height: ScreenUtil().setHeight(213),
                                              ),

                                              SizedBox(
                                                  height: ScreenUtil().setHeight(20),
                                              ),

                                              Text("Experience personalised learning",
                                                  style: TextStyle(fontSize: ScreenUtil().setSp(27)),
                                                  textAlign: TextAlign.center,
                                              ),

                                              SizedBox(
                                                  height: ScreenUtil().setHeight(18),
                                              ),

                                              Opacity(
                                                  opacity: 0.65,
                                                  child: Text("Customised offerings to suit your learning needs",
                                                      style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                                      textAlign: TextAlign.center,
                                                  ),
                                              ),

                                              SizedBox(
                                                  height: ScreenUtil().setHeight(26),
                                              ),

                                          ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB( ScreenUtil().setWidth(10), 0, ScreenUtil().setWidth(10), 0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[

                                              Image.asset("Assets/Onboarding4/drawable-xhdpi/OnImg4.png",
                                                  width: ScreenUtil().setWidth(251),
                                                  height: ScreenUtil().setHeight(213),
                                              ),

                                              SizedBox(
                                                  height: ScreenUtil().setHeight(20),
                                              ),

                                              Text("One stop shop for all your learning needs.",
                                                  style: TextStyle(fontSize: ScreenUtil().setSp(27)),
                                                  textAlign: TextAlign.center,
                                              ),

                                              SizedBox(
                                                  height: ScreenUtil().setHeight(18),
                                              ),

                                              Opacity(
                                                  opacity: 0.65,
                                                  child: Text("Discover, Evaluate & Book training programs to boost your career",
                                                      style: TextStyle(fontSize: ScreenUtil().setSp(15)),
                                                      textAlign: TextAlign.center,
                                                  ),
                                              ),

                                              SizedBox(
                                                  height: ScreenUtil().setHeight(26),
                                              ),

                                          ],
                                      ),
                                    ),
                                ]
                        ),
                      ),

                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                                Opacity(
                                    child: Icon(
                                        (pageIndex == 0) ? Icons.brightness_1 : Icons.panorama_fish_eye,
                                        size: 15,
                                        color: (pageIndex == 0) ? Colors.redAccent : Colors.black,
                                    ),
                                    opacity: (pageIndex == 0) ? 1 : 0.4,
                                ),

                                SizedBox(
                                    width: ScreenUtil().setWidth(3),
                                ),

                                Opacity(
                                        child: Icon(
                                            (pageIndex == 1) ? Icons.brightness_1 : Icons.panorama_fish_eye,
                                            size: 15,
                                            color: (pageIndex == 1) ? Colors.redAccent : Colors.black,
                                        ),
                                        opacity: (pageIndex == 1) ? 1 : 0.4
                                ),

                                SizedBox(
                                    width: ScreenUtil().setWidth(3),
                                ),

                                Opacity(
                                        child: Icon(
                                            (pageIndex == 2) ? Icons.brightness_1 : Icons.panorama_fish_eye,
                                            size: 15,
                                            color: (pageIndex == 2) ? Colors.redAccent : Colors.black,
                                        ),
                                        opacity: (pageIndex == 2) ? 1 : 0.4
                                ),

                                SizedBox(
                                    width: ScreenUtil().setWidth(3),
                                ),

                                Opacity(
                                        child: Icon(
                                            (pageIndex == 3) ? Icons.brightness_1 : Icons.panorama_fish_eye,
                                            size: 15,
                                            color: (pageIndex == 3) ? Colors.redAccent : Colors.black,
                                        ),
                                        opacity: (pageIndex == 3) ? 1 : 0.4
                                ),

                            ],
                        ),
                    ],
                  ),
              ),
            ),

            bottomNavigationBar: Container(
              width: ScreenUtil().setWidth(360),
              padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(10),
                      ScreenUtil().setHeight(10),
                      ScreenUtil().setWidth(10),
                      ScreenUtil().setHeight(10)
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[

                      /*SizedBox(
                          width: ScreenUtil().setWidth(10),
                      ),*/

                      FlatButton(
                          child: Text("Skip"),
                          color: Colors.white,
                          onPressed: () {
                              setState(() {
                                  pageCon.animateToPage(3,
                                          duration: Duration(milliseconds: 400),
                                          curve: Curves.easeOut);
                              });
                          },
                      ),

                      RaisedButton(
                          elevation: 0.0,
                          child: Text(but[pageIndex],style: TextStyle(color: Colors.white),),
                          color: Colors.black,
                          onPressed: () {
                              setState(() {
                                if(pageIndex<3) {
                                    pageCon.animateToPage(++pageIndex,
                                            duration: Duration(milliseconds: 250),
                                            curve: Curves.easeOut);
                                }
                                else{
                                 Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(builder: (context) => LoginScreens()), (route) => false);
                                }
                            });
                          },
                      ),

                      /*SizedBox(
                          width: ScreenUtil().setWidth(10),
                      ),*/

                  ],
              ),
            ),
        );
    }
}