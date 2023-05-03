import 'package:flutter/material.dart';

import 'package:web3dart/web3dart.dart';
import 'package:front/Connect_Blood.dart';
import 'package:provider/provider.dart';
import 'Mybutton.dart';

class FourthScreen extends StatefulWidget {
  @override
  _FourthScreenState createState() => _FourthScreenState();
}

class _FourthScreenState extends State<FourthScreen> {
  TextEditingController _amountt = TextEditingController();

  TextEditingController _datee = TextEditingController();
  String _typee = "Type";

  List<String> _dropdownValues = [
    "Type",
    "A+",
    "B+",
    "AB+",
    "A-",
    "B-",
    "AB-",
    "O-",
    "O+",
  ];
  TextEditingController _iD = TextEditingController();

  @override
  TextEditingController _valueController = TextEditingController();
  void initState() {
    super.initState();
    getDeployedContract();
  }

  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Doctor'),
      ),
      body: Column(children: [
        SizedBox(height: 60),
        Text(
          "   Enter the following details about the order",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: TextFormField(
              controller: _amountt,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
          ),
          SizedBox(width: 60),
          Expanded(
            child: TextFormField(
              controller: _datee,
              textAlign: TextAlign.center,
              decoration: InputDecoration(labelText: 'Date'),
            ),
          ),
          SizedBox(width: 60),
          Expanded(
              child: DropdownButton<String>(
            value: _typee,
            items: _dropdownValues
                .map(
                  (value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                _typee = value!;
              });
            },
          )),
          Expanded(
              child: Mybutton(
            onPressed: () async {
              try {
                int amountt = int.tryParse(_amountt.text) ?? 0;

                String datee = _datee.text ?? " ";
                await approveBlood(amountt, datee, _typee);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Blood Found'),
                    duration: Duration(seconds: 4),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Blood Not found'),
                    duration: Duration(seconds: 4),
                  ),
                );
              }
            },
            text: 'Search',
          )),
        ]),
        SizedBox(height: 100),
        Divider(),
        SizedBox(height: 60),
        Text("Once your patient receive the Blood : ",
            style: TextStyle(fontSize: 20)),
        SizedBox(height: 40),
        Row(
          children: [
            SizedBox(width: 60),
            Container(
              width: 260,
              child: TextFormField(
                controller: _iD,
                decoration:
                    InputDecoration(labelText: 'Please enter the donor id'),
              ),
            ),
            Container(
              child: Mybutton(
                text: "Donated",
                onPressed: () async {
                  int _id = int.tryParse(_iD.text) ?? 0;
                  await donated(_id);
                  _iD.clear();
                },
              ),
            )
          ],
        )
      ]));
}
