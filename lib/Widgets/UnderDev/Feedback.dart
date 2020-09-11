import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class HelpAndFeedback extends StatefulWidget {

  final changePage;

  @override
  _HelpAndFeedbackState createState() => _HelpAndFeedbackState();

  HelpAndFeedback(this.changePage);
}

class _HelpAndFeedbackState extends State<HelpAndFeedback> with AutomaticKeepAliveClientMixin<HelpAndFeedback> {

  TextEditingController numTextCon = new TextEditingController();
  TextEditingController feedTextCon = new TextEditingController();

  @override
  Widget build(BuildContext context) {

  ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);

  return Container(
      height: ScreenUtil().setHeight(425),
      width: ScreenUtil().setWidth(360),
    padding: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(16),
            ScreenUtil().setHeight(16),
            ScreenUtil().setWidth(16),
            ScreenUtil().setHeight(16)
    ),      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Container(
              padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(16),
                      ScreenUtil().setWidth(16),
                      ScreenUtil().setHeight(6)
              ),
              width: ScreenUtil().setWidth(360),
              child: Text("CHAT",
                style: TextStyle(fontSize: ScreenUtil()
                        .setSp(16), fontWeight: FontWeight
                        .w700),
                textAlign: TextAlign.start,
              ),
            ),

            Text("Phone No",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.start,
            ),

            Container(
              padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(10),
                      ScreenUtil().setWidth(0),
                      ScreenUtil().setHeight(10)
              ),              child: Material(
                elevation: 2,
                child: TextField(
                  controller: numTextCon,
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(border: OutlineInputBorder(
                  ),
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Enter your Phone No",
                    prefixIcon: Padding(
                      padding: EdgeInsets.fromLTRB(
                              ScreenUtil().setWidth(10),
                              ScreenUtil().setHeight(15.25),
                              ScreenUtil().setWidth(10),
                              ScreenUtil().setHeight(10)
                      ),
                      child: Opacity(
                        opacity: 0.5,
                        child: Text("+91",
                          style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Container(
              width: ScreenUtil().setWidth(360),
              height: ScreenUtil().setHeight(100),
              decoration: BoxDecoration(border: Border.all(color: Colors.black.withOpacity(0.2))),
              padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(10),
                      ScreenUtil().setHeight(0),
                      ScreenUtil().setWidth(4),
                      ScreenUtil().setHeight(0)
              ),
              child: new TextField(
                expands: true,
                /*minLines: 5,
                maxLength: 500,
                maxLengthEnforced: true,*/
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
                controller: feedTextCon,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  /*enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black
                            .withOpacity(0.2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black
                            .withOpacity(0.2)),
                  ),
                  contentPadding: EdgeInsets.only(
                          top: 2.0,
                          left: 13.0,
                          right: 13.0,
                          bottom: 2.0),*/
                  hintText: "Send your comments/queries",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: ScreenUtil().setHeight(50),
            ),

            Container(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                color: Colors.black,
                child: Text("Send", style: TextStyle(color: Colors.white),),
                onPressed: (){},
              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
