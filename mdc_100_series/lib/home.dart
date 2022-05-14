// import 'package:flutter/material.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Icon(Icons.account_circle),
//         title: Text('Main'),
//         actions: [
//           Icon(Icons.add)
//         ],
//       ),
//       body: Center(
//         child: Text('You did it!'),
//       ),
//     );
//   }
// }
//

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
import 'package:flutter/material.dart';
import 'package:shrine/profile.dart';
import 'package:shrine/util/size.dart';
import 'create.dart';
import 'detail.dart';
import 'edit.dart';
import 'model/product.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Routes Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const buildScaffold(),
        '/home': (context) => const buildScaffold(),
        '/create': (context) => const CreatePage(),
        '/detail': (context) => const DatailPage(),
        '/logout': (context) => const buildScaffold(),
        '/edit': (context) => const EditPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}

class buildScaffold extends StatefulWidget {
  const buildScaffold({Key? key}) : super(key: key);

  @override
  State<buildScaffold> createState() => _buildScaffoldState();
}

class _buildScaffoldState extends State<buildScaffold> {
  //final List<bool> _isChecked = [false, false];
  String dropdownValue = 'Asc';
  List<String> order = ['Asc', 'Desc'];

  //static const String _url = 'https://www.handong.edu/';
  final isSelected = <bool>[true, false];
  //var _favoriteSaved = Set<int>();

  // void _launchURL() async {
  //   if(!await launch(_url)) throw 'Could not launch $_url';
  // }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              }),
          title: Center(child: const Text('Main')),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, '/create');
              },
            ),
            const SizedBox(
              width: 15,
            )
          ],
          backgroundColor: const Color(0xFF9E9E9E),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: order.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                        // alignment: AlignmentDirectional.centerStart
                      );
                    }).toList(),
                    alignment: Alignment.center,
                  ),
                ],
              ),
              SizedBox(
                height: getScreenHeight(context) * 0.03,
              ),
              SizedBox(
                height: getScreenHeight(context) * 0.8,
                child: ProductInfo(order: dropdownValue,),
              ),
            ],
          ),
        ));
  }
}

class ProductInfo extends StatefulWidget {
  const ProductInfo({Key? key, required this.order}) : super(key: key);
  final String order;

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  late String name;
  late String price;
  late String desc;
  late String writer;
  late int popular;

  bool order = false; //ascending
  @override
  void initState() {
    super.initState();
    if(widget.order.compareTo('Desc')==0)
      order = true; //descending
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream =
    FirebaseFirestore.instance.collection('product').orderBy('price', descending: order).snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Column(
              children: [
                Expanded(
                    child: Image.asset("assets/images/1-0.PNG",
                        fit: BoxFit.fitWidth)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(data['name']),
                        subtitle: Text(data['price'] + "원"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              name = data['name'];
                              price = data['price'];
                              desc = data['description'];
                              writer = data['writer'];
                              popular = data['popular'];

                              Navigator.pushNamed(
                                context,
                                '/detail',
                                arguments: ProductArguments(
                                    "$name", "$price", "$desc", "$writer", popular),
                              );
                            },
                            child: const Text(
                              "more",
                              style: TextStyle(color: Colors.blue),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (color) => Colors.white),
                              elevation: MaterialStateProperty.resolveWith(
                                  (elevation) => 0.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}

class ProductArguments {
  final String name;
  final String price;
  final String description;
  final String writer;
  final int popular;

  ProductArguments(this.name, this.price, this.description, this.writer, this.popular);
}

//for delievering arguments through navigator but it does not work in that Page....
class favoriteNum_to_name {
  favoriteNum_to_name(
    this.favorite_Number,
    this.products,
  );

  final Set<int> favorite_Number;
  final List<Product> products;
  List<String> favorite_name = [
    "",
  ];

  List<String> convert_numToName() {
    favorite_name = [
      "",
    ];
    for (int i = 0; i < favorite_Number.length; i++) {
      favorite_name[i] = products[favorite_Number.elementAt(i)].name;
    }
    return favorite_name;
  }
}
