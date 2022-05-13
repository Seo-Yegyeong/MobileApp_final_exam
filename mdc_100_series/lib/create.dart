import 'package:flutter/material.dart';
import 'package:shrine/util/size.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {

    File? _image;
    final picker = ImagePicker();

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

    final myFormKey = GlobalKey<FormState>();
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
              onPressed: () {},
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
        body: Column(
          children: [
            Container(
              // height: getScreenHeight(context)*0.4,
              // width: getScreenWidth(context),
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
                    Text("Product Name"),
                    Text("Price"),
                    Text("Description"),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
}

