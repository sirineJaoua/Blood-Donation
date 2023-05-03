import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';

final String _rpcUrl = "http://192.168.1.63:7545";
final String _wsUrl = "ws://192.168.1.63:7545";
final String _privatekey =
    "a79ed63843be058dcfc2bb9d639619258e78dd8583425eac97525883fcc7c3ef"; //phlebomotomist
final String _privatekey1 =
    "c9ac1d2c260f0419fc42c594e37afa39f581b6dde66382484f829e13054607e0";
//transpoter
final String _privatekey2 =
    "fc811665c20d384aa67c6854295bb642a1b05a6f882db1c5d5243bafc2d478c9"; //Doctor

final String _privatekey3 =
    "b27df960a8f0c610fb4b8c16ff8d0c6570b70309de8bb96abc34aa8043768acb"; //Technician

final String _privatekey4 =
    "07287f72363aff66a918f4e566546986ac45c2320cf6498aed5e32241a8e0804"; //administrator

final client = Web3Client(
  _rpcUrl,
  Client(),
  socketConnector: () {
    return IOWebSocketChannel.connect(_wsUrl).cast<String>();
  },
);

late ContractAbi _abiCode;
late EthereumAddress _ContractAddress;

Future<DeployedContract> getDeployedContract() async {
  String abiFile = await rootBundle.loadString('src/abis/Production.json');
  var jsonABI = jsonDecode(abiFile);

  _ContractAddress =
      EthereumAddress.fromHex(jsonABI["networks"]["5777"]["address"]);
  _abiCode = ContractAbi.fromJson(
      jsonEncode(jsonABI['abi']), _ContractAddress.toString());

  final contract = DeployedContract(_abiCode, _ContractAddress);
  return contract;
}

Future<void> myFunction(int donner) async {
  // call getABI() to initialize _abiCode and _ContractAddress
  final contract = await getDeployedContract();

  // Create a transaction to call the smart contract function
  final function = contract.function("CollectBloodUnit");
  final parameters = [BigInt.from(donner)]; // pass the function parameters here
  final gasPrice = EtherAmount.inWei(BigInt.one);
  const maxGas = 200000;
  final transaction = Transaction.callContract(
    contract: contract,
    function: function,
    maxGas: maxGas,
    gasPrice: gasPrice,
    parameters: parameters,
  );
  final creds = EthPrivateKey.fromHex(_privatekey);

  final result = await client.sendTransaction(creds, transaction);

  print(result);
}

Future<void> assign(EthereumAddress trans) async {
  // call getABI() to initialize _abiCode and _ContractAddress
  final contract = await getDeployedContract();

  // Create a transaction to call the smart contract function
  final function = contract.function("AssignTransporter");
  final parameters = [trans]; // pass the function parameters here
  final gasPrice = EtherAmount.inWei(BigInt.one);
  const maxGas = 200000;
  final transaction = Transaction.callContract(
    contract: contract,
    function: function,
    maxGas: maxGas,
    gasPrice: gasPrice,
    parameters: parameters,
  );
  final creds = EthPrivateKey.fromHex(_privatekey);

  final result = await client.sendTransaction(creds, transaction);

  print(result);
}

Future<void> startDelievery() async {
  // call getABI() to initialize _abiCode and _ContractAddress
  final contract = await getDeployedContract();

  // Create a transaction to call the smart contract function
  final function = contract.function("Start_Delivery");
  final parameters = []; // pass the function parameters here
  final gasPrice = EtherAmount.inWei(BigInt.one);
  const maxGas = 2000000;
  final transaction = Transaction.callContract(
    contract: contract,
    function: function,
    maxGas: maxGas,
    gasPrice: gasPrice,
    parameters: parameters,
  );
  final creds = EthPrivateKey.fromHex(_privatekey1);

  final result = await client.sendTransaction(creds, transaction);

  print(result);
}

Future<void> orderBlood(
  int _amount,
  String _type,
  String _date,
) async {
  final contract = await getDeployedContract();

  // Create a transaction to call the smart contract function
  final function = contract.function("OrderBlood");
  final parameters = [
    BigInt.from(_amount),
    _type,
    _date
  ]; // pass the function parameters here
  final gasPrice = EtherAmount.inWei(BigInt.one);
  const maxGas = 200000;
  final transaction = Transaction.callContract(
    contract: contract,
    function: function,
    maxGas: maxGas,
    gasPrice: gasPrice,
    parameters: parameters,
  );
  final creds = EthPrivateKey.fromHex(_privatekey2);

  final result = await client.sendTransaction(creds, transaction);
  print(result);
}

