import 'dart:typed_data';
import 'package:Bookmytrainings/Utility/FutureProvider.dart';
import 'package:Bookmytrainings/Utility/sharedPref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:intl/intl.dart';

class Chat extends StatefulWidget {

    @override
    State<StatefulWidget> createState() {
        return _ChatState();
    }

}

class _ChatState extends State<Chat> with AutomaticKeepAliveClientMixin<Chat> {

    Uint8List u;
    String email;
    Stream messages;

    @override
    void initState() {
        getMessages().then((value){
            setState(() {
                messages = value;
            });
        });
        super.initState();
    }

    getMessages() async {
        SharedPref pref = new SharedPref();
        email = await pref.getEmail();
        return FirebaseFirestore.instance.collection("chat-server").doc(email).collection("messages").orderBy("time", descending: true).snapshots();
    }

    TextEditingController textCon = new TextEditingController();
    ScrollController msgCon = new ScrollController();


    @override
    Widget build(BuildContext context) {

    super.build(context);
    ScreenUtil.init(context, width: 360, height: 640, allowFontScaling: true);
    MediaQueryData m = MediaQuery.of(context);
    var bottom = MediaQuery.of(context).viewInsets.bottom;

        return Container(
          padding: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(16),
                  ScreenUtil().setHeight(10),
                  ScreenUtil().setWidth(16),
                  ScreenUtil().setHeight(16),
          ),
          width: m.size.width,
          height: ScreenUtil().setHeight(470),
          child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                    ScreenUtil().setWidth(1),
                                    ScreenUtil().setHeight(0),
                                    ScreenUtil().setWidth(16),
                                    ScreenUtil().setHeight(6)
                            ),
                            width: m.size.width,
                            child: Text("CHAT",
                                style: TextStyle(fontSize: ScreenUtil()
                                        .setSp(16), fontWeight: FontWeight
                                        .w700),
                                textAlign: TextAlign.start,
                            ),
                        ),

                        StreamBuilder<QuerySnapshot>(
                          stream: messages,
                          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

                            if(!snapshot.hasData || snapshot.hasError || snapshot.connectionState == ConnectionState.waiting){
                                return Expanded(
                                        child: Center(
                                          child: Container(
                                            width: ScreenUtil().setWidth(20),
                                            height: ScreenUtil().setWidth(20),
                                            child: CircularProgressIndicator()
                                          ),
                                        )
                                );
                            } else {

                                return Expanded(
                                  child: Container(
                                      width: ScreenUtil().setWidth(360),
                                      height: ScreenUtil().setHeight(330),
                                      child: ListView.builder(
                                              controller: msgCon,
                                              padding: EdgeInsets.all(0),
                                              physics: BouncingScrollPhysics(),
                                              reverse: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: snapshot.data.docs.length,
                                              itemBuilder: (context, pos) {

                                                  var d = DateTime.fromMillisecondsSinceEpoch(snapshot.data.docs[pos].data()['time'].seconds * 1000);
                                                  var date = DateFormat.yMd().add_jm().format(d);

                                                  return Padding(
                                                      padding: EdgeInsets.fromLTRB(
                                                              ScreenUtil().setWidth(1),
                                                              ScreenUtil().setHeight(2),
                                                              ScreenUtil().setWidth(1),
                                                              ScreenUtil().setHeight(2)
                                                      ),
                                                      child: Container(
                                                          //color:Colors.blue,
                                                          child: Row(
                                                              mainAxisAlignment: (snapshot.data.docs[pos].data()['sender'] != "bmt") ?MainAxisAlignment.start:MainAxisAlignment.end,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: <Widget>[
                                                                  (snapshot.data.docs[pos].data()['sender'] != "bmt") ?
                                                                  Padding(
                                                                      padding: EdgeInsets.fromLTRB(
                                                                              ScreenUtil().setWidth(1),
                                                                              ScreenUtil().setHeight(5),
                                                                              ScreenUtil().setWidth(10),
                                                                              ScreenUtil().setHeight(1)
                                                                      ),
                                                                      child: Container(
                                                                        decoration: BoxDecoration(color: (u == null) ? Colors.lightBlueAccent : Colors.transparent,
                                                                              shape: BoxShape.circle,
                                                                          ),
                                                                          padding: EdgeInsets.fromLTRB(
                                                                                  ScreenUtil().setWidth(2),
                                                                                  ScreenUtil().setHeight(2),
                                                                                  ScreenUtil().setWidth(2),
                                                                                  ScreenUtil().setHeight(2)
                                                                          ),
                                                                        child: CircleAvatar(
                                                                            backgroundColor: Colors.white,
                                                                            backgroundImage: (u == null) ? AssetImage("Assets/User.png") : MemoryImage(u),
                                                                            radius: (u == null) ? ScreenUtil().setWidth(20) : ScreenUtil().setWidth(22),
                                                                        ),
                                                                      ),
                                                                  ) :
                                                                  SizedBox(
                                                                      width: ScreenUtil().setWidth(10),
                                                                  ),

                                                                  Container(
                                                                    child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        crossAxisAlignment: (snapshot.data.docs[pos].data()['sender'] != "bmt") ? CrossAxisAlignment
                                                                                .start : CrossAxisAlignment
                                                                                .end,
                                                                        children: <Widget>[
                                                                            (snapshot.data.docs[pos].data()['sender'] != "bmt") ?
                                                                            Padding(
                                                                              padding: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(4), 0, 0),
                                                                              child: Text("You, $date",
                                                                                  style: TextStyle(fontSize: ScreenUtil().setSp(11),
                                                                                          color: Colors.black.withOpacity(0.5)
                                                                                  ),
                                                                              ),
                                                                            ) :
                                                                            Padding(
                                                                              padding: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(4), 0, 0),
                                                                              child: Text("Bookmytrainings, $date",
                                                                                  textAlign: TextAlign.end,
                                                                                  style: TextStyle(fontSize: ScreenUtil().setSp(11),
                                                                                          color: Colors.black.withOpacity(0.5)
                                                                                  ),
                                                                              ),
                                                                            ),

                                                                            /*(!b) ? Container(
                                                                                width: ScreenUtil().setWidth(230),
                                                                                height: 20,
                                                                                alignment: (snapshot.data.docs[pos].data()['sender'] != "bmt") ?
                                                                                Alignment.centerLeft : Alignment.centerRight,
                                                                                child: Text(snapshot.data.docs[pos].data()['content'],
                                                                                    textAlign: (snapshot.data.docs[pos].data()['sender'] != "bmt") ?
                                                                                    TextAlign.start : TextAlign.end,
                                                                                    style: TextStyle(fontSize: ScreenUtil().setSp(12)),
                                                                                ),
                                                                            ) :*/ Container(
                                                                                width: ScreenUtil().setWidth(230),
                                                                                alignment: (snapshot.data.docs[pos].data()['sender'] != "bmt") ?
                                                                                Alignment.centerLeft : Alignment.centerRight,
                                                                                child: Text(snapshot.data.docs[pos].data()['content'],
                                                                                    textAlign: (snapshot.data.docs[pos].data()['sender'] != "bmt") ?
                                                                                    TextAlign.start : TextAlign.end,
                                                                                    style: TextStyle(fontSize: ScreenUtil().setSp(12)),
                                                                                ),
                                                                            ),


                                                                        ],
                                                                    ),
                                                                  ),

                                                                  (snapshot.data.docs[pos].data()['sender'] == "bmt") ?
                                                                  Padding(
                                                                      padding: EdgeInsets.fromLTRB(
                                                                              ScreenUtil().setWidth(10),
                                                                              ScreenUtil().setHeight(5),
                                                                              ScreenUtil().setWidth(1),
                                                                              ScreenUtil().setHeight(1)
                                                                      ),
                                                                      child: CircleAvatar(
                                                                          child: Image
                                                                                  .asset("Assets/ChatLogo/drawable-xhdpi/ChatLogo.png",
                                                                              width: ScreenUtil().setWidth(21),
                                                                              height: ScreenUtil().setWidth(13),
                                                                          ),
                                                                          radius: ScreenUtil().setWidth(20),
                                                                          backgroundColor: Colors.black,
                                                                      ),
                                                                  ) :
                                                                  SizedBox(
                                                                      width: ScreenUtil()
                                                                              .setWidth(10),
                                                                  ),

                                                              ],
                                                          ),
                                                      ),
                                                  );
                                              }
                                      ),
                                  ),
                                );
                            }
                          }
                        ),

                        SizedBox(
                            height: ScreenUtil().setHeight(10),
                        ),

                        Padding(
                            padding: EdgeInsets.only(bottom: (bottom>ScreenUtil().setHeight(68)) ? bottom - ScreenUtil().setHeight(68) : bottom),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 6,
                              controller: textCon,
                              focusNode: FutureProvider.of(context).focusNode,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
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
                                          bottom: 2.0),
                                  hintText: "Send your comments/queries",
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                  ),
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                          Icons.send,
                                          color: Colors.black,
                                          size: 23,),
                                      onPressed: () {
                                          if(textCon.text != "" || textCon.text != null){
                                              FirebaseFirestore.instance.collection("chat-server")
                                                      .doc(email).collection("messages")
                                                      .add({"time": DateTime.now(), "sender": "user", "content": textCon.text});
                                              FirebaseFirestore.instance.collection("chat-server")
                                                      .doc(email).update({"unread": true, "lastUserText": DateTime.now()});
                                              textCon.clear();
                                          }
                                      },
                                  ),
                              ),
                          ),
                        ),

                    ]
            ),
        );
    }

  @override
  bool get wantKeepAlive => true;

}