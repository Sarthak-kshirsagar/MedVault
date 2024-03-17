import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import http package
import 'package:web3dart/web3dart.dart';

class BlockchainStorage extends StatefulWidget {
  @override
  _BlockchainStorageState createState() => _BlockchainStorageState();
}

class _BlockchainStorageState extends State<BlockchainStorage> {
  late Web3Client web3client;
  late Credentials credentials;
  late DeployedContract contract;

  String storedValue = '';

  @override
  void initState() {
    super.initState();
    loadCredentials();
  }

  Future<void> loadCredentials() async {
    String rpcUrl = 'http://192.168.0.108:7545'; // Replace 'localhost' or '127.0.0.1' with your machine's IP address
    web3client = Web3Client(rpcUrl, http.Client()); // Replace with your RPC URL
    String privateKey = '4aedf51275b55a26fc286b1c313510298cd118fd9109c261845823ecf146c740'; // Replace with your private key
    web3client = Web3Client(rpcUrl, http.Client()); // Use http.Client() for httpClient
    credentials = EthPrivateKey.fromHex(privateKey);

    // Replace 'contractABIJson' with your actual contract ABI JSON
    String contractABIJson = '[{"constant":false,"inputs":[{"name":"value","type":"string"}],"name":"setValue","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"getValue","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"}]';
    // Replace 'contractAddress' with your actual contract address
    EthereumAddress contractAddress = EthereumAddress.fromHex('0xD78182Dc762738E0A61419aaE419Edfa0fC62Fa7');
    ContractAbi contractAbi = ContractAbi.fromJson(contractABIJson, 'ContractName');

    contract = DeployedContract(contractAbi, contractAddress);
  }

  Future<void> setValue() async {
    // Replace 'setValue' with your contract function name to set value
    final function = contract.function('setValue');
    await web3client.sendTransaction(
      credentials,
      Transaction.callContract(contract: contract, function: function, parameters: ['Hello, world!']),
    );
  }

  Future<void> getValue() async {
    // Replace 'getValue' with your contract function name to get value
    final function = contract.function('getValue');
    print("hi");
    List<dynamic> result = await web3client.call(
      contract: contract,
      function: function,
      params: [],
    );

    setState(() {
      storedValue = result[0].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Blockchain Storage')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await setValue();
                // Set value in blockchain
              },
              child: Text('Set Value'),
            ),
            ElevatedButton(
              onPressed: () async {
                await getValue();
                // Get value from blockchain
              },
              child: Text('Get Value'),
            ),
            SizedBox(height: 20),
            Text('Stored Value: $storedValue'),
          ],
        ),
      ),
    );
  }
}
