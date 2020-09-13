import 'package:Bookmytrainings/Utility/pHp.dart';
import 'package:Bookmytrainings/Utility/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Bookmytrainings/Utility/Booking_Model.dart';

class HomeBookings extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
        return _HomeBookingsState();
    }
  }


class _HomeBookingsState extends State<HomeBookings>{

  String email;

  //final _noBookKey = GlobalKey<RefreshIndicatorState>();
  // final _bookedKey = GlobalKey<RefreshIndicatorState>();

  Future<List<BookingModel>> setB() async {
      SharedPref pref = new SharedPref();
      email = await pref.getEmail();
      Php dbConn = new Php();
      return dbConn.getBookings(email);
  }

  @override
  Widget build(BuildContext context) {

      MediaQueryData m = MediaQuery.of(context);
      ScreenUtil.init(context, height: 640, width: 360, allowFontScaling: true);
      PageController pageCon1 = PageController(initialPage: 0);

      return Container(
          width: m.size.width,
          height: ScreenUtil().setHeight(210),
          child: PageView.builder(
                  controller: pageCon1,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,

                  itemBuilder: (context, pos){
                      return Padding(
                          padding: EdgeInsets.fromLTRB(
                                  ScreenUtil().setWidth(8),
                                  ScreenUtil().setHeight(8),
                                  ScreenUtil().setWidth(8),
                                  ScreenUtil().setHeight(8)
                          ),
                          child: Card(
                              elevation:3,
                              child: Container(
                                  height: ScreenUtil().setHeight(190),
                                  width: ScreenUtil().setWidth(328),
                                  /*decoration: BoxDecoration(color: Colors.lightBlueAccent,
                                                        borderRadius: BorderRadius.circular(7),
                                                    ),*/
                                  padding: EdgeInsets.fromLTRB(
                                          ScreenUtil().setWidth(12),
                                          ScreenUtil().setHeight(12),
                                          ScreenUtil().setWidth(12),
                                          ScreenUtil().setHeight(12)
                                  ),
                                  child: Column(
                                      children: <Widget>[
                                          Container(
                                              width: ScreenUtil()
                                                      .setWidth(390),
                                              alignment: Alignment
                                                      .centerLeft,
                                              child: Text("Booking ID: "
                                                      /*"${snapshot
                                                      .data[snapshot
                                                      .data
                                                      .length - pos - 1]
                                                      .booking_id}"*/
                                                      "",
                                                  style: TextStyle(fontSize: ScreenUtil()
                                                          .setSp(12), fontWeight: FontWeight
                                                          .w400),
                                                  textAlign: TextAlign
                                                          .start,
                                              ),
                                          ),

                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                      ScreenUtil().setWidth(0),
                                                      ScreenUtil().setHeight(5),
                                                      ScreenUtil().setWidth(5),
                                                      ScreenUtil().setHeight(5)
                                              ),
                                              child: Text(
                                                      /*snapshot
                                                      .data[snapshot
                                                      .data
                                                      .length - pos - 1]
                                                      .title*/
                                                      "",
                                                  style: TextStyle(fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w700),
                                              ),
                                          ),

                                          Row(
                                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                  Icon(Icons.calendar_today),

                                                  Expanded(
                                                      child: Container(
                                                          padding: EdgeInsets.fromLTRB(
                                                                  ScreenUtil().setWidth(7),
                                                                  ScreenUtil().setHeight(7),
                                                                  ScreenUtil().setWidth(7),
                                                                  ScreenUtil().setHeight(7)
                                                          ),
                                                          child: Text(
                                                              /*"${snapshot
                                                                      .data[snapshot
                                                                      .data
                                                                      .length - pos - 1]
                                                                      .date1}\n                to \n"
                                                                      "${snapshot
                                                                      .data[snapshot
                                                                      .data
                                                                      .length - pos - 1]
                                                                      .date2}"*/
                                                                "",
                                                              style: TextStyle(fontWeight: FontWeight.w500,
                                                                      fontSize: ScreenUtil().setSp(11)
                                                              ),
                                                          ),
                                                      ),
                                                  ),

                                                  /*Container(color: Colors.grey, height: ScreenUtil().setHeight(45), width: 1,),

                                                  Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text("90 \nMinutes",
                                                          style: TextStyle(fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.w400),
                                                          textAlign: TextAlign.center,
                                                      ),
                                                  ),*/

                                              ],

                                          ),

                                          Row(
                                              children: <Widget>[

                                                  Icon(Icons.location_on),

                                                  Expanded(
                                                      child: GestureDetector(
                                                          child: Text(
                                                              /*(snapshot.data[snapshot.data.length - pos - 1].v1.length < 50)?
                                                              snapshot.data[snapshot.data.length - pos - 1].v1 :
                                                              "${snapshot.data[snapshot.data.length - pos - 1].v1.substring(0,50)}..."*/
                                                              "",
                                                              style: TextStyle(fontSize: ScreenUtil().setSp(12),
                                                                  fontWeight: FontWeight.w300,
                                                                  decoration: TextDecoration.underline,
                                                              ),
                                                              textAlign: TextAlign.start,
                                                          ),
                                                          onTap: (){
                                                              //MapsLauncher.launchQuery(snapshot.data[snapshot.data.length - pos - 1].v2);  //launch maps link
                                                          },
                                                      ),
                                                  ),
                                              ],
                                          ),

                                      ],
                                  ),
                              ),
                          ),
                      );
                  }
          ),
      );

  }

}