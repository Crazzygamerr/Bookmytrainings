import 'package:Bookmytrainings/Utility/pHp.dart';
import 'package:Bookmytrainings/Utility/Payment_Model.dart';
import 'package:Bookmytrainings/Utility/sharedPref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class Payments extends StatefulWidget {

    @override
    State<StatefulWidget> createState() {
        return _PaymentsState();
    }

}

class _PaymentsState extends State<Payments> with AutomaticKeepAliveClientMixin<Payments> {

    String email;

    PageController pPageCon = new PageController(initialPage: 0);

    List<PaymentModel> payments;

    Future<List<PaymentModel>> setP() async {
        SharedPref pref = new SharedPref();
        email = await pref.getEmail();
        Php dbConn = new Php();
        return dbConn.getPayments(email);
    }

    /*Future<List<PaymentModel>> getP() async {
        if(_noPayKey.currentState.mounted)
            _noPayKey.currentState.show();
        else if(_paidKey.currentState.mounted)
            _paidKey.currentState.show();
        return compute(getP());
    }*/

    /*key: _noPayKey,
                        onRefresh: () async {
                            setP();
                            var abc = await Future.delayed(Duration(seconds: 3)).then((value) => (){
                                return null;
                            });
                        },*/

    @override
    Widget build(BuildContext context) {
        super.build(context);

        ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);
        MediaQueryData m = MediaQuery.of(context);

