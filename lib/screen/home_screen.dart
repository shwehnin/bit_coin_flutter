import 'package:bit_coin/data/network.dart';
import 'package:bit_coin/utils/constant.dart';
import 'package:bit_coin/widgets/coin_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class HomeScreen extends StatefulWidget {
  static const String route = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCurrency = 'AUD';
  bool isLoading = false;
  Map<String, String> coinValues = {};

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    isLoading = true;
    try {
      var data = await Network.getData(selectedCurrency);
      isLoading = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print("Data Error $e");
    }
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in Network.currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(
          currency,
          style: Constant.kdropDownTextStyle,
        ),
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton(
        dropdownColor: Colors.indigo,
        focusColor: Colors.indigo,
        iconEnabledColor: Colors.white,
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value.toString();
          });
        });
  }

  getPicker() {
    if (Platform.isAndroid) {
      androidDropdown();
    } else if (Platform.isIOS) {
    } else {
      androidDropdown();
    }
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in Network.currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
        itemExtent: 32,
        onSelectedItemChanged: (selectedIndex) {
          setState(() {
            selectedCurrency = Network.currenciesList[selectedIndex];
            _getData();
          });
        },
        children: pickerItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: Constant.kAppBarTitleStyle,
        backgroundColor: Colors.indigo,
        title: const Text('Coin Exchange Rate'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          makeCards(),
          Container(
            alignment: Alignment.center,
            height: 120,
            color: Colors.indigo,
            child: androidDropdown(),
            // DropdownButton(
            //   focusColor: Colors.indigo,
            //   dropdownColor: Colors.indigo,
            //   iconEnabledColor: Colors.indigo,
            //   value: selectedCurrency,
            //   items: Network.currenciesList.map((e) {
            //     return DropdownMenuItem(
            //         value: e.toString(),
            //         child: Text(
            //           e,
            //           style: const TextStyle(color: Colors.white),
            //         ));
            //   }).toList(),
            //   onChanged: (value) {
            //     setState(() {
            //       selectedCurrency = value.toString();
            //       _getData();
            //     });
            //   },
            // ),
          ),
        ],
      ),
    );
  }

  Column makeCards() {
    List<CoinCard> cryptoCards = [];
    for (String crypto in Network.cryptoList) {
      cryptoCards.add(CoinCard(
          selectedCurrency: selectedCurrency,
          value: isLoading ? "?" : coinValues[crypto].toString(),
          cryptoCurrency: crypto));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }
}
