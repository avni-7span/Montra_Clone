import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montra_clone/app/routes/router/router.dart';
import 'package:montra_clone/core/repository/authentication_repository.dart';
import 'package:montra_clone/firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthenticationRepository(),
      child: MaterialApp.router(
        routerConfig: _router.config(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: GoogleFonts.inter().fontFamily),
      ),
    );
  }
}
