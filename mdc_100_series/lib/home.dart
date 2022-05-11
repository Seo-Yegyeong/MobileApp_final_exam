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
        '/logout': (context) => const LoginPage(),
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
  var _favoriteSaved = Set<int>();

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
          Icon(Icons.add),
          SizedBox(width: 15,)
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
                                        margin: EdgeInsets.symmetric(vertical: 5),
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
            height: getScreenHeight(context) * 0.05,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ToggleButtons(
                    color: Colors.black.withOpacity(0.60),
                    selectedColor: const Color(0xFF6200EE),
                    selectedBorderColor: const Color(0xFF6200EE),
                    fillColor: const Color(0xFF6200EE).withOpacity(0.08),
                    splashColor: const Color(0xFF6200EE).withOpacity(0.12),
                    hoverColor: const Color(0xFF6200EE).withOpacity(0.04),
                    borderRadius: BorderRadius.circular(4.0),
                    isSelected: isSelected,
                    onPressed: (index) {
                      // Respond to button selection
                      setState(() {
                        isSelected[0] = !isSelected[0];
                        isSelected[1] = !isSelected[1];
                      });
                    },
                    children: const [
                      Icon(Icons.list),
                      Icon(Icons.grid_view),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: getScreenHeight(context) * 0.8,
            child: OrientationBuilder(
              builder: (context, orientation) {
                return ProductInfo();
                //   GridView.count(
                //   crossAxisCount:
                //   orientation == Orientation.portrait ? 2 : 3,
                //   padding: const EdgeInsets.all(16.0),
                //   childAspectRatio: 8.0 / 10.0,
                //   children: _buildGridCards(context),
                // );
              },
            ),
          ),
        ],
      ),
    );
  }

  // GridView _buildGridView(context){
  //   return GridView.builder(
  //       gridDelegate: ,
  //       itemBuilder: )
  // }
