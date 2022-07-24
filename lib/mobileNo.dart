import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medstation_partner/optScreen.dart';
import 'package:medstation_partner/registerScreen.dart';
import 'package:medstation_partner/tabScreen.dart';
import 'package:medstation_partner/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class MobileNo extends StatefulWidget {
  const MobileNo({Key? key}) : super(key: key);

  @override
  _MobileNoState createState() => _MobileNoState();
}

class _MobileNoState extends State<MobileNo> {
  bool isMainLoading = true;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    check();
    print(isLoading);
    setState(() {
      isMainLoading = false;
    });
  }

  TextEditingController noController = new TextEditingController();

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

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TabScreen()),
      );
      setState(() {
        isMainLoading = true;
      });
    } else {
      setState(() {
        isMainLoading = true;
      });
    }
    print(response.body);
    var body = response.body;
  }

  Future<void> send() async {
    // This will be sent as form data in the post requst
    String number = "+91" + noController.text;
    print(number);
    print("cutfufuggigiigiu");
    var map = new Map<String, dynamic>();
    map['phoneNumber'] = number;
    // map['password'] = 'password';

    final response = await http.post(
      Uri.parse('https://projectmedico.herokuapp.com/users/login'),
      body: map,
    );

    print(response.body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('OTP send to number'),
      ));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OtpScreen()),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#003580", 1),
        body: SafeArea(
          child: isMainLoading
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 2,
                              child: Container(
                                width: 200,
                                height: 300,
                                child: Image.asset(
                                  "image/3.png",
                                ),
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    "Lets get started.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                  Text(
                                    "What's your number?",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 50,
                                    child: TextField(
                                      controller: noController,
                                      keyboardType: TextInputType.number,
                                      decoration: new InputDecoration(
                                          isDense: true,
                                          prefixIcon: Padding(
                                              padding: EdgeInsets.all(15),
                                              child: Text('+91 ')),
                                          contentPadding:
                                              new EdgeInsets.symmetric(
                                                  vertical: 3.0,
                                                  horizontal: 5.0),
                                          // border: InputBorder.none,
                                          border: new OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                          ),
                                          filled: true,
                                          hintStyle: new TextStyle(
                                              color: Colors.grey[600]),
                                          hintText: "xxxxxxxxxxx",
                                          fillColor: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 130,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    "By signing up you accept our terms of service and",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  Text(
                                    " policy.",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  isLoading
                                      ? Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 45,
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              send();

                                              /* Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OtpScreen()),
                                        );*/
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(
                                                "Continue",
                                                style: TextStyle(
                                                  color: HexColor("#003580", 1),
                                                ),
                                              ),
                                            ),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.white)),
                                          ))
                                      : SafeArea(
                                          child: Container(
                                          child: Center(
                                            child: CircularProgressIndicator(
                                                color: Colors.white),
                                          ),
                                        ))
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
        ));
  }
}
