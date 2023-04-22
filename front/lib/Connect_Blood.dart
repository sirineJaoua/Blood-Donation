import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';

final String _rpcUrl = "http://192.168.0.19:7545";
final String _wsUrl = "ws://192.168.0.19:7545";
final String _privatekey =
    "3b67bb58dc6638ce52523516324c557657921f532e51199862dde7e471cfce65"; //phlebomotomist
final String _privatekey1 =
    "99797b94cf247cc833351f43a007b525988257d1b1c24b78cb85ec30df33b270";
//transpoter
final String _privatekey2 =
    "78bc8bf5daea2fe4ef1b8b3b6220692213a33e0381ef691aab9c0256bc0f0205"; //Doctor

final String _privatekey3 =
    "b6ce2c516627f59168be21e75318a6323ffe3078aa1ff40f91b932da4cf8ae3c"; //Technician

final String _privatekey4 =
    "fb79911c4521e5825edd1b24f503d2b7bdbe3992f932f25995801a08fd5a6f11"; //administrator

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
