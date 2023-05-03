import 'package:flutter/material.dart';
import 'package:front/ButtonT.dart';
import 'package:front/Mybutton.dart';
import 'package:web3dart/web3dart.dart';
import 'package:front/Connect_Blood.dart';

EthereumAddress trans =
    EthereumAddress.fromHex("0x706DBe6698508efD4393221257Bb3D7Bba72B987");

EthereumAddress trans1 =
    EthereumAddress.fromHex("0xBCDccDc8a6bc89C34014c7D503C310A7c1F90D73");
EthereumAddress trans2 =
    EthereumAddress.fromHex("0x905D6239a7BE529EC60aaB56c63C47d6cAA0f260");

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  TextEditingController _valueController = TextEditingController();
  void initState() {
    super.initState();
    getDeployedContract();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red[600],
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('Phlebotomist'),
          ),
          body: Center(
              child: Column(children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                controller: _valueController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter the Donor Id'),
              ),
            ),
            Container(
                child: ButtonT(
              onPressed: () async {
                int value = int.tryParse(_valueController.text) ?? 0;
                await myFunction(value);
                _valueController.clear();
              },
              text: 'Collect',
            )),
            SizedBox(height: 60),
            Container(
              child: Text(
                'Choose a transporter :',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 100),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Center(
                    child: Mybutton(
                      onPressed: () {
                        assign(trans);
                      },
                      text: 'Transporter 1',
                    ),
                  )),
                  Expanded(
                      child: Center(
                    child: Mybutton(
                      onPressed: () {
                        assign(trans1);
                      },
                      text: 'Transporter 2',
                    ),
                  )),
                  Expanded(
                    child: Center(
                        child: Mybutton(
                      onPressed: () {
                        assign(trans2);
                      },
                      text: 'Transporter 3',
                    )),
                  ),
                ],
              ),
            ),
          ]))),
    );
  }
}
