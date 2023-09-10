import 'package:flutter/material.dart';

import '../utils/constant.dart';

class CoinCard extends StatelessWidget {
  final String selectedCurrency;
  final String value;
  final String cryptoCurrency;
  const CoinCard({
    super.key,
    required this.selectedCurrency,
    required this.value,
    required this.cryptoCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: Colors.indigo,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            "1 $cryptoCurrency = $value $selectedCurrency",
            style: Constant.kcurrencyTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
