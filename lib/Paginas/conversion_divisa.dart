import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConversionRatesPage extends StatefulWidget {
  @override
  _ConversionRatesPageState createState() => _ConversionRatesPageState();
}

class _ConversionRatesPageState extends State<ConversionRatesPage> {
  double? usdToDopRate;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchConversionRate();
  }

  Future<void> fetchConversionRate() async {
    final response = await http.get(
      Uri.parse('https://api.currencyfreaks.com/v2.0/rates/latest?apikey=d90e4c817698404a98d87b03e4eb5ca8'),
    );

    if (response.statusCode == 200) {
      final rates = json.decode(response.body)['rates'];
      setState(() {
        usdToDopRate = double.parse(rates['DOP']);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load conversion rate');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
         Text('USD to DOP Conversion Rate', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'USD to DOP',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    usdToDopRate != null ? usdToDopRate.toString() : 'Loading...',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
    );
  }
}
