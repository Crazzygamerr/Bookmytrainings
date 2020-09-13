import 'dart:convert';
import 'dart:typed_data';

import 'package:Bookmytrainings/Utility/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

// ignore: must_be_immutable
class ProfileImage extends StatefulWidget {

   final _ProfileImageState pState = _ProfileImageState();
   final PageController pageCon;
   Uint8List u;

   void setSt(String u){
       pState.setStr(u);
   }

  ProfileImage(this.pageCon, this.u);

  State<StatefulWidget> createState() => pState;

}

class _ProfileImageState extends State<ProfileImage> {

  void setSt(){
      setState(() {
          SharedPref.getImgFromPref().then((uL){
              String t;
              if(widget.u != null)
                  t = base64Encode(widget.u);
              if(uL != null && uL != t)
                  widget.u = base64Decode(uL);
          });

          if(widget.pageCon.page == 0){
              s = s1;
          } else if(widget.pageCon.page == 1){
              s = s1;
          } else if(widget.pageCon.page == 2){
              s = s2;
          } else if(widget.pageCon.page == 3){
              s = s2;
          }
      });
  }

  void setStr(String uL){
      setState(() {
          if(uL != null)
              widget.u = base64Decode(uL);
      });
  }

  String s = "Assets/User.png";
  String s1 = "Assets/User.png";
  String s2 = "Assets/ThumbsUp/drawable-xhdpi/ThumbsUp.png";

  @override
  void dispose() {
    super.dispose();
    widget.pageCon.removeListener(setSt);
  }

  @override
  void initState() {
    super.initState();
    widget.pageCon.addListener(setSt);
    setSt();
  }

  @override
  Widget build(BuildContext context) {

      ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);

      return Container(
        decoration: BoxDecoration(color: Colors
                .white, shape: BoxShape.circle,
                boxShadow: [
                    //color: Colors.white
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                    )
                ]
        ),
        child: (s == "Assets/User.png") ? CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: (widget.u == null) ? AssetImage(s) : MemoryImage(widget.u),
            radius: ScreenUtil().setWidth(44),
        ) : CircleAvatar(
            backgroundColor: Colors.white,
            child: Image.asset(
                s,
                height: ScreenUtil().setWidth(40),
                width: ScreenUtil().setWidth(40),
            ),
            radius: ScreenUtil().setWidth(44),
        ),
    );
  }

}
