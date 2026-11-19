import 'package:material_ui/material_ui.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'pages/admin_page.dart';
import 'pages/portfolio_page.dart';
import 'services/portfolio_store.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PortfolioStore.load();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ikram Yasin | Developer Portfolio',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      onGenerateRoute: (settings) {
        if (settings.name == '/admin') {
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (_) => const AdminPage(),
          );
        }
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const PortfolioPage(),
        );
      },
    );
  }
}
