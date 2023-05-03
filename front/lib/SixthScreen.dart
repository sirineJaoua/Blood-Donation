import 'package:flutter/material.dart';
import 'package:front/Mybutton.dart';
import 'package:web3dart/web3dart.dart';
import 'package:front/Connect_Blood.dart';

class SixthScreen extends StatefulWidget {
  @override
  _SixthScreenState createState() => _SixthScreenState();
}

class _SixthScreenState extends State<SixthScreen> {
  @override
  TextEditingController _valueController = TextEditingController();
  void initState() {
    super.initState();
    //getDeployedContract();
  }

  TextEditingController _amount = TextEditingController();
  TextEditingController _id = TextEditingController();
  TextEditingController _date = TextEditingController();
  //TextEditingController _typee = TextEditingController();
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
  void _resetDropdown() {
    setState(() {
      _typee = "Type";
    });
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
        title: Text('Blood Donation'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 60),
            Text("Please click this button once you receive the Donated Blood ",
                style: TextStyle(fontSize: 18, color: Colors.grey[800])),
            SizedBox(height: 60),
            MaterialButton(
              color: Colors.red[900],
              textColor: Colors.white,
              onPressed: () {
                receiveBlood();
              },
              child: Text('Received'),
            ),
            SizedBox(height: 50),
            Divider(),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _id,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: ' ID'),
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  child: TextFormField(
                    controller: _amount,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Amount'),
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  child: TextFormField(
                    controller: _date,
                    decoration: InputDecoration(labelText: ' Expiry Date'),
                  ),
                ),
                SizedBox(width: 30),
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
                // SizedBox(width: 60),
                Expanded(
                  child: Mybutton(
                    onPressed: () async {
                      int amountt = int.tryParse(_amount.text) ?? 0;
                      int id = int.tryParse(_id.text) ?? 0;

                      // String typee = _typee.text ?? " ";
                      String datee = _date.text ?? " ";
                      await analyzeBlood(id, amountt, datee, _typee);

                      // Clear the text fields after successful order placement
                      _id.clear();
                      _amount.clear();
                      _date.clear();
                      _resetDropdown();
                    },
                    text: "Valid",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
