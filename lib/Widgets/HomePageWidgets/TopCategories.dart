import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Bookmytrainings/Utility/TC_programs.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class TopCategories extends StatefulWidget {
  @override
  _TopCategoriesState createState() => _TopCategoriesState();
}

class _TopCategoriesState extends State<TopCategories> {

  TC_Programs prog = new TC_Programs();

  @override
  Widget build(BuildContext context) {

      ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);

      return Container(
        height: ScreenUtil().setHeight(340),
        width: ScreenUtil().setWidth(360),
          padding: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(8),
              ScreenUtil().setHeight(4),
              ScreenUtil().setWidth(8),
              ScreenUtil().setHeight(8),
          ),
        //color: Colors.blue,
        child: ListView.builder(
            itemCount: prog.programs.length,
            //physics: ClampingScrollPhysics(),
            padding: EdgeInsets.all(0),
            itemBuilder: (context, pos) {
                return Container(
                  height: ScreenUtil().setWidth(125),
                  width: ScreenUtil().setWidth(360),
                  child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: prog.programs[pos]['pName'].length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, pos1){
                          List temp = prog.programs[pos]['pName'];
                          return GestureDetector(
                            onTap: (){
                                if(temp[pos1]['link'] != "")
                                    _urlFunc("", temp[pos1]['link']);
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(
                                      (pos1 == 0) ? 0 : ScreenUtil().setWidth(5),
                                      (pos1 == 0) ? 0 : ScreenUtil().setHeight(7.5),
                                      0,
                                      (pos1 == 0) ? 0 : ScreenUtil().setHeight(7.5),
                              ),
                              width: (pos1 == 0) ? ScreenUtil().setWidth(125) : ScreenUtil().setWidth(115),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  elevation: 2.5,
                                  //color: (pos1 == 0) ? prog.Programs[pos]['color'] : prog.Programs[pos]['color1'],
                                  color: (pos1 == 0) ? prog.programs[pos]['color'] : Colors.white,
                                  child: Container(
                                      width: ScreenUtil().setWidth(125),
                                      //height: ScreenUtil().setWidth(75),
                                      decoration: BoxDecoration(
                                          border: (pos1 == 0) ? Border(
                                              top: BorderSide(color: Colors.grey.withOpacity(0.5)),
                                              bottom: BorderSide(color: Colors.grey.withOpacity(0.5)),
                                              left: BorderSide(color: Colors.grey.withOpacity(0.5)),
                                              right: BorderSide(color: Colors.grey.withOpacity(0.5)),
                                          ) : Border(
                                              top: BorderSide(color: prog.programs[pos]['color']),
                                              bottom: BorderSide(color: prog.programs[pos]['color']),
                                              left: BorderSide(color: prog.programs[pos]['color']),
                                              right: BorderSide(color: prog.programs[pos]['color']),
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                      ),
                                      padding: EdgeInsets.fromLTRB(
                                          ScreenUtil().setWidth(3),
                                          ScreenUtil().setHeight(3),
                                          ScreenUtil().setWidth(3),
                                          ScreenUtil().setHeight(3),
                                      ),
                                      child: Center(
                                        child: Text(
                                          temp[pos1]['name'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: (pos1 == 0) ? ScreenUtil().setSp(12) : ScreenUtil().setSp(10),
                                              //fontWeight: FontWeight.w500,
                                              color: (pos%2 != 0 && pos1 == 0) ? Colors.white : Colors.black,
                                          ),
                                          softWrap: true,
                                        ),
                                      ),
                                  ),
                              ),
                            ),
                          );
                      }
                  ),
                );
            },
        ),
      );
  }

  _urlFunc(String url, String s) async{
      try{
          await launch("$s$url");
      } catch(e) {
          Fluttertoast.showToast(msg: "Could not perform action",
              textColor: Colors.black,
              fontSize: ScreenUtil().setSp(20),
              toastLength: Toast.LENGTH_LONG,
          );
      }

  }

}
