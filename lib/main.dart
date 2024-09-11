import 'package:flutter/material.dart';
import 'package:montra_clone/core/routes/router.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router.config(),
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(fontFamily: 'Inter'),
    );
  }
}
