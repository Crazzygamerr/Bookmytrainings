import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:Bookmytrainings/Utility/sharedPref.dart';

class AddProfileImage extends StatefulWidget {

  final PageController pageCon;
  final Function func;
  final Function setStr;

  @override
  _AddProfileImageState createState() => _AddProfileImageState();

  AddProfileImage(this.setStr, this.func, this.pageCon);
}

class _AddProfileImageState extends State<AddProfileImage> {

  double op = 0;
  String s = "Assets/User.png";
  String s1 = "Assets/User.png";
  String s2 = "Assets/ThumbsUp/drawable-xhdpi/ThumbsUp.png";

  void dispose() {
    super.dispose();
    widget.pageCon.removeListener(setOp);
  }

  @override
  void initState() {
    super.initState();
    widget.pageCon.addListener(setOp);
  }

  void setOp(){
    setState(() {
      if(widget.pageCon.page == 0){
        op = 0;
      } else if(widget.pageCon.page == 1){
        op = 1;
      } else if(widget.pageCon.page == 2){
        op = 0;
      } else if(widget.pageCon.page == 3){
        op = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);
    return Opacity(
      opacity: op,
      child: Container(
        padding: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(2),
                ScreenUtil().setHeight(2),
                ScreenUtil().setWidth(2),
                ScreenUtil().setHeight(2)
        ),
        decoration: BoxDecoration(shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle,
            color: Colors.white,
          ),
          width: ScreenUtil().setWidth(30),
          height: ScreenUtil().setWidth(30),
          child: IconButton(
            icon: Icon(Icons.camera_alt,
              size: 15,
              color: Colors.blue,
            ),
            onPressed: (){
              if(widget.pageCon.page == 1)
              _imagePick(widget.setStr, widget.func);
            },
          ),
        ),
      ),
    );
  }

  SharedPreferences prefs;
  String imgPath;

  _imagePick(Function setStr, Function func) async{

    String sp;
    final File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    //SharedPref.saveImgToPref(SharedPref.stringFromImg(image.readAsBytesSync()));

    sp = SharedPref.stringFromImg(image.readAsBytesSync());

    setStr(sp);
    func(sp);
  }

}
