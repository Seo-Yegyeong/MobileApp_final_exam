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

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ProductArguments;

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
        actions: [
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
                ),
              );

              //Navigator.pop(context);
              //}
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
                //async
                {
              //아래는 참고링크야.
              //https://web.archive.org/web/20220213102213/https://firebase.flutter.dev/docs/firestore/usage/
              // if(myFormKey.currentState!.validate()){
              //   final productsRef = FirebaseFirestore.instance.collection('product').withConverter<Product>(
              //     fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
              //     toFirestore: (product, _) => product.toJson(),
              //   );
              //
              //   List<QueryDocumentSnapshot<Product>> products = await productsRef.get().then((snapshot) => snapshot.docs);
              //
              //   await productsRef.add(
              //       Product(
              //         name: nameCont.text,
              //         price: priceCont.text,
              //         description: descCont.text,
              //       )
              //   );

              //Navigator.pop(context);
              //}
            },
            child: Icon(Icons.delete_outline),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                  (color) => Color(0xFF9E9E9E)),
              elevation: MaterialStateProperty.resolveWith((elevation) => 0.0),
            ),
          ),
        ],
        backgroundColor: Color(0xFF9E9E9E),
      ),
      body: Column(
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
                horizontal: getScreenWidth(context) * 0.13,
                vertical: getScreenHeight(context) * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: getScreenWidth(context) * 0.4,
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
                            args.price,
                            style: TextStyle(
                              fontSize: 23,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.thumb_up_alt_rounded),
                        Text(" number"),
                      ],
                    ),
                  ],
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