Future<void> analyzeBlood(
  int _id,
  int _amount,
  String _date,
  String _type,
) async {
  final contract = await getDeployedContract();

  // Create a transaction to call the smart contract function
  final function = contract.function("CreateBloodUnit");
  final parameters = [
    BigInt.from(_id),
    BigInt.from(_amount),
    _date,
    _type
  ]; // pass the function parameters here
  final gasPrice = EtherAmount.inWei(BigInt.one);
  const maxGas = 200000;
  final transaction = Transaction.callContract(
    contract: contract,
    function: function,
    maxGas: maxGas,
    gasPrice: gasPrice,
    parameters: parameters,
  );
  final creds = EthPrivateKey.fromHex(_privatekey3);

  final result = await client.sendTransaction(creds, transaction);
  print(result);
}

Future<void> endDelievery() async {
  // call getABI() to initialize _abiCode and _ContractAddress
  final contract = await getDeployedContract();

  // Create a transaction to call the smart contract function
  final function = contract.function("End_Delivery");
  final parameters = []; // pass the function parameters here
  final gasPrice = EtherAmount.inWei(BigInt.one);
  const maxGas = 200000;
  final transaction = Transaction.callContract(
    contract: contract,
    function: function,
    maxGas: maxGas,
    gasPrice: gasPrice,
    parameters: parameters,
  );
  final creds = EthPrivateKey.fromHex(_privatekey1);

  final result = await client.sendTransaction(creds, transaction);

  print(result);
}

Future<void> receiveBlood() async {
  // call getABI() to initialize _abiCode and _ContractAddress
  final contract = await getDeployedContract();

  // Create a transaction to call the smart contract function
  final function = contract.function("BloodReceived");
  final parameters = []; // pass the function parameters here
  final gasPrice = EtherAmount.inWei(BigInt.one);
  const maxGas = 200000;
  final transaction = Transaction.callContract(
    contract: contract,
    function: function,
    maxGas: maxGas,
    gasPrice: gasPrice,
    parameters: parameters,
  );
  final creds = EthPrivateKey.fromHex(_privatekey3);

  final result = await client.sendTransaction(creds, transaction);

  print(result);
}

Future<void> approveBlood(
  int _amount,
  String _date,
  String _type,
) async {
  final contract = await getDeployedContract();
  bool bloodFound = false;
  // Create a transaction to call the smart contract function
  final function = contract.function("Approve");
  final parameters = [
    BigInt.from(_amount),
    _date,
    _type
  ]; // pass the function parameters here
  final gasPrice = EtherAmount.inWei(BigInt.one);
  const maxGas = 200000;
  final transaction = Transaction.callContract(
    contract: contract,
    function: function,
    maxGas: maxGas,
    gasPrice: gasPrice,
    parameters: parameters,
  );
  final creds = EthPrivateKey.fromHex(_privatekey4);

  final result = await client.sendTransaction(creds, transaction);
  final event = contract.event('Received');

  // final TransactionReceipt receipt = await result.waitReceipt();
  //return result.status == TransactionStatus.success;
  try {
    final result = await client.sendTransaction(creds, transaction);
    final receipt = await client.getTransactionReceipt(result);
    final bool? state = receipt!.status;
    if (state != true) {
      bloodFound = true;
      throw Exception("Blood Not found");
    }
  } catch (e) {
    throw Exception("Transaction Failed");
  }

  // set a variable to indicate that the blood was found
}

Future<void> toTheHospital() async {
  // call getABI() to initialize _abiCode and _ContractAddress
  final contract = await getDeployedContract();

  // Create a transaction to call the smart contract function
  final function = contract.function("DelieverToHospital");
  final parameters = []; // pass the function parameters here
  final gasPrice = EtherAmount.inWei(BigInt.one);
  const maxGas = 2000000;
  final transaction = Transaction.callContract(
    contract: contract,
    function: function,
    maxGas: maxGas,
    gasPrice: gasPrice,
    parameters: parameters,
  );
  final creds = EthPrivateKey.fromHex(_privatekey1);

  final result = await client.sendTransaction(creds, transaction);

  print(result);
}

