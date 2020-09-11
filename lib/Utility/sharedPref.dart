import 'dart:typed_data';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class SharedPref{

    static const String path = "ProfilePic";
    static const String password = "password";
    static const String name = "name";
    static const String number = "number";
    static const String email = "email";
    static const String login = "login";

    /*static Future saveImgToPref(String value) async {
        final SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString(path, value);
    }*/

    static Future<String> getImgFromPref() async {
        final SharedPreferences pref = await SharedPreferences.getInstance();
        return pref.getString(path);
    }

    static String stringFromImg(Uint8List data){
        return base64Encode(data);
    }

    static imgFromString(String s){
        return MemoryImage(base64Decode(s),);
    }

    Future setUser(String pass,String s, String s1) async {
        final SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString(password, pass);
        pref.setString(name, s);
        pref.setString(email, s1);
    }

    Future setUserLogin(bool b) async {
        final SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool(login, b);
    }

    Future<bool> getUserLogin() async {
        try {
          final SharedPreferences pref = await SharedPreferences.getInstance();
          if(pref.containsKey(login))
              return pref.getBool(login);
          else
              return false;
        } on Exception catch (e) {
            Fluttertoast.showToast(msg: "$e",
                textColor: Colors.black,
                fontSize: ScreenUtil().setSp(20),
                toastLength: Toast.LENGTH_LONG,
            );
            return false;
        }
    }

    Future<String> getPassword() async {
        final SharedPreferences pref = await SharedPreferences.getInstance();
        return pref.getString(password);
    }

    Future<String> getName() async {
        final SharedPreferences pref = await SharedPreferences.getInstance();
        return pref.getString(name);
    }

    Future<String> getEmail() async {
        final SharedPreferences pref = await SharedPreferences.getInstance();
        return pref.getString(email);
    }

}