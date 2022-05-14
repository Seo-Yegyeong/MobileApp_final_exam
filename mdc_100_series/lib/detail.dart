import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shrine/util/size.dart';

import 'home.dart';

class DatailPage extends StatefulWidget {
  const DatailPage({Key? key}) : super(key: key);

  @override
  State<DatailPage> createState() => _DatailPageState();
}

class _DatailPageState extends State<DatailPage> {
  late String name;
  late String price;
  late String desc;
  late String writer;
  late int popular;

  User? user = FirebaseAuth.instance.currentUser;

  CollectionReference products = FirebaseFirestore.instance.collection('product');
  Future<void> updatePopularCount(String name, int popular, bool flag) {
    if(flag){
      popular--;
    }
    else
      popular++;
    return products.doc(name).update({'popular' : popular});
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ProductArguments;
    writer = args.writer;
    popular = args.popular;
    bool flag = true;

    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          child: Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.resolveWith((color) => Color(0xFF9E9E9E)),
            elevation: MaterialStateProperty.resolveWith((elevation) => 0.0),
          ),
        ),
        title: Center(child: Text('Detail')),
        actions:
        [
          if (user?.uid.compareTo(args.writer) == 0)
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    name = args.name;
                    price = args.price;
                    desc = args.description;

                    Navigator.pushNamed(
                      context,
                      '/edit',
                      arguments: ProductArguments(
                        "$name",
                        "$price",
                        "$desc",
                        "$writer",
                        popular,
                      ),
                    );
                  },
                  child: Icon(Icons.create_sharp),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (color) => Color(0xFF9E9E9E)),
                    elevation: MaterialStateProperty.resolveWith((elevation) => 0.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: ()
                  {
                    CollectionReference products = FirebaseFirestore.instance.collection('product');
                    products.doc(args.name).delete();
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.delete_outline),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                            (color) => Color(0xFF9E9E9E)),
                    elevation: MaterialStateProperty.resolveWith((elevation) => 0.0),
                  ),
                ),
              ],
            )
          else
            Container(),
        ],
        backgroundColor: Color(0xFF9E9E9E),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                height: getScreenHeight(context) * 0.35,
                color: Color(0xffffc700),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getScreenWidth(context) * 0.11,
                    vertical: getScreenHeight(context) * 0.03),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: getScreenWidth(context) * 0.58,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                args.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                args.price + "원",
                                style: TextStyle(
                                  fontSize: 23,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: (){
                              updatePopularCount(name, popular, flag);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                  //    flag? 'You can only do it once!!' : 'I LIKE IT!'
                                    "hello"
                                  ),
                                  action: SnackBarAction(
                                    label: 'Action',
                                    onPressed: () {
                                      // Code to execute.
                                    },
                                  ),
                                ),
                              );
                              if(flag) {
                                print('You can only do it once!!');
                              }
                              else {
                                print('I LIKE IT!');
                                setState(() {
                                  flag = !flag;
                                  popular++;
                                });
                              }
                            }, icon: Icon(Icons.thumb_up_alt_rounded, color: Colors.red,)),

                            SizedBox(width: 5,),
                            Text("$popular"),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.thumb_up_alt_rounded),
                          SizedBox(width: 5,),
                          Text("$popular"),
                        ],
                      ),
                      onPressed: () {
                        if(flag==1){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('You can only do it once!!'),
                            action: SnackBarAction(
                              label: 'Action',
                              onPressed: () {
                                // Code to execute.
                              },
                            ),
                          ),
                        );
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('I LIKE IT!'),
                              action: SnackBarAction(
                                label: 'Action',
                                onPressed: () {
                                  // Code to execute.
                                },
                              ),
                            ),
                          );
                        }
                        //updatePopularCount(name, popular, flag);
                        setState(() {
                          flag = !flag;
                          popular++;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(args.description),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("creator : " + user!.uid),
                        Text("시이간 넣어용." + "Created"),
                        Text("시간 넣어용!" + "Modified"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
