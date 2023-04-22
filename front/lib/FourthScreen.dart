import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:front/Connect_Blood.dart';
import 'package:provider/provider.dart';
import 'data.dart';

class FourthScreen extends StatefulWidget {
  @override
  _FourthScreenState createState() => _FourthScreenState();
}

class _FourthScreenState extends State<FourthScreen> {
  @override
  void initState() {
    super.initState();
    //getDeployedContract();
  }

  TextEditingController _amount = TextEditingController();
  TextEditingController _date = TextEditingController();
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

  TextEditingController _iD = TextEditingController();

  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => BloodOrderProvider()),
        ],
        child: MaterialApp(
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
              body: Column(
                children: [
                  SizedBox(height: 60),
                  Text("Enter the following details about the order",
                      style: TextStyle(fontSize: 20)),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _amount,
                          decoration: InputDecoration(labelText: 'Amount'),
                        ),
                      ),
                      SizedBox(width: 60),
                      Expanded(
                        child: TextFormField(
                          controller: _date,
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
                      //SizedBox(width: 60),
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                              primary: Colors.red[900],
                              backgroundColor:
                                  Color.fromARGB(255, 158, 158, 158)),
                          onPressed: () async {
                            final bloodOrderProvider =
                                Provider.of<BloodOrderProvider>(context,
                                    listen: false);
                            int amountt = int.tryParse(_amount.text) ?? 0;

                            // String typee = _typee.text ?? " ";
                            String datee = _date.text ?? " ";
                            await orderBlood(amountt, _typee, datee);
                            bloodOrderProvider.updateBloodOrder(
                                amountt, datee, _typee);

                            // Clear the text fields after successful order placement
                            _amount.clear();
                            _date.clear();
                            _resetDropdown();
                          },
                          child: Text('Order'),
                        ),
                      ),
                    ],
                  ),
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
                          decoration: InputDecoration(
                              labelText: 'Please enter the donner id'),
                        ),
                      ),
                      Container(
                        child: TextButton(
                          style: TextButton.styleFrom(
                              primary: Colors.red[900],
                              backgroundColor:
                                  Color.fromARGB(255, 158, 158, 158)),
                          onPressed: () async {
                            int _id = int.tryParse(_iD.text) ?? 0;
                            await donated(_id);
                            _iD.clear();
                          },
                          child: Text("Donated"),
                        ),
                      )
                    ],
                  )
                ],
              )),
        ));
  }
}
