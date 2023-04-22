import 'dart:math';

import 'package:flutter/material.dart';
import 'package:front/Approve.dart';

import 'package:front/data.dart';
import 'package:web3dart/web3dart.dart';
import 'package:front/Connect_Blood.dart';
import 'package:provider/provider.dart';

import 'FourthScreen.dart';
import 'data.dart';
import 'package:web3dart/web3dart.dart';

//import 'package:shared_preferences/shared_preferences.dart';

class FifthScreen extends StatefulWidget {
  final ValueNotifier<String> textValueNotifier;

  const FifthScreen({Key? key, required this.textValueNotifier})
      : super(key: key);

  @override
  _FifthScreenState createState() => _FifthScreenState();
}

class _FifthScreenState extends State<FifthScreen> {
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

  bool _approved = false;
  List<int> _approvedIndices = [];
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
//         ChangeNotifierProvider(create: (_) => BloodOrderProvider()),
          ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ],
        child: Consumer<BloodOrderProvider>(
          builder: (context, bloodOrderProvider, child) {
            final _bloodOrderS = bloodOrderProvider.bloodOrderS;

            return Scaffold(
              appBar: AppBar(
                title: Text('Blood Donation'),
                backgroundColor: Colors.red[600],
              ),
              body: Column(
                children: [
                  SizedBox(height: 30),
                  Text("Search for the corresponding Blood",
                      style: TextStyle(fontSize: 20)),
                  SizedBox(height: 40),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Expanded(
                      child: TextFormField(
                        controller: _amountt,
                        decoration: InputDecoration(labelText: 'Amount'),
                      ),
                    ),
                    SizedBox(width: 60),
                    Expanded(
                      child: TextFormField(
                        controller: _datee,
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
                        child: TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.red[900],
                          backgroundColor: Color.fromARGB(255, 158, 158, 158)),
                      onPressed: () async {
                        try {
                          int amountt = int.tryParse(_amountt.text) ?? 0;

                          String datee = _datee.text ?? " ";
                          await approveBlood(amountt, datee, _typee);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Blood Found'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Blood Not found'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }

                        setState(() {
                          _approvedIndices.clear();
                        });
                      },
                      child: Text('Search'),
                    )),
                  ]),
                  SizedBox(height: 60),
                  Divider(),
                  SizedBox(height: 30),
                  Text(
                    "Click here once you receive the Blood",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 30),
                  MaterialButton(
                    color: Colors.red[900],
                    textColor: Colors.white,
                    onPressed: () {
                      receiveBloodHospital();
                    },
                    child: Text('Received'),
                  ),
                  SizedBox(height: 30),
                  Divider(),
                  Text('Blood Order Details:', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 20),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: _bloodOrderS.length,
                      itemBuilder: (BuildContext context, int index) {
                        final _bloodorder = _bloodOrderS[index];
                        return _approvedIndices.contains(index)
                            ? Container()
                            : Row(
                                children: [
                                  Text('Amount: ${_bloodorder.amount}'),
                                  Text(' Date: ${_bloodorder.date}'),
                                  Text(' Type: ${_bloodorder.type}'),
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          primary: Colors.red[900],
                                          backgroundColor: Color.fromARGB(
                                              255, 158, 158, 158)),
                                      onPressed: () async {
                                        final notificationProvider =
                                            Provider.of<NotificationProvider>(
                                                context,
                                                listen: false);

                                        notificationProvider.updateNotification(
                                            "Blood needs to be Transported to The Hospital");
                                        setState(() {
                                          _approvedIndices.add(index);
                                        });
                                      },
                                      child: Text('Approve')),
                                ],
                              );
                      })
                ],
              ),
            );
          },
        ));
  }
}
