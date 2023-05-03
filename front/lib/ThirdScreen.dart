import 'package:flutter/material.dart';

import 'package:front/ButtonT.dart';
import 'package:web3dart/web3dart.dart';
import 'package:front/Connect_Blood.dart';
import 'package:provider/provider.dart';

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  String? _Bank;
  String? _Hospital;

  @override
  TextEditingController _valueController = TextEditingController();
  void initState() {
    super.initState();
    //getDeployedContract();
  }

  bool _approved = false;
  List<int> _approvedIndices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: NavBar(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () async {
              final bank = await deliverBank();
              final hospital = await deliverHopital();
              setState(() {
                _Bank = bank;
                _Hospital = hospital;
              });
              //if (_Bank != null && _Hospital != null)
              final snackBar = SnackBar(
                content: Text(
                    'There are $_Bank blood units to tranfer to the Bank, and $_Hospital to transfer to the Hospital '),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              );

              // Find the ScaffoldMessenger in the widget tree
              // and use it to show a SnackBar.
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              // Show the sidebar here
            },
          ),
        ],
        backgroundColor: Colors.red[600],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Transporter'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Option 1'),
              onTap: () {
                // Handle option 1
              },
            ),
            ListTile(
              title: Text('Option 2'),
              onTap: () {
                // Handle option 2
              },
            ),
          ],
        ),
      ),
      body: Builder(builder: (BuildContext context) {
        return Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 60),
              Text("On your way to The Bank", style: TextStyle(fontSize: 20)),
              SizedBox(height: 60),
              ButtonT(
                onPressed: () {
                  startDelievery();
                },
                text: 'Start Delivery',
              ),
              SizedBox(height: 16),
              ButtonT(
                onPressed: () {
                  endDelievery();
                },
                text: 'End Delivery',
              ),
              SizedBox(height: 60),
              Divider(),
              SizedBox(height: 60),
              Text("On your way to The Hospital",
                  style: TextStyle(fontSize: 20)),
              SizedBox(height: 60),
              ButtonT(
                onPressed: () {
                  toTheHospital();
                },
                text: 'Start Delivery',
              ),
              SizedBox(height: 16),
              ButtonT(
                onPressed: () {
                  arrivedToHospital();
                },
                text: 'End Delivery',
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}
