import 'package:Bookmytrainings/Utility/pHp.dart';
import 'package:Bookmytrainings/Utility/Booking_Model.dart';
import 'package:Bookmytrainings/Utility/sharedPref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maps_launcher/maps_launcher.dart';

class MyBookings extends StatefulWidget {

    @override
    State<StatefulWidget> createState() {
        return _MyBookingsState();
    }

}

class _MyBookingsState extends State<MyBookings> with AutomaticKeepAliveClientMixin {

    PageController bPageCon = new PageController(initialPage: 0, viewportFraction: 0.9);
    //WebViewController _controller;
    String email;
    List<double> op = List();
    List<StateSetter> setLoading = List();

    Future<List<BookingModel>> setB() async {
        SharedPref pref = new SharedPref();
        email = await pref.getEmail();
        Php dbConn = new Php();
        return dbConn.getBookings(email);
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);

        ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);
        MediaQueryData m = MediaQuery.of(context);

        //Future.delayed(Duration(milliseconds: 1000)).then((value) => _noBookKey.currentState.show());
        
        return Container(
            height: ScreenUtil().setHeight(480),
          child: FutureBuilder<List<BookingModel>>(
              future: setB(),
              builder: (BuildContext context, AsyncSnapshot<List<BookingModel>> snapshot) {

                  if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                          child: Container(
                                  width: ScreenUtil().setWidth(20),
                                  height: ScreenUtil().setWidth(20),
                                  child: CircularProgressIndicator()
                          ),
                      );
                  } else if (!snapshot.hasData || snapshot.hasError) {
                      return SingleChildScrollView(
                        child: Container(
                          height: ScreenUtil().setHeight(480),
                          child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.fromLTRB(
                                                ScreenUtil().setWidth(16),
                                                ScreenUtil().setHeight(16),
                                                ScreenUtil().setWidth(16),
                                                ScreenUtil().setWidth(16),
                                        ),
                                        width: m.size.width,
                                        child: Text("MY BOOKINGS",
                                            style: TextStyle(fontSize: ScreenUtil().setSp(16), fontWeight: FontWeight.w700),
                                            textAlign: TextAlign.start,
                                        ),
                                    ),

                                    SizedBox(
                                        height: ScreenUtil().setHeight(80),
                                    ),

                                    Expanded(
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[

                                                Image.asset("Assets/BlueCheck/drawable-xhdpi/check.png",
                                                    height: ScreenUtil().setHeight(113),
                                                    width: ScreenUtil().setWidth(120),
                                                ),

                                                SizedBox(
                                                    height: ScreenUtil().setHeight(10),
                                                ),

                                                Text("No Bookings are\n Available",
                                                    style: TextStyle(fontSize: ScreenUtil().setSp(24), fontWeight: FontWeight.w500),
                                                    textAlign: TextAlign.center,
                                                ),

                                                SizedBox(
                                                    height: ScreenUtil().setHeight(16),
                                                ),

                                                Text("Sorry, No bookings are available,",
                                                    style: TextStyle(fontSize: ScreenUtil().setSp(16), fontWeight: FontWeight.w300),
                                                    textAlign: TextAlign.center,
                                                ),

                                                SizedBox(
                                                    height: ScreenUtil().setHeight(8),
                                                ),

                                                GestureDetector(
                                                  onTap: () {
                                                        _urlFunc("https://www.bookmytrainings.com/");
                                                    },
                                                  child: Material(
                                                      elevation: 5,
                                                      borderRadius: BorderRadius.circular(5),
                                                    child: Container(
                                                      height: ScreenUtil().setHeight(35),
                                                      width: ScreenUtil().setWidth(125),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          color: Colors.black,
                                                      ),
                                                      child: Center(
                                                        child: Text("Browse Trainings",
                                                              style: TextStyle(color: Colors.white,
                                                                  fontSize: ScreenUtil().setSp(12),
                                                                  fontWeight: FontWeight.w400,
                                                              ),
                                                          ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                        ),
                                    ),

                                ],
                            ),
                        ),
                      );
                  } else {

                      return Container(
                          width: m.size.width,
                          height: ScreenUtil().setHeight(480),
                          child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[

                                      SizedBox(
                                          width: ScreenUtil().setWidth(16),
                                      ),

                                      Container(
                                          padding: EdgeInsets.fromLTRB(
                                                  ScreenUtil().setWidth(16),
                                                  ScreenUtil().setHeight(16),
                                                  0,
                                                  ScreenUtil().setHeight(16),
                                          ),
                                          width: m.size.width,
                                          child: Text("MY BOOKINGS \(${snapshot.data.length}\)",
                                              style: TextStyle(fontSize: ScreenUtil().setSp(16), fontWeight: FontWeight.w700),
                                              textAlign: TextAlign.start,
                                          ),
                                      ),

                                      SizedBox(
                                          width: ScreenUtil().setWidth(8),
                                      ),

                                      Container(
                                          width: m.size.width,
                                          height: ScreenUtil().setHeight(420),
                                          child: PageView.builder(
                                                  controller: bPageCon,
                                                  physics: AlwaysScrollableScrollPhysics(),
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: snapshot.data.length,
                                                  itemBuilder: (context, pos) {

                                                      op.add(1);
                                                      StateSetter setLoad;
                                                      setLoading.add((fn) {
                                                          setLoad((){

                                                          });
                                                      });

                                                      return Padding(
                                                        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(8), 0, 0, ScreenUtil().setWidth(8)),
                                                        child: Card(
                                                            elevation: 3,
                                                            child: Container(
                                                              height: ScreenUtil().setHeight(420),
                                                              padding: EdgeInsets.fromLTRB(
                                                                  ScreenUtil().setWidth(11),
                                                                  ScreenUtil().setHeight(11),
                                                                  ScreenUtil().setWidth(11),
                                                                  ScreenUtil().setHeight(11),
                                                              ),
                                                              child: SingleChildScrollView(
                                                                child: Column(
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      children: <Widget>[

                                                                          Container(
                                                                              width: ScreenUtil().setWidth(360),
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text("Booking ID: ${snapshot.data[snapshot.data.length - pos - 1].bookingId}",
                                                                                  style: TextStyle(fontSize: ScreenUtil().setSp(12), fontWeight: FontWeight.w400),
                                                                                  textAlign: TextAlign.start,
                                                                              ),
                                                                          ),

                                                                          SizedBox(
                                                                              height: ScreenUtil().setHeight(10),
                                                                          ),

                                                                          Text(snapshot.data[snapshot.data.length - pos - 1].title,
                                                                              style: TextStyle(fontSize: ScreenUtil().setSp(18), fontWeight: FontWeight.w700),
                                                                          ),

                                                                          SizedBox(
                                                                              height: ScreenUtil().setHeight(20),
                                                                          ),

                                                                          Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[

                                                                                  Icon(Icons.calendar_today,
                                                                                      size: ScreenUtil().setWidth(30),
                                                                                  ),

                                                                                  SizedBox(
                                                                                      width: ScreenUtil().setWidth(20),
                                                                                  ),

                                                                                  Expanded(
                                                                                      child: Text("${snapshot.data[snapshot.data.length - pos - 1].date1}\n"
                                                                                              "                     to \n"
                                                                                              "${snapshot.data[snapshot.data.length - pos - 1].date2}",
                                                                                          style: TextStyle(fontWeight: FontWeight.w400,
                                                                                                  fontSize: ScreenUtil().setSp(14)
                                                                                          ),
                                                                                      ),
                                                                                  ),

                                                                              ],

                                                                          ),

                                                                          SizedBox(
                                                                              height: ScreenUtil().setHeight(20),
                                                                          ),

                                                                          Row(
                                                                              children: <Widget>[

                                                                                  Container(
                                                                                    width: ScreenUtil().setWidth(75),
                                                                                    alignment: Alignment.centerLeft,
                                                                                    child: Text("Venue:",
                                                                                        style: TextStyle(
                                                                                            fontSize: ScreenUtil().setSp(15),
                                                                                            fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                    ),
                                                                                  ),

                                                                                  Expanded(
                                                                                      child: Text((snapshot.data[snapshot.data.length - pos - 1].v1.length < 50)?
                                                                                      snapshot.data[snapshot.data.length - pos - 1].v1 :
                                                                                      "${snapshot.data[snapshot.data.length - pos - 1].v1.substring(0,50)}...",
                                                                                          style: TextStyle(fontSize: ScreenUtil().setSp(14),
                                                                                              fontWeight: FontWeight.w400,
                                                                                          ),
                                                                                          textAlign: TextAlign.start,
                                                                                      ),
                                                                                  ),
                                                                              ],
                                                                          ),

                                                                          SizedBox(
                                                                              height: ScreenUtil().setHeight(20),
                                                                          ),

                                                                          (snapshot.data[snapshot.data.length - pos - 1].v2.isNotEmpty)?
                                                                          Row(
                                                                              children: <Widget>[

                                                                                  Container(
                                                                                      child: Icon(
                                                                                          Icons.location_on,
                                                                                          size: ScreenUtil().setWidth(20),
                                                                                      ),
                                                                                      alignment: Alignment.center,
                                                                                      width: ScreenUtil().setWidth(60),
                                                                                  ),

                                                                                  Expanded(
                                                                                      child: GestureDetector(
                                                                                          child: Text(
                                                                                              (snapshot.data[snapshot.data.length - pos - 1].v2.length < 75)?
                                                                                              snapshot.data[snapshot.data.length - pos - 1].v2 :
                                                                                              "${snapshot.data[snapshot.data.length - pos - 1].v2.substring(0,75)}...",
                                                                                              style: TextStyle(fontSize: ScreenUtil().setSp(14),
                                                                                                  fontWeight: FontWeight.w300,
                                                                                                  decoration: TextDecoration.underline,
                                                                                              ),
                                                                                              textAlign: TextAlign.start,
                                                                                          ),
                                                                                          onTap: () {
                                                                                              MapsLauncher.launchQuery(
                                                                                                      snapshot.data[snapshot.data.length - pos - 1].v2
                                                                                              );
                                                                                          },
                                                                                      ),
                                                                                  ),
                                                                              ],
                                                                          ) : Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            children: [

                                                                              SizedBox(
                                                                                  width: ScreenUtil().setWidth(10),
                                                                              ),

                                                                              GestureDetector(
                                                                                  onTap: (){
                                                                                      MapsLauncher.launchQuery(snapshot.data[snapshot.data.length - pos - 1].v1);
                                                                                  },
                                                                                child: Container(
                                                                                  //width: ScreenUtil().setWidth(75),
                                                                                  //height: ScreenUtil().setHeight(25),
                                                                                  alignment: Alignment.center,
                                                                                  child: Text("Show in Maps",
                                                                                      style: TextStyle(
                                                                                          color: Colors.black,
                                                                                          fontSize: ScreenUtil().setSp(12),
                                                                                          fontWeight: FontWeight.w400,
                                                                                          decoration: TextDecoration.underline
                                                                                      ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),

                                                                          SizedBox(
                                                                              height: ScreenUtil().setHeight(20),
                                                                          ),

                                                                          GestureDetector(
                                                                              onTap: () {
                                                                                  _urlFunc("https://www.bookmytrainings.com/catalogue/event/"
                                                                                          "${snapshot.data[snapshot.data.length - pos - 1].id}");
                                                                              },
                                                                              child: Material(
                                                                                  elevation: 5,
                                                                                  borderRadius: BorderRadius.circular(5),
                                                                                  child: Container(
                                                                                      height: ScreenUtil().setHeight(35),
                                                                                      width: ScreenUtil().setWidth(125),
                                                                                      decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(5),
                                                                                          color: Colors.lightBlueAccent,
                                                                                      ),
                                                                                      child: Center(
                                                                                          child: Text("More Details",
                                                                                              style: TextStyle(color: Colors.black,
                                                                                                  fontSize: ScreenUtil().setSp(12),
                                                                                                  fontWeight: FontWeight.w400,
                                                                                              ),
                                                                                          ),
                                                                                      ),
                                                                                  ),
                                                                              ),
                                                                          ),

                                                                          /*Container(
                                                                            height: ScreenUtil().setHeight(300),
                                                                            decoration: BoxDecoration(
                                                                                border: Border.all(),
                                                                            ),
                                                                            child: Stack(
                                                                              children: [

                                                                                StatefulBuilder(
                                                                                  builder: (context, setLoad) {
                                                                                    return Center(
                                                                                        child: Opacity(
                                                                                          opacity: op[pos],
                                                                                          child: Container(
                                                                                              height: 20,
                                                                                              width: 20,
                                                                                              child: CircularProgressIndicator(),
                                                                                          ),
                                                                                        ),
                                                                                    );
                                                                                  }
                                                                                ),

                                                                                WebView(
                                                                                    initialUrl: "https://www.bookmytrainings.com/catalogue/event/"
                                                                                            "${snapshot.data[snapshot.data.length - pos - 1].id}",
                                                                                    javascriptMode: JavascriptMode.unrestricted,
                                                                                    onWebViewCreated: (WebViewController webViewController) {
                                                                                        _controller = webViewController;
                                                                                    },
                                                                                    onPageStarted: (url) {
                                                                                        *//*setLoading[pos]((){
                                                                                            op[pos] = 1;
                                                                                        });*//*
                                                                                    },
                                                                                    onPageFinished: (url) async {
                                                                                        *//*setLoading[pos]((){
                                                                                            op[pos] = 0;
                                                                                        });*//*
                                                                                        await _controller.evaluateJavascript('alert("Hello World")');
                                                                                    },
                                                                                    gestureRecognizers: Set()
                                                                                        ..add(
                                                                                            Factory<VerticalDragGestureRecognizer>(
                                                                                                        () => VerticalDragGestureRecognizer(),
                                                                                            ), // or null
                                                                                        ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),*/

                                                                      ],
                                                                  ),
                                                              ),
                                                            ),
                                                        ),
                                                      );
                                                  }
                                          ),
                                      )

                                  ]
                          ),
                      );
                  }
              },
          ),
        );
    }

    _urlFunc(String url) async{
        if(await canLaunch("$url")){
            await launch("$url");
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