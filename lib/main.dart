import 'package:bit_coin/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CoinApp());
}

class CoinApp extends StatelessWidget {
  const CoinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
