import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medstation_partner/widgets/widgets.dart';
import 'package:medstation_partner/preOrderViewScreen.dart';
import 'package:medstation_partner/widgets/models/orderDetails.dart';
import 'package:medstation_partner/widgets/widgets.dart';

import 'package:http/http.dart';

import 'package:http/http.dart' as http;
import 'customerScreen.dart';

class PreOrderView extends StatefulWidget {
  const PreOrderView({Key? key}) : super(key: key);

  @override
  State<PreOrderView> createState() => _PreOrderViewState();
}

class _PreOrderViewState extends State<PreOrderView> {
  @override
  void initState() {
    super.initState();
    check();
  }

  List<orderDetails> plist = [];
  Future<void> check() async {
    final storage = new FlutterSecureStorage();
    var number = await storage.read(key: 'username');
    var numfinal = number?.substring(1);
    String location = 'Null, Press Button';

    // var key1 = keyController.text;
    print("cutfufuggigiigiu");
    var map = new Map<String, dynamic>();
    map['key'] = "prescription";
    // map['password'] = 'password';
    var token2 =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2MmFmNmI4ZjdiMTk5ODhjM2MwZDdkOGIiLCJpYXQiOjE2NTU2NjM1MDMsImV4cCI6MTY4MTU4MzUwM30.XFCZc-w2pZURhLNiozjjEYq0rVuykttxmoZ9TjO32j8";

    final response = await http.post(
      Uri.parse(
          'https://projectmedico.herokuapp.com/order/getOrderbyTypeforUser'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token2',
      },
      encoding: Encoding.getByName("utf-8"),
      body: jsonEncode(map),
    );

    print(response.body);
    var body = response.body;
    //var data = jsonDecode(response.body) as List;
    // print(data);

    var index = 0;
    //var snumber = data[index].toString();

    var rb = response.body;
    var list = json.decode(rb) as List;
    plist = list.map((e) => orderDetails.fromJson(e)).toList();

    print(list);

    setState(() {
      plist = plist;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar9(),
        body: SafeArea(
          child: SingleChildScrollView(
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: plist.length,
                  itemBuilder: ((context, index) {
                    return Column(children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 25, right: 10, top: 10),
                          child: Column(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: Image.network(plist[index].imgUrl!)),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.grey[800],
                                              size: 18,
                                            ),
                                            Text(
                                              plist[index].shopname!,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Contact: ",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                        Text(
                                          plist[index].username!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.green),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              7,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: .5,
                        color: Colors.black26,
                      ),
                    ]);
                  }))),
        ));
  }
}
