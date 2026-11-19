import 'package:material_ui/material_ui.dart';

import 'pages/portfolio_page.dart';
import 'theme/app_theme.dart';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ikram Yasin | Developer Portfolio',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const PortfolioPage(),
    );
  }
}
