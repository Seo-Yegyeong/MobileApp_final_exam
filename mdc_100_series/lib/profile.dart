import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shrine/util/size.dart';

import 'login.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    late String name;
    late String email;
    late String uid;

    if(user!.isAnonymous){
      name = "Anonymous";
      email = "Anonymous";
      uid = user!.uid;
    }
    else{
      name = user!.displayName.toString();
      email = user!.email.toString();
      uid = user!.uid;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: ElevatedButton(
          child: Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.resolveWith((color) => Color(0xFF000000)),
            elevation: MaterialStateProperty.resolveWith((elevation) => 0.0),
          ),
        ),
        actions: [
          ElevatedButton(
            child: Icon(Icons.exit_to_app),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                  (color) => Color(0xFF000000)),
              elevation: MaterialStateProperty.resolveWith((elevation) => 0.0),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: getScreenHeight(context),
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                children: [
                  Container(
                    height: getScreenHeight(context) * 0.3,
                    width: getScreenWidth(context) * 0.75,
                    child: Text("Image space"),
                    color: Colors.lightGreen,
                  ),
                  SizedBox(
                    height: getScreenHeight(context) * 0.1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      uid,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                      email,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: getScreenHeight(context) * 0.1,
                      ),
                      Text(
                        name,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "I promise to take the test honestly before God",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
