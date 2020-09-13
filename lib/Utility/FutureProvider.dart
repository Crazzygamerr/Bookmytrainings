import 'package:flutter/material.dart';

class FutureProvider extends InheritedWidget{

    final Widget child;
    final PageController pageCon;
    //final Stream<QuerySnapshot> loadBanners;
    //String email;
    final FocusNode focusNode;

    FutureProvider({this.child, this.pageCon, this.focusNode});

    @override
    bool updateShouldNotify(InheritedWidget oldWidget) {
        return true;
    }

    static FutureProvider of(BuildContext context){
        return context.dependOnInheritedWidgetOfExactType();
    }

}