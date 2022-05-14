// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //참고 링크
  //https://web.archive.org/web/20220116095507/https://firebase.flutter.dev/docs/auth/usage/
  CollectionReference database = FirebaseFirestore.instance.collection('user');
  late QuerySnapshot querySnapshot;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();


    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                const SizedBox(height: 16.0),
                const Text('SHRINE'),
                SizedBox(
                  height: 100,
                ),
                Container(
                  height: 70,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                      final UserCredential userCredential =
                      await signInWithGoogle();

                      User? user = userCredential.user;

                      if (user != null) {
                        int i;
                        querySnapshot = await database.get();

                        for (i = 0; i < querySnapshot.docs.length; i++) {
                          var a = querySnapshot.docs[i];

                          if (a.get('uid') == user.uid) {
                            break;
                          }
                        }

                        if (i == (querySnapshot.docs.length)) {
                          database.doc(user.uid).set({
                            'email': user.email.toString(),
                            'name': user.displayName.toString(),
                            'uid': user.uid,
                          });
                        }

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Authentication(),
                          ),
                        );
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            child: Image.asset('assets/google_logo.png')),
                        SizedBox(width: 30,),
                        Text(
                          'GOOGLE',
                          style: TextStyle( fontFamily: "DoHyeonFont", fontSize: 25.0, color: Color(0xFFFFFFFF),),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFFED9595),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  height: 70,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                      final UserCredential userCredential =
                      await FirebaseAuth.instance.signInAnonymously();

                      User? user = userCredential.user;
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                    },
                    child: Row(
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            child: Image.asset('assets/anonymous_icon.png'),
                        ),
                        SizedBox(width: 30,),
                        Text(
                          'GUEST',
                          style: TextStyle( fontFamily: "DoHyeonFont", fontSize: 25.0, color: Color(0xFFFFFFFF),),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFF9E9E9E),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 120.0),
            // TODO: Remove filled: true values (103)
            // TODO: Add TextField widgets (101)
            // TODO: Add button bar (101)
          ],
        ),
      ),
    );
  }
}

class Authentication extends StatelessWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if(!snapshot.hasData){
          return LoginPage();
        }
        else {
          return HomePage();
        }
      },
    );
  }
}