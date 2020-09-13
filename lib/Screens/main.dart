import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:Bookmytrainings/Screens/Loading.dart';


void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(MaterialApp(
        title: "Bookmytrainings",
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
    ));

}