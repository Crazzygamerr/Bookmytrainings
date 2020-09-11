import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn{

    FirebaseAuth auth = FirebaseAuth.instance;

    userAuth(String email, String password, String name) async{

        FirebaseFirestore.instance.collection("chat-server").doc(email).get().then((snapshot) {
            if(snapshot.exists){
                auth.signInWithEmailAndPassword(
                        email: email,
                        password: password
                );
            } else {
                auth.createUserWithEmailAndPassword(
                        email: email,
                        password: password
                ).then((value) => createUser(email, name));
            }
        });

    }

    createUser(String email, String name) async {

        List<String> searchArray = List();
        String temp = "";
        for(int i=0; i<name.length; i++){
            temp = temp + name[i].toLowerCase();
            searchArray.add(temp);
        }
        temp = "";
        for(int i=0; i<email.length; i++){
            temp = temp + email[i].toLowerCase();
            searchArray.add(temp);
        }
        FirebaseFirestore.instance.collection("chat-server")
                .doc(email).set({
            "searchArray": searchArray,
            "isCreated": true,
            "Name": name,
            "unread": false,
            "lastUserText": DateTime.now()
        });
        FirebaseFirestore.instance.collection('chat-server')
                .doc(email).collection('messages')
                .add({
            "time": DateTime.now(),
            "sender": "bmt",
            "content": "Hi. Welcome to Bookmytrainings Chat."
                    " Your personal training consultant is just a message away"
        });

    }

}