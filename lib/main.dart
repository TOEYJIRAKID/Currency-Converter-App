import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ExchangeRate.dart';
import 'moneybox.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: MyHomePage(),
      theme: ThemeData(primarySwatch: Colors.pink),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ExchangeRate? _dataFromAPI;
  double _amount = 1000;

  @override
  void initState() {
    super.initState();
    getExchangeRate();
  }

  Future<void> getExchangeRate() async {
    var url = Uri.parse('https://api.exchangerate-api.com/v4/latest/THB');
    var response = await http.get(url);
    setState(() {
      _dataFromAPI = exchangeRateFromJson(response.body);
    });
  }

  void calculate() {
    setState(() {
      // ทำการคำนวณเงินสกุลต่าง ๆ ตามค่าที่ผู้ใช้ใส่
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "แลกเปลี่ยนสกุลเงิน",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: _dataFromAPI == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      // เมื่อมีการเปลี่ยนแปลงใน TextField
                      // สามารถเก็บค่าที่ผู้ใช้ป้อนได้ในตัวแปร _amount
                      _amount = double.tryParse(value) ?? 0;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'จำนวนเงิน (THB)',
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: calculate,
                    child: Text('คำนวณ'),
                  ),
                  SizedBox(height: 10),
                  MoneyBox("สกุลเงิน (THB)", _amount, Colors.blue, 150),
                  SizedBox(height: 5),
                  MoneyBox(
                      "สกุลเงิน (EUR)", _amount * _dataFromAPI!.rates!["EUR"]!,
                      Colors.green, 120),
                  SizedBox(height: 5),
                  MoneyBox(
                      "สกุลเงิน (USD)", _amount * _dataFromAPI!.rates!["USD"]!,
                      Colors.red, 120),
                  SizedBox(height: 5),
                  MoneyBox(
                      "สกุลเงิน (JPY)", _amount * _dataFromAPI!.rates!["JPY"]!,
                      Colors.pink, 120),
                  SizedBox(height: 5),
                  MoneyBox(
                      "สกุลเงิน (GBP)", _amount * _dataFromAPI!.rates!["GBP"]!,
                      Colors.orange, 120),
                ],
              ),
            ),
    );
  }
}
