import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'MainButton.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'SecondScreen.dart';
import 'ThirdScreen.dart';

import 'FourthScreen.dart';
import 'SixthScreen.dart';
import 'FourthScreen.dart';
import 'package:front/FifthScreen.Dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});
  @override
  State<FirstScreen> createState() => _HomeState();
}

class _HomeState extends State<FirstScreen> {
  //get _date => null;
  int _enabledButtonIndex = -1;
  final connector = WalletConnect(
    bridge: 'https://bridge.walletconnect.org',
    clientMeta: PeerMeta(
      name: 'name WalletConnect',
      description: 'description WalletConnect Developer App',
      url: 'https://walletconnect.org',
      icons: [
        'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
      ],
    ),
  );

  var _session, session, uri;
  int i = 0;
  connectMetamaskWallet(BuildContext context) async {
    if (!connector.connected) {
      try {
        session = await connector.createSession(onDisplayUri: (_uri) async {
          uri = _uri;
          await launchUrlString(_uri, mode: LaunchMode.externalApplication);
        });
        setState(() {
          _session = session;
          i = i + 1;
        });
      } catch (eroor) {
        print("error at connect $eroor");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    connector.on(
        'connect',
        (session) => setState(() {
              _session = session;
            }));
    connector.on(
        'session_update',
        (payload) => setState(() {
              _session = session;
            }));
    connector.on(
        'disconnect',
        (session) => setState(() {
              _session = session;
            }));
    var account = session?.accounts[0];
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Blood Donation'),
          //centerTitle: true,

          backgroundColor: Colors.red[600],
        ),
        body: (session == null)
            ? SingleChildScrollView(
                child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(100.0),
                      child: Text(
                        "Connect to Start the Blood Journey ",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )),
                  ElevatedButton.icon(
                      onPressed: () => connectMetamaskWallet(context),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.red[900],
                        fixedSize: Size(300, 60),
                        elevation: 20,
                        shadowColor: Colors.red[400],
                        shape: StadiumBorder(),
                        textStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      icon: Icon(
                        Icons.water_drop,
                        color: Colors.red,
                      ),
                      label: Text("Connect")),
                  //SizedBox(height: 1),
                  Padding(
                      padding: const EdgeInsets.all(60.0),
                      child: Text(
                        "A drop for you, an ocean for someone else...",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      )),
                ],
              ))
            : (account != null)
                ? Center(
                    child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 70.0),
                      Text(
                        'Pick your role',
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 70.0),
                      MainButton(
                        onPressed: (_enabledButtonIndex == -1 ||
                                _enabledButtonIndex == 0)
                            ? () {
                                //connectMetamaskWallet(context);
                                _disableButtons(0);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SecondScreen()));
                              }
                            : null,
                        text: "Phlebotomist",
                      ),
                      SizedBox(height: 25),
                      MainButton(
                        onPressed: (_enabledButtonIndex == -1 ||
                                _enabledButtonIndex == 1)
                            ? () {
                                /*final ValueNotifier<String> _textValueNotifier =
                                    ValueNotifier('');*/

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MyWidget()));
                                _disableButtons(1);
                              }
                            : null,
                        text: "Donor",
                      ),
                      SizedBox(height: 25),
                      MainButton(
                        onPressed: (_enabledButtonIndex == -1 ||
                                _enabledButtonIndex == 2)
                            ? () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SixthScreen()));
                                _disableButtons(2);
                              }
                            : null,
                        text: "Technician",
                      ),
                      SizedBox(height: 25),
                      MainButton(
                        onPressed: (_enabledButtonIndex == -1 ||
                                _enabledButtonIndex == 3)
                            ? () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => FourthScreen()));
                                _disableButtons(3);
                              }
                            : null,
                        text: 'Doctor',
                      ),
                      SizedBox(height: 25),
                      MainButton(
                        onPressed: (_enabledButtonIndex == -1 ||
                                _enabledButtonIndex == 4)
                            ? () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ThirdScreen()));
                                _disableButtons(4);
                              }
                            : null,
                        text: 'Transporter',
                      ),
                    ],
                  ))
                : Text("No Account"));
  }

  void _disableButtons(int buttonIndex) {
    setState(() {
      _enabledButtonIndex = buttonIndex;
    });
  }
}
