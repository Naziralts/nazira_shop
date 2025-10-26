import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nazira_shop/features/cart/presentation/pages/cart_page.dart';
import 'package:nazira_shop/features/cart/presentation/pages/checkout_page.dart';
import 'package:nazira_shop/features/settings/data/favorites/presentation/pages/favorites_page.dart';

import 'features/products/presentation/pages/products_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Flutter Web үчүн Hiveди туура инициализациялоо
  await Hive.initFlutter();

  // ✅ Hive Box'торду ачабыз (Chrome'до delay болушу мүмкүн)
  await Future.wait([
    Hive.openBox('cart'),
    Hive.openBox('favorites'),
  ]);

  runApp(const NaziraShopApp());
}

class NaziraShopApp extends StatelessWidget {
  const NaziraShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nazira Shop 🛍️',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ProductsPage(),
        '/cart': (context) => const CartPage(),
        '/favorites': (context) => const FavoritesPage(),
        '/checkout': (context) => const CheckoutPage(),
      },
    );
  }
}
