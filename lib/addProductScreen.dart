import 'package:flutter/material.dart';
import 'package:medstation_partner/tabScreen.dart';
import 'package:medstation_partner/widgets/widgets.dart';

class AddProuctScreen extends StatefulWidget {
  const AddProuctScreen({Key key}) : super(key: key);

  @override
  _AddProuctScreenState createState() => _AddProuctScreenState();
}

class _AddProuctScreenState extends State<AddProuctScreen> {
  String dropdownvalue = 'nutri';

  // List of items in our dropdown menu
  var items = [
    'nutri',
    'Ayurvedha',
    'Homeopathy',
    'SkinCare',
    'Essentials',
  ];
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
                            child: DropdownButton(
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
                            ),
                          ),
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
                            "    Click here to add  image.",
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: TextButton(
                    onPressed: () {
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
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                      HexColor("#003580", 1),
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
