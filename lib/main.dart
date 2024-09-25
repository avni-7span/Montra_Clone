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
  // LocaleSettings.useDeviceLocale();
  runApp(App());
  // runApp(TranslationProvider(child: App()));
}

class App extends StatelessWidget {
  App({super.key});

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthenticationRepository(),
      child: MaterialApp.router(
        // locale: TranslationProvider.of(context).flutterLocale, // use provider
        // supportedLocales: AppLocaleUtils.supportedLocales,
        // localizationsDelegates: GlobalMaterialLocalizations.delegates,
        routerConfig: _router.config(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: GoogleFonts.inter().fontFamily),
      ),
    );
  }
}
