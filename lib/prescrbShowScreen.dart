import 'package:flutter/material.dart';
import 'package:medstation_partner/widgets/models/orderDetails.dart';
import 'package:medstation_partner/widgets/widgets.dart';

class PresciShowScreen extends StatefulWidget {
  final String img;
  PresciShowScreen({Key? key, required this.img}) : super(key: key);

  @override
  State<PresciShowScreen> createState() => _PresciShowScreenState();
}

class _PresciShowScreenState extends State<PresciShowScreen> {
  //ImageUpload
  var imageUrl =
      "https://firebasestorage.googleapis.com/v0/b/mullonkalhardwares-a8472.appspot.com/o/placeholder%2Fplaceholder-image.png?alt=media&token=e9738ca3-c35e-4343-bf1a-d80790a56f90";
  bool uploading = false;
  var imageid = "aa";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar9(),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        child: Image.network(widget.img),
      ))),
    );
  }
}
