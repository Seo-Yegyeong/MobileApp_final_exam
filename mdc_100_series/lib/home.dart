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
import 'package:shrine/util/size.dart';
import 'create.dart';
import 'detail.dart';
import 'login.dart';
import 'model/products_repository.dart';
import 'model/product.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      //onGenerateInitialRoutes: '/',
      // onGenerateRoute: (settings){
      //   if(settings.name == '/detail'){
      //     final Product p = settings.arguments;
      //   }
      // },

      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const buildScaffold(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/home': (context) => const buildScaffold(),
        '/create': (context) => const CreatePage(),
        '/detail': (context) => const DatailPage(),
        '/logout': (context) => const buildScaffold(),
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
  List<String> _item = ["ASC", "DESC"];
  bool _expanded = false;
  List<bool> _isChecked = [false, false];

  static const String _url = 'https://www.handong.edu/';
  final isSelected = <bool>[true, false];
  //var _favoriteSaved = Set<int>();

  // void _launchURL() async {
  //   if(!await launch(_url)) throw 'Could not launch $_url';
  // }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.account_circle),
        title: Center(child: Text('Main')),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.pushNamed(context, '/create');
            },
          ),
          SizedBox(
            width: 15,
          )
        ],
        backgroundColor: Color(0xFF9E9E9E),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Flexible(
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: ExpansionPanelList(
                      animationDuration: Duration(milliseconds: 500),
                      children: [
                        ExpansionPanel(
                          headerBuilder: (context, isExpanded) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "select filters",
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            );
                          },
                          body: Column(
                            children: [
                              for (var i = 0; i < _item.length; i++)
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: getScreenWidth(context) * 0.28,
                                      ),
                                      Container(
                                        width: 20,
                                        height: 22,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        alignment: Alignment.center,
                                        child: Checkbox(
                                            value: _isChecked[i],
                                            onChanged: (value) {
                                              setState(() {
                                                _isChecked[i] = value!;
                                              });
                                            }),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(child: Text(_item[i])),
                                    ],
                                  ),
                                )
                            ],
                          ),
                          isExpanded: _expanded,
                          canTapOnHeader: true,
                        ),
                      ],
                      expandedHeaderPadding: EdgeInsets.all(0),
                      expansionCallback: (panelIndex, isExpanded) {
                        _expanded = !_expanded;
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: getScreenHeight(context) * 0.8,
            child: ProductInfo(),
          ),
        ],
      ),
    );
  }
}

class ProductInfo extends StatefulWidget {
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  final Stream<QuerySnapshot> _productsStream =
      FirebaseFirestore.instance.collection('product').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Column(
              children: [
                Expanded(child: Image.asset("assets/images/1-0.PNG", fit: BoxFit.fitWidth)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
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
                          onPressed: (){
                            Navigator.pushNamed(context, '/detail');
                          },
                          child: Text(
                            "more",
                            style: TextStyle(color: Colors.blue),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((color) => Colors.white),
                            elevation: MaterialStateProperty.resolveWith((elevation) => 0.0),
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
