import 'package:flutter/material.dart';
import 'package:shrine/util/size.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          child: Expanded(child: Text("Cancel", style: TextStyle(color: Colors.black),)),
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
            height: getScreenHeight(context)*0.4,
            width: getScreenWidth(context),
            child: Center(child: Text("Picture zone")),
            color: Color(0xFFFFC700),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Product Name"),
                Text("Price"),
                Text("Description"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}