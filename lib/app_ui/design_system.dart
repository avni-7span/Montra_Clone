import 'package:flutter/material.dart';
import 'package:montra_clone/app_ui/widgets/atoms/atoms.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DesignSystem(),
    );
  }
}

class DesignSystem extends StatelessWidget {
  const DesignSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            // fontsize : 30
            const AppText(
              level: AppTextLevel.XL,
              text: 'HeadLine 1',
            ),
            // fontsize : 20
            VSpace.xsmall8(),
            const AppText(
              level: AppTextLevel.L,
              text: 'HeadLine 2',
            )
          ],
        ),
      ),
    );
  }
}

class Texts extends StatelessWidget {
  const Texts({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
