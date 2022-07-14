import 'package:flutter/material.dart';
import 'package:medstation_partner/optScreen.dart';
import 'package:medstation_partner/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class MobileNo extends StatefulWidget {
  const MobileNo({Key key}) : super(key: key);

  @override
  _MobileNoState createState() => _MobileNoState();
}

class _MobileNoState extends State<MobileNo> {
  TextEditingController noController = new TextEditingController();

  Future<void> send() async {
    // This will be sent as form data in the post requst
    var map = new Map<String, dynamic>();
    map['phoneNumber'] = noController.toString();
    // map['password'] = 'password';

    final response = await http.post(
      Uri.parse('http://localhost:3000/users/login'),
      body: map,
    );

    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#003580", 1),
        body: SafeArea(
          child: SingleChildScrollView(
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
                                    contentPadding: new EdgeInsets.symmetric(
                                        vertical: 3.0, horizontal: 5.0),
                                    // border: InputBorder.none,
                                    border: new OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    filled: true,
                                    hintStyle:
                                        new TextStyle(color: Colors.grey[600]),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            Text(
                              " policy.",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              child: TextButton(
                                onPressed: () {
                                  send();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const OtpScreen()),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
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
                                        MaterialStateProperty.all<Color>(
                                            Colors.white)),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
