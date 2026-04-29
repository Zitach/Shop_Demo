import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: ShopApp()));
}

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Shop Demo',
      home: Scaffold(
        body: Center(child: Text('Shop Demo')),
      ),
    );
  }
}
