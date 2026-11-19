import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'pages/portfolio_page.dart';
import 'screens/admin/admin_screen.dart';
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
  unawaited(PortfolioStore.load());
  runApp(const PortfolioApp());
}

MaterialPageRoute<void> _routeFor(RouteSettings? settings) {
  final routeName = settings?.name ?? Uri.base.path;
  if (routeName == '/admin' || routeName.startsWith('/admin/')) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => AdminScreen(),
    );
  }
  return MaterialPageRoute<void>(
    settings: settings,
    builder: (_) => const PortfolioPage(),
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
      onGenerateInitialRoutes: (initialRoute) => [
        _routeFor(RouteSettings(name: initialRoute)),
      ],
      onGenerateRoute: (settings) {
        return _routeFor(settings);
      },
    );
  }
}