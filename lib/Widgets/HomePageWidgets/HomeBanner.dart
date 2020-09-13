import 'package:Bookmytrainings/Utility/Banner_Model.dart';
import 'package:Bookmytrainings/Utility/pHp.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBanner extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeBannerState();
  }

}

class _HomeBannerState extends State<HomeBanner> with SingleTickerProviderStateMixin {

  Php dbConn = new Php();
  bool anim = false;

  @override
  Widget build(BuildContext context) {

      ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);

      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Banners").orderBy("id").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

            if(snapshot.data == null || snapshot.hasError || snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    width: ScreenUtil().setWidth(360),
                    height: ScreenUtil().setHeight(96),
                    child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, pos) {
                            return Padding(
                                padding: EdgeInsets.fromLTRB(
                                        ScreenUtil().setWidth(4),
                                        ScreenUtil().setHeight(0),
                                        ScreenUtil().setWidth(4),
                                        ScreenUtil().setHeight(0)
                                ),
                                child: Container(
                                    decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment
                                            .topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                                Color(0xffFF8900),
                                                Color(0xffFABB00)
                                            ]),
                                        borderRadius: BorderRadius.circular(7),
                                        color: Colors.grey.shade200.withOpacity(0.5)
                                    ),
                                    width: ScreenUtil().setWidth(312),
                                    height: ScreenUtil().setHeight(96),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[

                                            Icon(
                                                Icons.signal_wifi_off,
                                                color: Colors.white,
                                                size: 30,
                                            ),

                                            Text("Oops, could not load banners",
                                                style: TextStyle(color: Colors.white,
                                                    fontSize: ScreenUtil().setSp(16),
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            );
                        },
                    ),
                );
            } else {

                List bannerModels = new List();

                for(int i=0;i<snapshot.data.docs.length;i++)
                    bannerModels.add(BannerModel.fromFirestore(snapshot.data.docs[i]));

                return Container(
                    width: ScreenUtil().setWidth(360),
                    height: ScreenUtil().setHeight(96),
                    child: CarouselSlider(
                        options: CarouselOptions(
                            enableInfiniteScroll: false,
                            viewportFraction: 0.9,
                            autoPlay: true,
                            autoPlayAnimationDuration: Duration(milliseconds: 1000),
                            autoPlayInterval: Duration(seconds: 4),
                            scrollPhysics: BouncingScrollPhysics(),
                        ),
                        items: bannerModels.map((ss) {
                            return Builder(
                                builder: (BuildContext context) {
                                    return Padding(
                                        padding: EdgeInsets.fromLTRB(
                                                ScreenUtil().setWidth(4),
                                                ScreenUtil().setHeight(0),
                                                ScreenUtil().setWidth(4),
                                                ScreenUtil().setHeight(0)
                                        ),
                                        child: Stack(
                                            children: [

                                                GestureDetector(
                                                  onTap: (){
                                                      _urlFunc(ss.link);
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment
                                                              .topLeft,
                                                              end: Alignment.bottomRight,
                                                              colors: [
                                                                  ss.color1,
                                                                  ss.color2
                                                              ]),
                                                          borderRadius: BorderRadius.circular(7),
                                                      ),
                                                      width: ScreenUtil().setWidth(312),
                                                      height: ScreenUtil().setHeight(96),
                                                      child: Row(
                                                        children: [

                                                          SizedBox(
                                                              width: ScreenUtil().setWidth(8),
                                                          ),

                                                          Column(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: <Widget>[

                                                                  /*Text(sstitle,
                                                                      style: TextStyle(color: Colors.white,
                                                                          fontSize: ScreenUtil().setSp(16),
                                                                      ),
                                                                      overflow: TextOverflow.ellipsis,
                                                                  ),*/
                                                                  Container(
                                                                      //color: Colors.grey,
                                                                      child: RichText(
                                                                          overflow: TextOverflow.fade,
                                                                          maxLines: 1,
                                                                          text: TextSpan(
                                                                                  style: TextStyle(color: Colors.white,
                                                                                          fontSize: ScreenUtil().setSp(16),
                                                                                          fontWeight: FontWeight.w600
                                                                                  ),
                                                                                  text: ss.title
                                                                          ),
                                                                          softWrap: false,
                                                                      ),
                                                                      width: ScreenUtil().setWidth(300),
                                                                      height: ScreenUtil().setHeight(22),
                                                                  ),

                                                                  /*Text(ssdescription,
                                                                      style: TextStyle(color: Colors.white,
                                                                          fontSize: ScreenUtil().setSp(12),
                                                                      ),
                                                                      overflow: TextOverflow.ellipsis,
                                                                  ),*/

                                                                  Container(
                                                                      child: RichText(
                                                                          overflow: TextOverflow.fade,
                                                                          maxLines: 2,
                                                                          text: TextSpan(
                                                                                  style: TextStyle(color: Colors.white,
                                                                                          fontSize: ScreenUtil().setSp(12),
                                                                                          fontWeight: FontWeight.w500
                                                                                  ),
                                                                                  text: ss.description
                                                                          ),
                                                                          softWrap: false,
                                                                      ),
                                                                      width: ScreenUtil().setWidth(300),
                                                                      height: ScreenUtil().setHeight(17),
                                                                  ),

                                                                  Row(
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      children: <Widget>[

                                                                          Container(
                                                                              child: RichText(
                                                                                  overflow: TextOverflow.fade,
                                                                                  maxLines: 2,
                                                                                  text: TextSpan(
                                                                                          style: TextStyle(color: Colors.white,
                                                                                              fontSize: ScreenUtil().setSp(10),
                                                                                          ),
                                                                                          text: ss.comments
                                                                                  ),
                                                                                  softWrap: false,
                                                                              ),
                                                                              width: ScreenUtil().setWidth(95),
                                                                              height: ScreenUtil().setHeight(24),
                                                                          ),

                                                                          SizedBox(
                                                                              width: ScreenUtil().setWidth(13),
                                                                          ),

                                                                          Container(
                                                                              child: RichText(
                                                                                  overflow: TextOverflow.fade,
                                                                                  maxLines: 2,
                                                                                  text: TextSpan(
                                                                                      style: TextStyle(color: Colors.white,
                                                                                          fontSize: ScreenUtil().setSp(10),
                                                                                      ),
                                                                                      text: ss.date + ' \(' +
                                                                                              ss.city + '\)',
                                                                                  ),
                                                                                  softWrap: false,
                                                                              ),
                                                                              width: ScreenUtil().setWidth(188),
                                                                              height: ScreenUtil().setHeight(24),
                                                                          ),

                                                                      ],
                                                                  )
                                                              ],
                                                          ),

                                                          SizedBox(
                                                              width: ScreenUtil().setWidth(4),
                                                          ),

                                                        ],
                                                      ),
                                                  ),
                                                ),

                                                Positioned(
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.only(
                                                                        bottomRight: Radius.circular(7),
                                                                        topLeft: Radius.circular(7)
                                                                ),
                                                                color: Colors.grey.withOpacity(0.9)
                                                        ),
                                                        padding: EdgeInsets.fromLTRB(
                                                                ScreenUtil().setWidth(4),
                                                                ScreenUtil().setHeight(2),
                                                                ScreenUtil().setWidth(3),
                                                                ScreenUtil().setHeight(1)
                                                        ),
                                                        child: Text("Know more",
                                                            style: TextStyle(
                                                                    fontSize: ScreenUtil().setSp(11),
                                                                    color: Colors.white
                                                            ),
                                                        ),
                                                    ),
                                                    bottom: 0,
                                                    right: 0,
                                                ),

                                            ],
                                        ),
                                    );
                                },
                            );
                        }).toList(),
                    ),
                );
            }
        }
      );

  }

  _urlFunc(String url) async{
      if(await canLaunch(url)){
          await launch(url);
      } else {
          Fluttertoast.showToast(msg: "Could not perform action: launch url",
              textColor: Colors.black,
              fontSize: ScreenUtil().setSp(20),
              toastLength: Toast.LENGTH_LONG,
          );
      }

  }

}