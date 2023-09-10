import 'dart:convert';

import 'package:bit_coin/utils/constant.dart';
import 'package:http/http.dart' as http;

class Network {
  static List<String> currenciesList = [
    'AUD',
    'BRL',
    'CAD',
    'CNY',
    'EUR',
    'GBP',
    'HKD',
    'IDR',
    'ILS',
    'INR',
    'JPY',
    'MXN',
    'NOK',
    'NZD',
    'PLN',
    'RON',
    'RUB',
    'SEK',
    'SGD',
    'USD',
    'ZAR'
  ];

  static const List<String> cryptoList = [
    'BTC',
    'ETH',
    'LTC',
  ];

  static getData(selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String uri =
          "${Constant.baseUrl}/$crypto/$selectedCurrency?apikey=${Constant.apiKey}";
      var url = Uri.parse(uri);
      final responseData = await http.get(url);
      if (responseData.statusCode == 200) {
        var decodeData = jsonDecode(responseData.body);
        double price = decodeData['rate'];
        cryptoPrices[crypto] = price.toStringAsFixed(0);
      } else {
        print(responseData.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