Future<void> arrivedToHospital() async {
  // call getABI() to initialize _abiCode and _ContractAddress
  final contract = await getDeployedContract();

  // Create a transaction to call the smart contract function
  final function = contract.function("ArrivedToTheHospital");
  final parameters = []; // pass the function parameters here
  final gasPrice = EtherAmount.inWei(BigInt.one);
  const maxGas = 200000;
  final transaction = Transaction.callContract(
    contract: contract,
    function: function,
    maxGas: maxGas,
    gasPrice: gasPrice,
    parameters: parameters,
  );
  final creds = EthPrivateKey.fromHex(_privatekey1);

  final result = await client.sendTransaction(creds, transaction);

  print(result);
}

Future<void> receiveBloodHospital() async {
  // call getABI() to initialize _abiCode and _ContractAddress
  final contract = await getDeployedContract();

  // Create a transaction to call the smart contract function
  final function = contract.function("BloodReceivedInTheHospital");
  final parameters = []; // pass the function parameters here
  final gasPrice = EtherAmount.inWei(BigInt.one);
  const maxGas = 200000;
  final transaction = Transaction.callContract(
    contract: contract,
    function: function,
    maxGas: maxGas,
    gasPrice: gasPrice,
    parameters: parameters,
  );
  final creds = EthPrivateKey.fromHex(_privatekey4);

  final result = await client.sendTransaction(creds, transaction);

  print(result);
}

Future<void> donated(int donner) async {
  // call getABI() to initialize _abiCode and _ContractAddress
  final contract = await getDeployedContract();

  // Create a transaction to call the smart contract function
  final function = contract.function("Donation");
  final parameters = [BigInt.from(donner)]; // pass the function parameters here
  final gasPrice = EtherAmount.inWei(BigInt.one);
  const maxGas = 200000;
  final transaction = Transaction.callContract(
    contract: contract,
    function: function,
    maxGas: maxGas,
    gasPrice: gasPrice,
    parameters: parameters,
  );
  final creds = EthPrivateKey.fromHex(_privatekey2);

  final result = await client.sendTransaction(creds, transaction);

  print(result);
}

String stateString = "";
Future<String> stateDonner(int donner) async {
  // call getABI() to initialize _abiCode and _ContractAddress
  final contract = await getDeployedContract();

  // Create a transaction to call the smart contract function
  final function = contract.function("States");
  final parameters = [BigInt.from(donner)]; // pass the function parameters here
  final gasPrice = EtherAmount.inWei(BigInt.one);
  const maxGas = 200000;
  final transaction = Transaction.callContract(
    contract: contract,
    function: function,
    maxGas: maxGas,
    gasPrice: gasPrice,
    parameters: parameters,
  );
  final creds = EthPrivateKey.fromHex(_privatekey4);

  //final result = await client.sendTransaction(creds, transaction);
  final result = await client.call(
      contract: contract, function: function, params: parameters);
  final returnValue = result[0] as String;
  return (returnValue);
}

String Bank = "";
Future<String> deliverBank() async {
  // call getABI() to initialize _abiCode and _ContractAddress
  final contract = await getDeployedContract();

  // Create a transaction to call the smart contract function
  final function = contract.function("getCount");
  final parameters = []; // pass the function parameters here
  final gasPrice = EtherAmount.inWei(BigInt.one);
  const maxGas = 200000;
  final transaction = Transaction.callContract(
    contract: contract,
    function: function,
    maxGas: maxGas,
    gasPrice: gasPrice,
    parameters: parameters,
  );
  final creds = EthPrivateKey.fromHex(_privatekey2);

  //final result = await client.sendTransaction(creds, transaction);
  final result = await client.call(
      contract: contract, function: function, params: parameters);
  final Bank = result[0].toString();
  return (Bank);
}

String Hospital = "";
Future<String> deliverHopital() async {
  // call getABI() to initialize _abiCode and _ContractAddress
  final contract = await getDeployedContract();

  // Create a transaction to call the smart contract function
  final function = contract.function("getApproved");
  final parameters = []; // pass the function parameters here
  final gasPrice = EtherAmount.inWei(BigInt.one);
  const maxGas = 200000;
  final transaction = Transaction.callContract(
    contract: contract,
    function: function,
    maxGas: maxGas,
    gasPrice: gasPrice,
    parameters: parameters,
  );
  final creds = EthPrivateKey.fromHex(_privatekey2);

  //final result = await client.sendTransaction(creds, transaction);
  final result = await client.call(
      contract: contract, function: function, params: parameters);
  final Hospital = result[0].toString();
  return (Hospital);
}
