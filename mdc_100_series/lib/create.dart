import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shrine/util/size.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'model/product.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {

    File? _image;
    final picker = ImagePicker();

    final myFormKey = GlobalKey<FormState>();
    //아래는 참고링크야!
    //https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
    final TextEditingController nameCont = TextEditingController();
    final TextEditingController priceCont = TextEditingController();
    final TextEditingController descCont = TextEditingController();

    @override
    void initState() {
      super.initState();
      nameCont.addListener(() {
        final String text = nameCont.text;
        nameCont.value = nameCont.value.copyWith(
          text: text,
          selection:
          TextSelection(baseOffset: text.length, extentOffset: text.length),
          composing: TextRange.empty,
        );
      });
      priceCont.addListener(() {
        final String text = priceCont.text;
        priceCont.value = priceCont.value.copyWith(
          text: text,
          selection:
          TextSelection(baseOffset: text.length, extentOffset: text.length),
          composing: TextRange.empty,
        );
      });
      descCont.addListener(() {
        final String text = descCont.text;
        descCont.value = descCont.value.copyWith(
          text: text,
          selection:
          TextSelection(baseOffset: text.length, extentOffset: text.length),
          composing: TextRange.empty,
        );
      });
    }

    @override
    void dispose() {
      nameCont.dispose();
      super.dispose();
    }


    // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
    Future getImage(ImageSource imageSource) async {
      final image = await picker.pickImage(source: imageSource);

      setState(() {
        _image = File(image!.path); // 가져온 이미지를 _image에 저장
      });
    }

  //  이미지를 보여주는 위젯
    Widget showImage() {
      return Container(
          color: const Color(0xffd0cece),
          width: getScreenWidth(context),
          height: getScreenHeight(context)*0.4,
          child: Center(
              child: _image == null
                  ? Icon(Icons.photo, size: 80, color: Colors.black54,)
                  : Image.file(File(_image!.path))));
    }

        @override
    Widget build(BuildContext context) {

      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

      return Scaffold(
        appBar: AppBar(
          leading: ElevatedButton(
            child: Text("Cancel", style: TextStyle(color: Colors.black),),
            onPressed: () {
              Navigator.pop(context);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((color) => Color(0xFF9E9E9E)),
              elevation: MaterialStateProperty.resolveWith((elevation) => 0.0),
            ),
          ),
          title: Center(child: Text('Add')),
          actions: [
            ElevatedButton(
              onPressed: () async {
                //아래는 참고링크야.
                //https://web.archive.org/web/20220213102213/https://firebase.flutter.dev/docs/firestore/usage/
                if(myFormKey.currentState!.validate()){
                  // final productsRef = FirebaseFirestore.instance.collection('product').withConverter<Product>(
                  //   fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
                  //   toFirestore: (product, _) => product.toJson(),
                  // );

                  //List<QueryDocumentSnapshot<Product>> products = await productsRef.get().then((snapshot) => snapshot.docs);
                  User? user = FirebaseAuth.instance.currentUser;
                  CollectionReference products = FirebaseFirestore.instance.collection('product');
                  int initial = 0;
                  Product productModel = Product(
                    name: nameCont.text,
                    price: priceCont.text,
                    description: descCont.text,
                    writer: user!.uid,
                    popular: initial,
                  );
                  String n = nameCont.text;
                  products.doc(n).set(productModel.toJson());


                  // await productsRef.add(
                  //   Product(
                  //     name: nameCont.text,
                  //     price: priceCont.text,
                  //     description: descCont.text,
                  //   )
                  // );

                  Navigator.pop(context);
                }
              },
              child: Text("Save"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((color) => Color(0xFF9E9E9E)),
                elevation: MaterialStateProperty.resolveWith((elevation) => 0.0),
              ),
            ),
            SizedBox(
              width: 15,
            )
          ],
          backgroundColor: Color(0xFF9E9E9E),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        showImage(),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            // 카메라 촬영 버튼
                            // FloatingActionButton(
                            //   child: Icon(Icons.add_a_photo),
                            //   tooltip: 'pick Image',
                            //   onPressed: () {
                            //     getImage(ImageSource.camera);
                            //   },
                            // ),
                            // SizedBox(width: 20,),
                            // 갤러리에서 이미지를 가져오는 버튼
                            // FloatingActionButton(
                            //   child: Icon(Icons.wallpaper),
                            //   tooltip: 'pick Image',
                            //   onPressed: () {
                            //     getImage(ImageSource.gallery);
                            //   },
                            // ),
                            OutlinedButton(
                              child: Icon(Icons.camera_alt, color: Colors.black,),
                              onPressed: () {
                                getImage(ImageSource.gallery);
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith((backgroundColor) => Colors.white),
                                elevation: MaterialStateProperty.resolveWith((elevation) => 0.0),
                              ),
                            ),
                            SizedBox(width: 20,),
                          ],
                        ),
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    child: Form(
                      key: myFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Product Name"
                            ),
                            controller: nameCont,
                            validator: (value){
                              if(value!.isEmpty)
                                return "enter the product name!";
                              else
                                return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Price"
                            ),
                            controller: priceCont,
                            validator: (value){
                              if(value!.isEmpty)
                                return "enter the price!";
                              else
                                return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Description"
                            ),
                            controller: descCont,
                            validator: (value){
                              if(value!.isEmpty)
                                return "enter some description!";
                              else
                                return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
}