//
  // Widget _buildGridCards(context) {
  //   bool _alreadySaved;
  //
  //   // if (products.isEmpty) {
  //   //   return const <Card>[];
  //   // }
  //
  //   return products.map((product) {
  //     _alreadySaved = _favoriteSaved.contains(product.id);
  //     return Card(
  //       clipBehavior: Clip.antiAlias,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           AspectRatio(
  //             aspectRatio: 18 / 12,
  //             child: Image.asset(
  //               product.assetName,
  //               package: product.assetPackage,
  //               fit: BoxFit.fitWidth,
  //             ),
  //           ),
  //           Expanded(
  //             child: Padding(
  //               padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   StarWidget(reputation_count: product.requtation),
  //                   Text(
  //                     product.name,
  //                     style: TextStyle(fontSize: 15),
  //                     maxLines: 1,
  //                   ),
  //                   Expanded(
  //                     child: Row(
  //                       children: [
  //                         Icon(
  //                           Icons.location_on_sharp,
  //                           color: Colors.lightBlue,
  //                           size: 20,
  //                         ),
  //                         Expanded(
  //                           child: Text(
  //                             product.location,
  //                             style: TextStyle(fontSize: 8),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     crossAxisAlignment: CrossAxisAlignment.end,
  //                     children: [
  //                       TextButton(
  //                         child: Text(
  //                           "more",
  //                           style: TextStyle(
  //                               color: Colors.lightBlue,
  //                               fontSize: 10,
  //                               fontWeight: FontWeight.bold),
  //                         ),
  //                         onPressed: () {
  //                           Navigator.of(context).push(MaterialPageRoute<void>(
  //                               builder: (BuildContext context) {
  //
  //                                 return Scaffold(
  //                                   appBar: AppBar(
  //                                     title: const Text('Detail'),
  //                                   ),
  //                                   body: ListView(
  //                                     children: [
  //                                       Stack(
  //                                         children: [
  //                                           AspectRatio(
  //                                             aspectRatio: 18 / 12,
  //                                             child: Hero(
  //                                               tag: "imageHero",
  //                                               child: Image.asset(
  //                                                 product.assetName,
  //                                                 package: product.assetPackage,
  //                                                 fit: BoxFit.fitWidth,
  //                                               ),
  //                                             ),
  //                                           ),
  //                                           Positioned(
  //                                             right: 10,
  //                                             child: IconButton(
  //                                               onPressed: () {
  //                                                 setState(() {
  //                                                   if (_alreadySaved) {
  //                                                     _favoriteSaved.remove(product.id);
  //                                                     print("cancel");
  //                                                     print(_favoriteSaved.length);
  //                                                   } else {
  //                                                     _favoriteSaved.add(product.id);
  //                                                     print("love");
  //                                                     print(_favoriteSaved.length);
  //                                                   }
  //                                                   _alreadySaved = !_alreadySaved;
  //                                                 });
  //                                               },
  //                                               icon: _alreadySaved? Icon(Icons.favorite_border, color: Colors.red,) :
  //                                               Icon(Icons.favorite, color: Colors.red),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                       Padding(
  //                                         padding: const EdgeInsets.symmetric(horizontal:20.0, vertical: 10.0),
  //                                         child: Column(
  //                                           crossAxisAlignment: CrossAxisAlignment.start,
  //                                           children: [
  //                                             StarWidget(reputation_count: product.requtation),
  //                                             SizedBox(height: 15,),
  //                                             // AnimatedTextKit(
  //                                             //   animatedTexts: [
  //                                             //     TypewriterAnimatedText(
  //                                             //       product.name,
  //                                             //       textStyle: const TextStyle(
  //                                             //         fontSize: 32.0,
  //                                             //         fontWeight: FontWeight.bold,
  //                                             //       ),
  //                                             //       speed: const Duration(milliseconds: 400),
  //                                             //     ),
  //                                             //   ],
  //                                             //   totalRepeatCount: 4,
  //                                             //   pause: const Duration(milliseconds: 1000),
  //                                             //   displayFullTextOnTap: true,
  //                                             //   stopPauseOnTap: true,
  //                                             // ),
  //                                             SizedBox(height: 15,),
  //                                             Row(
  //                                               children: [
  //                                                 Icon(
  //                                                   Icons.location_on,
  //                                                   color: Colors.lightBlue,
  //                                                   size: 20,
  //                                                 ),
  //                                                 SizedBox(width: 10,),
  //                                                 Expanded(
  //                                                   child: Text(
  //                                                     product.location,
  //                                                     style: TextStyle(fontSize: 15),
  //                                                   ),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                             SizedBox(height: 10,),
  //                                             Row(
  //                                               children: [
  //                                                 Icon(
  //                                                   Icons.phone,
  //                                                   color: Colors.lightBlue,
  //                                                   size: 20,
  //                                                 ),
  //                                                 SizedBox(width: 10,),
  //                                                 Expanded(
  //                                                   child: Text(
  //                                                     product.telephone,
  //                                                     style: TextStyle(fontSize: 15),
  //                                                   ),
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                             Divider(thickness: 2,),
  //                                             Padding(
  //                                               padding: const EdgeInsets.all(8.0),
  //                                               child: Expanded(
  //                                                 child: Text(
  //                                                   product.description,
  //                                                   style: TextStyle(fontSize: 15),
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 );
  //                               }));
  //                         },
  //                       )
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }).toList();
  // }
}

class ProductInfo extends StatefulWidget {
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance.collection('Product').snapshots();

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

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['Name']),
              subtitle: Text(data['Price']),
            );
          }).toList(),
        );
      },
    );
  }
}


//for delievering arguments through navigator but it does not work in that Page....
class favoriteNum_to_name {
  favoriteNum_to_name(this.favorite_Number, this.products,);

  final Set<int> favorite_Number;
  final List<Product> products;
  List<String> favorite_name = ["",];

  List<String> convert_numToName (){
    favorite_name = ["",];
    for(int i=0; i<favorite_Number.length; i++){
      favorite_name[i] = products[favorite_Number.elementAt(i)].name;
    }
    return favorite_name;
  }

}