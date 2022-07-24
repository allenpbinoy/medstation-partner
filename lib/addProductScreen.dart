import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:medstation_partner/tabScreen.dart';
import 'package:medstation_partner/widgets/models/VendorModel.dart';
import 'package:medstation_partner/widgets/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class AddProuctScreen extends StatefulWidget {
  const AddProuctScreen({Key? key}) : super(key: key);

  @override
  _AddProuctScreenState createState() => _AddProuctScreenState();
}

class _AddProuctScreenState extends State<AddProuctScreen> {
  bool isImageLoading = true;
  bool isLoading = true;
  String imgtxt = "Click here to add image";
  var imageUrl =
      "https://firebasestorage.googleapis.com/v0/b/mullonkalhardwares-a8472.appspot.com/o/placeholder%2Fplaceholder-image.png?alt=media&token=e9738ca3-c35e-4343-bf1a-d80790a56f90";
  bool uploading = false;
  var imageid = "aa";
  List<vendorModel> plist = [];
  String shopname = "shopname";
  String phonenumber = "+91123456789";
  String address = "Address here";
  String location = "location";
  final storage = new FlutterSecureStorage();
  TextEditingController pnameController = new TextEditingController();
  TextEditingController qtyController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController compController = new TextEditingController();
  final TextEditingController _controller = new TextEditingController();
  String dropdownvalue = 'nutri';

  // List of items in our dropdown menu
  var items = [
    'nutritinolDrinks',
    'Ayurvedha',
    'Homeopathy',
    'SkinCare',
    'Essentials',
  ];

  @override
  void initState() {
    super.initState();
    check();
  }

  Future<void> check() async {
    final storage = new FlutterSecureStorage();
    var number = await storage.read(key: 'username');
    var numfinal = number?.substring(1);

    print(number);
    print(numfinal);
    print("cutfufuggigiigiu");
    var map = new Map<String, dynamic>();
    map['username'] = numfinal;
    // map['password'] = 'password';
    var token2 =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MmFmNmI4ZjdiMTk5ODhjM2MwZDdkOGIiLCJpYXQiOjE2NTU2NjM1MDMsImV4cCI6MTY4MTU4MzUwM30.XFCZc-w2pZURhLNiozjjEYq0rVuykttxmoZ9TjO32j8";

    final response = await http.post(
      Uri.parse('https://projectmedico.herokuapp.com/vendor/getVendor'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token2',
      },
      encoding: Encoding.getByName("utf-8"),
      body: jsonEncode(map),
    );

    print(response.body);

    print(response.body);
    var body = response.body;
    var data = jsonDecode(response.body) as List;
    print(data);
    /* var sname = "jj";
    sname = data['username']*/

    // ignore: unused_local_variable
    var index = 0;

    /*vendorModel vendormodel = vendorModel.fromJson(data);
    print(vendormodel.shopName);*/

    // Create storage

    // Write value

    var rb = response.body;
    var list = json.decode(rb) as List;
    plist = list.map((e) => vendorModel.fromJson(e)).toList();

    print(list);

    setState(() {
      plist = plist;
    });

    var sname = plist[index].shopName;
    print(sname);
    var snumber1 = plist[index].phoneNumber;
    var saddress = plist[index].sAddress;
    var loc = plist[index].sLocation;
    setState(() {
      shopname = sname!;
      phonenumber = snumber1!;
      address = saddress!;
      location = loc!;
    });
  }

  Future<void> send() async {
    var number = await storage.read(key: 'username');
    final shopbody = {"id": number};

    // Response res = await get(Uri.parse());
    /* var shopname = nameController.text;
    var sAddress = addrController.text;
    var wnumber = watController.text;*/
    var sLocation = await storage.read(key: 'location');
    // This will be sent as form data in the post requst
    // String number = "+91" + noController.text;
    // print(number);
    //var number = await storage.read(key: 'username');
    print("cutfufuggigiigiu");
    var map = new Map<String, dynamic>();
    map['productname'] = pnameController.text;
    map['qty'] = qtyController.text;
    map['price'] = priceController.text;
    map['category'] = _controller.text;
    map['composition'] = compController.text;
    map['username'] = number;
    map['shopname'] = shopname;
    map['sAddress'] = address;
    map['whatsappNumber'] = phonenumber;
    map['sLocation'] = location;
    map['imgUrl'] = imageUrl;
    map['status'] = "Available";

    // map['password'] = 'password';
    var token = await storage.read(key: "token");
    print(jsonEncode(map));
    var token2 =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MmFmNmI4ZjdiMTk5ODhjM2MwZDdkOGIiLCJpYXQiOjE2NTU2NjM1MDMsImV4cCI6MTY4MTU4MzUwM30.XFCZc-w2pZURhLNiozjjEYq0rVuykttxmoZ9TjO32j8";
    final response = await http.post(
      Uri.parse('https://projectmedico.herokuapp.com/products/createProduct'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token2',
      },
      encoding: Encoding.getByName("utf-8"),
      body: jsonEncode(map),
    );

    print(response.body);

    var body = response.body;

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Product added Successfully'),
      ));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TabScreen()),
      );
      setState(() {
        isLoading = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Sorry, Something went wrong.'),
      ));
      setState(() {
        isLoading = true;
      });
    }
  }

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
        isImageLoading = true;
        imgtxt = "Image Uploaded";
      });
    } else {
      print("permission denied");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar8(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add new product here ",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                height: 10,
                color: Colors.grey[200],
              ),
              Container(
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        child: TextField(
                          controller: pnameController,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: InputBorder.none,
                              labelText: 'Enter Medicine Name',
                              hintText: 'xxxxxxxxxx'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        child: TextField(
                          controller: qtyController,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: InputBorder.none,
                              labelText: 'Enter Qty',
                              hintText: 'xxxxxxxxxx'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        child: TextField(
                          controller: priceController,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: InputBorder.none,
                              labelText: 'Enter Price',
                              hintText: 'xxxxxxxxxx'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        child: TextField(
                          controller: compController,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: InputBorder.none,
                              labelText: 'Enter Composition',
                              hintText: 'xxxxxxxxxx'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(.0),
                        child: Container(
                            color: Colors.white,
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child:
                                          TextField(controller: _controller)),
                                  new PopupMenuButton<String>(
                                    icon: const Icon(Icons.arrow_drop_down),
                                    onSelected: (String value) {
                                      _controller.text = value;
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return items.map<PopupMenuItem<String>>(
                                          (String value) {
                                        return new PopupMenuItem(
                                            child: new Text(value),
                                            value: value);
                                      }).toList();
                                    },
                                  ),
                                ],
                              ),

                              /* DropdownButton(
                              // Initial Value
                              value: dropdownvalue,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownvalue = newValue;
                                });
                              },
                            )*/
                              //Container(),
                            )),
                      )
                    ],
                  ),
                ),
              ),
              isImageLoading
                  ? ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.grey[200]!,
                      )),
                      onPressed: () {
                        uploadImage();
                        setState(() {
                          isImageLoading = false;
                        });
                      },
                      child: Container(
                        color: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
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
                                    imgtxt,
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
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircularProgressIndicator(
                          color: HexColor("#003580", 1),
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: isLoading
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              isLoading = false;
                            });
                            send();
                            /*    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TabScreen()),
                      );*/
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                            HexColor("#003580", 1),
                          )),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                            color: HexColor("#003580", 1))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