        return Container(
          height: ScreenUtil().setHeight(480),
          child: FutureBuilder<List<PaymentModel>>(
              future: setP(),
              builder: (BuildContext context, AsyncSnapshot<List<PaymentModel>> snapshot){

                  if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                          child: Container(
                                  width: ScreenUtil().setWidth(20),
                                  height:ScreenUtil().setWidth(20),
                                  child: CircularProgressIndicator()
                          ),
                      );

                  } else if(!snapshot.hasData || snapshot.hasError){

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
                                            ScreenUtil().setHeight(16),
                                        ),
                                        width: m.size.width,
                                        child: Text("PAYMENTS",
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
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[

                                                Image.asset("Assets/Creditcard/drawable-xhdpi/creditcard.png",
                                                    height: ScreenUtil().setHeight(113),
                                                    width: ScreenUtil().setWidth(120),
                                                ),

                                                SizedBox(
                                                    height: ScreenUtil().setHeight(10),
                                                ),

                                                Text("Payment information\n Is not Available",
                                                    style: TextStyle(fontSize: ScreenUtil()
                                                            .setSp(24), fontWeight: FontWeight
                                                            .w500),
                                                    textAlign: TextAlign.center,
                                                ),

                                                SizedBox(
                                                    height: ScreenUtil().setHeight(16),
                                                ),

                                                Text("Make payments \nfrom bookmytrainings.com",
                                                    style: TextStyle(fontSize: ScreenUtil()
                                                            .setSp(16), fontWeight: FontWeight
                                                            .w300),
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
                                          width: m.size.width,
                                          child: Text("PAYMENTS \(${snapshot.data.length}\)",
                                              style: TextStyle(fontSize: ScreenUtil()
                                                      .setSp(16), fontWeight: FontWeight
                                                      .w700),
                                              textAlign: TextAlign.start,
                                          ),
                                      ),

                                      Container(
                                          width: m.size.width,
                                          height: ScreenUtil().setHeight(410),
                                          child: ListView.builder(
                                                  controller: pPageCon,
                                                  padding: EdgeInsets.all(0),
                                                  physics: AlwaysScrollableScrollPhysics(),
                                                  scrollDirection: Axis.vertical,
                                                  itemCount: snapshot.data.length,
                                                  itemBuilder: (context, pos){
                                                      return Column(
                                                        children: [

                                                          Card(
                                                            elevation: 3,
                                                            child: Container(
                                                                //height: ScreenUtil().setHeight(75),
                                                                width: ScreenUtil().setWidth(328),
                                                                padding: EdgeInsets.fromLTRB(
                                                                    ScreenUtil().setWidth(10),
                                                                    ScreenUtil().setHeight(10),
                                                                    ScreenUtil().setWidth(10),
                                                                    ScreenUtil().setHeight(10),
                                                                ),
                                                                child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: <Widget>[

                                                                        Container(
                                                                          child: Text("Order ID: ${snapshot.data[snapshot.data.length - pos - 1].orderId}",
                                                                              style: TextStyle(
                                                                                  fontSize: ScreenUtil().setSp(12),
                                                                                  fontWeight: FontWeight.w400,
                                                                                  color: Colors.black,
                                                                              ),
                                                                              overflow: TextOverflow.ellipsis,
                                                                              textAlign: TextAlign.start,
                                                                          ),
                                                                          width: ScreenUtil().setWidth(308),
                                                                            alignment: Alignment.centerLeft,
                                                                        ),

                                                                        Padding(
                                                                            padding: EdgeInsets.fromLTRB(
                                                                                    ScreenUtil().setWidth(0),
                                                                                    ScreenUtil().setHeight(5),
                                                                                    ScreenUtil().setWidth(0),
                                                                                    ScreenUtil().setHeight(5)
                                                                            ),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: <Widget>[

                                                                                  Text(
                                                                                      (snapshot.data[snapshot.data.length - pos - 1].status == "Success") ?
                                                                                                  "Payment Successful" : "Payment Failed",
                                                                                      style: TextStyle(
                                                                                          fontSize: ScreenUtil().setSp(12),
                                                                                          fontWeight: FontWeight.w400,
                                                                                          color: (snapshot
                                                                                                  .data[snapshot.data.length - pos - 1].status == "Success") ?
                                                                                          Colors.green : Colors.red,
                                                                                      ),
                                                                                      textAlign: TextAlign.start,
                                                                                  ),

                                                                                  Text(snapshot.data[snapshot.data.length - pos - 1].date,
                                                                                      style: TextStyle(
                                                                                              fontSize: ScreenUtil().setSp(11)),
                                                                                  ),

                                                                              ],
                                                                          ),
                                                                        ),

                                                                        Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [

                                                                                Container(
                                                                                  child: Text(
                                                                                      (snapshot.data[snapshot.data.length - pos - 1].title != null) ?
                                                                                      snapshot.data[snapshot.data.length - pos - 1].title
                                                                                       : "Generic Payment",
                                                                                      style: TextStyle(
                                                                                              fontSize: ScreenUtil().setSp(15),
                                                                                              fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                  width: ScreenUtil().setWidth(180),
                                                                                ),

                                                                                Container(
                                                                                  child: Text("${snapshot.data[snapshot.data.length - pos - 1].amount} "
                                                                                          "${snapshot.data[snapshot.data.length - pos - 1].currency}",
                                                                                      style: TextStyle(
                                                                                              fontSize: ScreenUtil().setSp(14),
                                                                                              fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                      textAlign: TextAlign.end,
                                                                                  ),
                                                                                  width: ScreenUtil().setWidth(110),
                                                                                ),
                                                                            ],
                                                                        ),



                                                                    ],
                                                                ),
                                                            ),
                                                          ),

                                                          /*Padding(
                                                            padding: EdgeInsets.all(5),
                                                            child: Container(
                                                                width: ScreenUtil().setWidth(360),
                                                                height: ScreenUtil().setHeight(1),
                                                                color: Colors.black.withOpacity(0.4),
                                                            ),
                                                          ),*/

                                                        ],
                                                      );
                                                  }
                                          ),
                                      ),

                                      SizedBox(
                                          width: ScreenUtil().setWidth(5),
                                      ),

                                  ]
                          ),
                      );
                  }
              },
          ),
        );

    }

    _urlFunc(String url) async{
        try {
            await launch("$url");
        } catch(e) {
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