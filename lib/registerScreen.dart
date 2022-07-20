import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medstation_partner/tabScreen.dart';
import 'package:medstation_partner/widgets/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
//Gets Location
  String location = 'Null, Press Button';
  String Address = 'search';

  //ImageUpload
  var imageUrl =
      "https://firebasestorage.googleapis.com/v0/b/mullonkalhardwares-a8472.appspot.com/o/placeholder%2Fplaceholder-image.png?alt=media&token=e9738ca3-c35e-4343-bf1a-d80790a56f90";
  bool uploading = false;
  var imageid = "aa";

  final storage = new FlutterSecureStorage();
  TextEditingController nameController = new TextEditingController();
  TextEditingController watController = new TextEditingController();
  TextEditingController addrController = new TextEditingController();
// Write value

  uploadImage() async {
    print(uploading);
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile? image;

    await Permission.photos.request();
    var permmissionStatus = await Permission.photos.status;

    if (permmissionStatus.isGranted) {
      print("permission granted");
      var uuid = Uuid();
      //print();
      var imgId = uuid.v1();
      // ignore: deprecated_member_use
      image = (await _picker.getImage(
          source: ImageSource.gallery, imageQuality: 50));
      var file = File(image!.path);
      var snapshot = await _storage.ref().child("$imgId/item").putFile(file);

      var downloadUrl = await snapshot.ref.getDownloadURL();
      await storage.write(key: 'imageUrl', value: downloadUrl);
      var value1 = await storage.read(key: 'imageUrl');
      var value2 = await storage.read(key: 'location');
      print(value2);
      print(value1);
      setState(() {
        imageUrl = downloadUrl;
        uploading = true;
        imageid = imgId;
        //_uploadSuccess = true;
        print(imageUrl);
        print(uploading);
        print(imageid);
      });
    } else {
      print("permission denied");
    }
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }

  Future<void> send() async {
    var shopname = nameController.text;
    var sAddress = addrController.text;
    var wnumber = watController.text;
    var sLocation = await storage.read(key: 'location');
    // This will be sent as form data in the post requst
    // String number = "+91" + noController.text;
    // print(number);
    var number = await storage.read(key: 'username');
    print("cutfufuggigiigiu");
    var map = new Map<String, dynamic>();
    map['username'] = number;
    map['shopName'] = shopname;
    map['sAddress'] = sAddress;
    map['phoneNumber'] = number;
    map['whatsappNumber'] = wnumber;
    map['sLocation'] = sLocation;
    map['image'] = imageUrl;

    // map['password'] = 'password';
    var token = await storage.read(key: "token");
    var token2 =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MmFmNmI4ZjdiMTk5ODhjM2MwZDdkOGIiLCJpYXQiOjE2NTU2NjM1MDMsImV4cCI6MTY4MTU4MzUwM30.XFCZc-w2pZURhLNiozjjEYq0rVuykttxmoZ9TjO32j8";
    final response = await http.post(
      Uri.parse('https://projectmedico.herokuapp.com/vendor/createVendor'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token2',
      },
      encoding: Encoding.getByName("utf-8"),
      body: jsonEncode(map),
    );

    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#003580", 1),
      appBar: AppBar6(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.width,
              color: HexColor("#003580", 1),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 36,
                          color: Colors.white),
                    ),
                    Text(
                      "Enter Shop details and go forward.",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () {
                      uploadImage();
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: .1),
                          borderRadius: BorderRadius.circular(3)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add_a_photo_outlined,
                              color: HexColor("#003580", 1),
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "    Click here to add store image.",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: HexColor("#003580", 1),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    child: TextField(
                      controller: nameController,
                      decoration: new InputDecoration(
                          isDense: true,
                          prefixIcon: Padding(
                              padding: EdgeInsets.all(15),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  Icons.store,
                                  color: HexColor("#003580", 1),
                                ),
                              )),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 5.0),
                          // border: InputBorder.none,

                          border: new OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(color: Colors.grey[600]),
                          hintText: "Store Name",
                          fillColor: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 50,
                    child: TextField(
                      controller: watController,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          isDense: true,
                          prefixIcon: Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                '+91 ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: HexColor("#003580", 1),
                                ),
                              )),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 5.0),
                          // border: InputBorder.none,

                          border: new OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(color: Colors.grey[600]),
                          hintText: "Whatsapp Number",
                          fillColor: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    height: 150,
                    child: TextField(
                      controller: addrController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: new InputDecoration(
                          isDense: true,
                          prefixIcon: Padding(
                              padding: EdgeInsets.all(15),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  Icons.store,
                                  color: HexColor("#003580", 1),
                                ),
                              )),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 5.0),
                          // border: InputBorder.none,

                          border: new OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(color: Colors.grey[600]),
                          hintText: "Store Address",
                          fillColor: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 10, right: 20, left: 20),
              child: Text(
                "Please add location from inside the store.",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 0, bottom: 20, right: 20, left: 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: TextButton(
                  onPressed: () async {
                    Position position = await _getGeoLocationPosition();
                    location =
                        'Lat: ${position.latitude} , Long: ${position.longitude}';
                    GetAddressFromLatLong(position);
                    print(location);
                    await storage.write(key: 'location', value: location);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_searching,
                            color: HexColor("#003580", 1),
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "   Click here to add store location",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: HexColor("#003580", 1),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.white,
                  )),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 16,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: TextButton(
                  onPressed: () {
                    send();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TabScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: HexColor("#003580", 1),
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.white,
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
