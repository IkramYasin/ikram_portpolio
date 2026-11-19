import 'dart:ui' show ImageFilter;

import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';

import '../theme/app_theme.dart';
import 'common.dart';

/// Section order used by the navigation (index == section index on the page).
const List<String> kNavLabels = [
  'Home',
  'About',
  'Skills',
  'Projects',
  'Education',
  'Contact',
];

class SiteHeader extends StatelessWidget {
  const SiteHeader({
    super.key,
    required this.active,
    required this.onNav,
    required this.menuOpen,
    required this.onToggleMenu,
  });

  final ValueListenable<int> active;
  final void Function(int index) onNav;
  final bool menuOpen;
  final VoidCallback onToggleMenu;

  @override
  Widget build(BuildContext context) {
    final mobile = R.isMobile(context);
    final tablet = R.isTablet(context);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          height: R.headerHeight(context),
          decoration: BoxDecoration(
            color: AppColors.bg.o(.88),
            border: const Border(bottom: BorderSide(color: AppColors.line)),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1180),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: R.pad(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Brand(onTap: () => onNav(0)),
                    if (mobile)
                      IconButton(
                        tooltip: 'Toggle navigation',
                        onPressed: onToggleMenu,
                        icon: Icon(
                          menuOpen ? Icons.close : Icons.menu,
                          color: const Color(0xFFDFF6FF),
                        ),
                      )
                    else ...[
                      ValueListenableBuilder<int>(
                        valueListenable: active,
                        builder: (context, current, _) => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (var i = 0; i < kNavLabels.length; i++) ...[
                              if (i > 0) SizedBox(width: tablet ? 10 : 29),
                              NavLink(
                                label: kNavLabels[i],
                                active: current == i,
                                size: tablet ? 12 : 13,
                                onTap: () => onNav(i),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (!tablet) _HeaderCta(onTap: () => onNav(5)),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavLink extends StatefulWidget {
  const NavLink({
    super.key,
    required this.label,
    required this.active,
    required this.onTap,
    this.size = 13,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;
  final double size;

  @override
  State<NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final color = (widget.active || _hover) ? AppColors.cyan : AppColors.muted;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: AppText.body(size: widget.size, color: color),
          child: Text(widget.label),
        ),
      ),
    );
  }
}

class _HeaderCta extends StatelessWidget {
  const _HeaderCta({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.line),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Let's talk", style: AppText.body(size: 13)),
              const SizedBox(width: 8),
              const Icon(Icons.north_east, size: 13, color: AppColors.cyan),
            ],
          ),
        ),
      ),
    );
  }
}

/// Drop-down menu shown under the header on phones.
class MobileMenu extends StatelessWidget {
  const MobileMenu({super.key, required this.active, required this.onNav});

  final ValueListenable<int> active;
  final void Function(int index) onNav;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: const BoxDecoration(
        color: Color(0xFF0B1B2C),
        border: Border.symmetric(horizontal: BorderSide(color: AppColors.line)),
      ),
      child: ValueListenableBuilder<int>(
        valueListenable: active,
        builder: (context, current, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < kNavLabels.length; i++)
              Padding(
                padding: EdgeInsets.only(
                  bottom: i == kNavLabels.length - 1 ? 0 : 17,
                ),
                child: NavLink(
                  label: kNavLabels[i],
                  active: current == i,
                  size: 14,
                  onTap: () => onNav(i),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
