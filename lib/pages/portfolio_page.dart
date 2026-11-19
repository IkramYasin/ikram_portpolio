import 'package:material_ui/material_ui.dart';

import '../widgets/about_section.dart';
import '../widgets/chat_widget.dart';
import '../widgets/common.dart';
import '../widgets/contact_section.dart';
import '../widgets/education_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/site_footer.dart';
import '../widgets/site_header.dart';
import '../widgets/skills_section.dart';

/// Main portfolio shell. Each navigation section is a separate page view.
/// Section index order:
/// 0 Home, 1 About, 2 Skills, 3 Projects, 4 Education, 5 Contact.
class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ValueNotifier<int> _active = ValueNotifier<int>(0);
  bool _menuOpen = false;

  @override
  void dispose() {
    _active.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    if (index < 0 || index >= kNavLabels.length) return;
    if (_menuOpen) setState(() => _menuOpen = false);
    if (_active.value != index) _active.value = index;
  }

  Widget _buildPage(int index) {
    return switch (index) {
      0 => HeroSection(onNav: _goTo),
      1 => AboutSection(onNav: _goTo),
      2 => const SkillsSection(),
      3 => ProjectsSection(onNav: _goTo),
      4 => const EducationSection(),
      5 => const ContactSection(),
      _ => HeroSection(onNav: _goTo),
    };
  }

  @override
  Widget build(BuildContext context) {
    final mobile = R.isMobile(context);
    final headerHeight = R.headerHeight(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            top: headerHeight,
            child: ValueListenableBuilder<int>(
              valueListenable: _active,
              builder: (context, activeIndex, _) {
                return IndexedStack(
                  index: activeIndex,
                  children: [
                    for (var i = 0; i < kNavLabels.length; i++)
                      SingleChildScrollView(
                        key: PageStorageKey<String>('portfolio-$i'),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildPage(i),
                            SiteFooter(onHome: () => _goTo(0)),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SiteHeader(
              active: _active,
              onNav: _goTo,
              menuOpen: _menuOpen,
              onToggleMenu: () => setState(() => _menuOpen = !_menuOpen),
            ),
          ),
          if (mobile && _menuOpen)
            Positioned(
              top: headerHeight,
              left: 0,
              right: 0,
              child: MobileMenu(active: _active, onNav: _goTo),
            ),
          const Positioned.fill(child: ChatOverlay()),
        ],
      ),
    );
  }
}
