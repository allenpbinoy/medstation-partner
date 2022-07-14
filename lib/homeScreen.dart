import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medstation_partner/addProductScreen.dart';
import 'package:medstation_partner/productScreen.dart';
import 'package:medstation_partner/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar7(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 9,
              width: MediaQuery.of(context).size.width,
              color: HexColor("#003580", 1),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                              child: Image.asset(
                            'image/2.png',
                            width: 200,
                          )),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Icon(
                                CupertinoIcons.search,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // homeItem(context),
            Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Make your Bussiness a step ahead with ",
                            style: TextStyle(
                                color: Colors.grey[800], fontSize: 14),
                          ),
                          Text(
                            "MedStation Partner App! ",
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "New Medicals, Kothamangalam ",
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: new GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddProuctScreen()),
                                );
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: HexColor("#003580", 1),
                                    border: Border.all(
                                      width: 4,
                                      color: HexColor("#003580", 1),
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 90,
                                      ),
                                      Icon(
                                        CupertinoIcons.add,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Center(
                                          child: Text("ADD NEW MEDICINE",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Colors.white)))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "All Listed Medicines",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          Container(
                            height: 8,
                            color: Colors.grey[200],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProductScreen()),
                                );
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            child: Image.network(
                                                "https://onemg.gumlet.io/image/upload/a_ignore,w_380,h_380,c_fit,q_auto,f_auto/v1600085129/cropped/mu5bahqxfrp28cut6que.jpg")),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Dolo 650",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                "Strip of 15 pcs",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "₹30",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Colors.grey[800]),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Available",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Colors.green),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 8,
                            color: Colors.grey[200],
                          )
                        ],
                      ),
                    )
                  ],
                ),

                //
              ),
            )
          ],
        ),
      )),
    );
  }
}
