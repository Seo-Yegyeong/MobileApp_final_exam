import 'package:flutter/material.dart';
import 'package:shrine/util/size.dart';

import 'home.dart';

class DatailPage extends StatefulWidget {
  const DatailPage({Key? key}) : super(key: key);


  @override
  State<DatailPage> createState() => _DatailPageState();
}

class _DatailPageState extends State<DatailPage> {
  //Map<String, dynamic> data
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
            backgroundColor: MaterialStateProperty.resolveWith((color) => Color(0xFF9E9E9E)),
            elevation: MaterialStateProperty.resolveWith((elevation) => 0.0),
          ),
        ),
        title: Center(child: Text('Detail')),
        actions: [
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
            child: Icon(Icons.create_sharp),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((color) => Color(0xFF9E9E9E)),
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
              backgroundColor: MaterialStateProperty.resolveWith((color) => Color(0xFF9E9E9E)),
              elevation: MaterialStateProperty.resolveWith((elevation) => 0.0),
            ),
          ),
        ],
        backgroundColor: Color(0xFF9E9E9E),
      ),
      body: Column(
        children: [
          Container(
            height: getScreenHeight(context)*0.35,
            color: Color(0xffffc700),
          ),
          SizedBox(height: 50,),
          Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text(args.name),
                      Text(args.price),
                    ],
                  ),
                ],
              ),
            ],
          ),),

          Text(args.description),
        ],
      ),
    );
  }
}
