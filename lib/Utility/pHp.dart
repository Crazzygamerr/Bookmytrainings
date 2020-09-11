import 'dart:convert';
import 'package:Bookmytrainings/Utility/Booking_Model.dart';
import 'package:Bookmytrainings/Utility/Payment_Model.dart';
import 'package:Bookmytrainings/Utility/sharedPref.dart';
import 'package:http/http.dart' as http;
import 'dart:core';

class pHp{

    SharedPref pref = new SharedPref();

    Future<String> getUser(String s) async {
        var map = Map<String,String>();
        map["email"] = s;
        final response = await http.post("https://www.bookmytrainings.com/app/getUser.php", body: map);
        if(response.body != "error" && response.body.isNotEmpty) {
            var x = json.decode(response.body);
            pref.setUser(x[0]['password'], x[0]['name'], s);
            return "true";
        } else if(response.body == "error") {
            return "false";
        } else {
            return "error";
        }
    }

    Future registerUser(String name, String email, String password) async {
        var map = Map<String,String>();
        map['Email'] = email;
        map['Name'] = name;
        map['Password'] = password;
        pref.setUser(password, name, email);
        final response = await http.post("https://www.bookmytrainings.com/index.php?option=com_rseventspro&layout=app_adduser", body: map);
        if(response.statusCode == 200) {
            return true;
        } else {
            return false;
        }
    }

    Future<List<PaymentModel>> getPayments(String s) async {
        var map = Map<String,String>();
        map["email"] = s;
        final response = await http.post("https://www.bookmytrainings.com/app/getPayments.php", body: map);
        List<PaymentModel> payments = [];
        if(response.body != "zero" && response.body.isNotEmpty) {
            var x = json.decode(response.body);
            for(int i=0;i<x.length;i++){
                PaymentModel pymt = new PaymentModel(x[i]['order_id'], x[i]['title'], x[i]['txn_date'], x[i]['amount'], x[i]['currency'], x[i]['txn_status']);
                payments.add(pymt);
            }
        }
        var map1 = Map<String,String>();
        map1["email"] = s;
        final response1 = await http.post("https://www.bookmytrainings.com/app/getTCPayments.php",body: map1);
        if(response1.body != "zero" && response1.body.isNotEmpty) {
            var x = json.decode(response1.body);
            for(int i=0;i<x.length;i++){
                PaymentModel pymt = new PaymentModel(x[i]['order_id'], x[i]['title'], x[i]['txn_date'], x[i]['amount'], x[i]['currency'], x[i]['txn_status']);
                payments.add(pymt);
            }
        }
        if(payments.length > 0)
            return payments;
        else
            return null;
    }

    Future<List<BookingModel>> getBookings(String s) async {
        var map = Map<String,String>();
        map["email"] = s;
        final http.Response response = await http.post("https://www.bookmytrainings.com/app/getBookings.php", body: map);
        List<BookingModel> bookings = [];
        //print(response.body);
        //print(json.decode(response.body));
        if(response.body != "zero" && response.body.isNotEmpty) {
            //var x = json.decode(response.body);
            //print("-----------------" + x[0]['title']);
            /*for(int i=0;i<x.length;i++){
                //print(x[i]['id']);
                BookingModel booking = new BookingModel(x[i]['id'], x[i]['b_id'], x[i]['title'], x[i]['start'], x[i]['end'], x[i]['v1'], x[i]['v2'], x[i]['coordinates']);
                print(booking.title);
                bookings.add(booking);
            }
            print("-----------exe");*/
            return modelFromJson(response);
        } else
            return null;
    }

    /*Future<List<BannerModel>> getBanners() async {
        final response = await http.get("https://www.bookmytrainings.com/app/getBanners.php");
        List<BannerModel> banners = [];
        if(response.body != "zero" && response.body.isNotEmpty) {
            var x = json.decode(response.body);
            for(int i=0;i<x.length;i++){
                BannerModel booking = new BannerModel(x[i]['id'], x[i]['title'], x[i]['description'], x[i]['comments'], x[i]['date'], x[i]['city'], x[i]['link'], x[i]['color']);
                banners.add(booking);
            }
            return banners;
        } else
            return null;
    }*/

    Future<int> sendOTP(String email) async {
        Map<String,String> map = new Map();
        map['email'] = email;
        final response = await http.post("https://www.bookmytrainings.com/app/sendOTP.php", body: map);
        return int.parse(response.body);
    }

    List<BookingModel> modelFromJson(http.Response response) {
        List<BookingModel> bookings = [];
        var x = json.decode(response.body);

        for(int i=0;i<x.length;i++) {

            BookingModel bookingModel = new BookingModel();
            bookingModel.id = x[i]['id'];

            bookingModel.booking_id = x[i]['b_id'];

            bookingModel.title = x[i]['name'];

            bookingModel.date1 = x[i]['start'];

            bookingModel.date2 = x[i]['end'];

            bookingModel.v1 = x[i]['v1'];

            bookingModel.v2 = x[i]['v2'];

            bookingModel.coordinates = x[i]['coordinates'];

            List<String> temp;
            if(bookingModel.coordinates != ""){
                print("exe");
                temp = bookingModel.coordinates.split(',');
                bookingModel.x = double.parse(temp[0]);
                bookingModel.y = double.parse(temp[1]);
            }

            bookings.add(bookingModel);

        }

        return bookings;

    }

}



