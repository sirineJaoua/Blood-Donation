import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'SecondScreen.dart';
import 'ThirdScreen.dart';
import 'FifthScreen.dart';
import 'FourthScreen.dart';
import 'SixthScreen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});
  @override
  State<FirstScreen> createState() => _HomeState();
}

class _HomeState extends State<FirstScreen> {
  //get _date => null;
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
        print(session);
        print(uri);
        print("connected");
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
        appBar: AppBar(
          title: Text('Blood Donation'),
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
                            fontSize: 20.0, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      )),
                  ElevatedButton.icon(
                      onPressed: () => connectMetamaskWallet(context),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[700],
                      ),
                      icon: Icon(
                        Icons.water_drop,
                        color: Colors.red,
                      ),
                      label: Text("Connect  ")),
                ],
              ))
            : (account != null)
                ? Center(
                    child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height:
                              24.0), // Add some spacing between the text and buttons
                      Text(
                        'Choose your role',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 70.0),

                      MaterialButton(
                        color: Colors.red[900],
                        textColor: Colors.white,
                        onPressed: () {
                          connectMetamaskWallet(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SecondScreen()));
                        },
                        child: Text('Phlebotomist'),
                      ),
                      SizedBox(height: 15),
                      MaterialButton(
                        color: Colors.red[900],
                        textColor: Colors.white,
                        onPressed: () {
                          final ValueNotifier<String> _textValueNotifier =
                              ValueNotifier('');

                          Navigator.of(context).push(MaterialPageRoute(
                              // ignore: prefer_const_constructors
                              builder: (context) => FifthScreen(
                                    textValueNotifier: _textValueNotifier,
                                  )));
                        },
                        child: Text('Administrator'),
                      ),
                      SizedBox(height: 15),

                      MaterialButton(
                        color: Colors.red[900],
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SixthScreen()));
                        },
                        child: Text('Technician'),
                      ),
                      SizedBox(height: 15),
                      MaterialButton(
                        color: Colors.red[900],
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FourthScreen()));
                        },
                        child: Text('Doctor'),
                      ),
                      SizedBox(height: 15),
                      MaterialButton(
                        color: Colors.red[900],
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ThirdScreen()));
                        },
                        child: Text('Transporter'),
                      ),
                    ],
                  ))
                : Text("No Account"));
  }
}
