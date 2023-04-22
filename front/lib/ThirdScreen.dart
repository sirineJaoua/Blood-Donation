import 'package:flutter/material.dart';
import 'package:front/Approve.dart';
import 'package:web3dart/web3dart.dart';
import 'package:front/Connect_Blood.dart';
import 'package:provider/provider.dart';

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  bool _isTextVisible = true;
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
    return Consumer<NotificationProvider>(
        builder: (context, NotificationProvider, child) {
      final msgS = NotificationProvider.notifications;

      return Scaffold(
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
        body: Builder(builder: (BuildContext context) {
          return Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 60),
                Text("On your way to The Bank", style: TextStyle(fontSize: 20)),
                SizedBox(height: 60),
                MaterialButton(
                  color: Colors.red[900],
                  textColor: Colors.white,
                  onPressed: () {
                    startDelievery();
                  },
                  child: Text('Start Delievery'),
                ),
                SizedBox(height: 16),
                MaterialButton(
                  color: Colors.red[900],
                  textColor: Colors.white,
                  onPressed: () {
                    endDelievery();
                  },
                  child: Text('End Delievery'),
                ),
                SizedBox(height: 60),
                Divider(),
                SizedBox(height: 60),
                Text("On your way to The Hospital",
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 60),
                MaterialButton(
                  color: Colors.red[900],
                  textColor: Colors.white,
                  onPressed: () {
                    toTheHospital();
                  },
                  child: Text('Start Delievery'),
                ),
                SizedBox(height: 16),
                MaterialButton(
                  color: Colors.red[900],
                  textColor: Colors.white,
                  onPressed: () {
                    arrivedToHospital();
                    setState(() {
                      _isTextVisible = false;
                    });
                  },
                  child: Text('End Delievery'),
                ),
                SizedBox(height: 20),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: msgS.length,
                    itemBuilder: (BuildContext context, int index) {
                      final _msg = msgS[index];
                      return _approvedIndices.contains(index)
                          ? Container()
                          : Row(
                              children: [
                                Text(
                                  '${_msg.msg}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.redAccent[700]),
                                )
                              ],
                            );
                    })
              ],
            ),
          );
        }),
      );
    });
  }
}
