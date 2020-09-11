import 'package:Bookmytrainings/Utility/pHp.dart';
import 'package:Bookmytrainings/Utility/sharedPref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class EditProfile extends StatefulWidget {

  final changePage;
  final name,email;
  final id;

  @override
  _EditProfileState createState() => _EditProfileState();

  EditProfile(this.changePage, this.id, this.name, this.email);
}

class _EditProfileState extends State<EditProfile> with AutomaticKeepAliveClientMixin<EditProfile> {

  final _nameTextKey = GlobalKey<FormFieldState>();
  final _emailTextKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {

    TextEditingController nameTextCon = new TextEditingController(text: "${widget.name}");
    TextEditingController emailTextCon = new TextEditingController(text: "${widget.email}");

    return Container(
      height: ScreenUtil().setHeight(425),
      width: ScreenUtil().setWidth(360),
      padding: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(16),
              ScreenUtil().setHeight(16),
              ScreenUtil().setWidth(16),
              ScreenUtil().setHeight(16)
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Text("Name",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.start,
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Material(
                elevation: 2,
                child: TextFormField(
                  key: _nameTextKey,
                  controller: nameTextCon,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  validator: (value){
                      return "This field cannot be empty";
                  },
                ),
              ),
            ),

            Text("Email ID",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.start,
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Material(
                elevation: 2,
                child: TextFormField(
                  key: _emailTextKey,
                  controller: emailTextCon,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  validator: (value){
                    return "This field cannot be empty";
                  },
                ),
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
