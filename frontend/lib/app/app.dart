import 'package:flutter/material.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Shop Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: goRouter,
    );
  }
}
