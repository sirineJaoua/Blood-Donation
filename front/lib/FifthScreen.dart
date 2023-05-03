import 'package:flutter/material.dart';
import 'package:front/Connect_Blood.dart';
import 'package:front/Mybutton.dart';
import 'Mybutton.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String? _returnValue;
  TextEditingController _valueController = TextEditingController();
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
            title: Text('Blood Donation'),
          ),
          body: Center(
              child: Column(children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                controller: _valueController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Enter Your Id To know where is your Blood'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Mybutton(
                onPressed: () async {
                  int value = int.tryParse(_valueController.text) ?? 0;
                  final returnValue = await stateDonner(value);
                  setState(() {
                    _returnValue = returnValue;
                  });
                },
                text: "Check",
              ),
            ),
            SizedBox(height: 40),
            if (_returnValue != null)
              Row(
                children: [
                  Icon(Icons.water_drop_outlined, color: Colors.red),
                  Text(" $_returnValue")
                ],
              )
          ]))),
    );
  }
}
