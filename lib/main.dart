import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'pages/portfolio_page.dart';
import 'screens/admin/admin_screen.dart';
import 'screens/admin/login_screen.dart';
import 'services/portfolio_store.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).timeout(const Duration(seconds: 5));
  } catch (_) {
    // Keep the built-in portfolio usable if Firebase initialization fails.
  }
  runApp(
    ChangeNotifierProvider(
      create: (_) => PortfolioStore(),
      child: const PortfolioApp(),
    ),
  );
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ikram Yasin | Developer Portfolio',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      initialRoute: Uri.base.path,
      routes: {
        '/': (context) => const PortfolioPage(),
        '/admin': (context) {
          return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const AdminScreen();
              } else {
                return const LoginScreen();
              }
            },
          );
        },
      },
    );
  }
}