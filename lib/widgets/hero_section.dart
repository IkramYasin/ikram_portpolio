import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'common.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onNav});

  final void Function(int index) onNav;

  @override
  Widget build(BuildContext context) {
    final mobile = R.isMobile(context);
    final small = R.isSmall(context);

    return SectionWrap(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: mobile ? 0 : 660),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: mobile ? (small ? 55 : 70) : 42,
                bottom: 95,
              ),
              child: mobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _HeroCopy(onNav: onNav),
                        const SizedBox(height: 35),
                        const _HeroVisual(),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(flex: 105, child: _HeroCopy(onNav: onNav)),
                        const Expanded(flex: 95, child: _HeroVisual()),
                      ],
                    ),
            ),
            Positioned(
              bottom: 25,
              left: 0,
              child: _ScrollCue(onTap: () => onNav(1)),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({required this.onNav});

  final void Function(int index) onNav;

  @override
  Widget build(BuildContext context) {
    final w = R.width(context);
    final small = R.isSmall(context);
    final mobile = R.isMobile(context);

    final double h1Size = small
        ? 54
        : mobile
        ? 61
        : (R.isTablet(context) ? 64 : (w * 0.07).clamp(54.0, 84.0).toDouble());
    final h2Size = small ? 22.0 : (w * 0.024).clamp(21.0, 29.0).toDouble();

    final h1Style = AppText.display(
      size: h1Size,
      weight: FontWeight.w700,
      height: 1.04,
      letterSpacing: -h1Size * 0.06,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.cyan.o(.055),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.cyan.o(.22)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const StatusDot(),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  'AVAILABLE FOR LEARNING & COLLABORATION',
                  style: AppText.body(
                    size: small ? 8 : 10,
                    weight: FontWeight.w700,
                    color: AppColors.cyan,
                    letterSpacing: small ? 1.2 : 2,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        Text(
          "Hello, I'm",
          style: AppText.body(size: 17, color: AppColors.muted),
        ),
        const SizedBox(height: 3),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text('Ikram ', style: h1Style),
            GradientText('Yasin.', style: h1Style),
          ],
        ),
        const SizedBox(height: 18),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 530),
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'Building digital experiences with '),
                TextSpan(
                  text: 'code',
                  style: TextStyle(color: AppColors.cyan),
                ),
                const TextSpan(text: ' and curiosity.'),
              ],
            ),
            style: AppText.display(
              size: h2Size,
              weight: FontWeight.w600,
              height: 1.35,
              letterSpacing: -0.8,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Text(
            'Computer Science student, Flutter developer and Python enthusiast exploring the world of software development and Artificial Intelligence.',
            style: AppText.body(
              size: small ? 13 : 15,
              color: AppColors.muted,
              height: 1.65,
            ),
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            AppButton(label: 'Explore my work', onTap: () => onNav(3)),
            AppButton(
              label: 'Get in touch',
              primary: false,
              arrow: false,
              onTap: () => onNav(5),
            ),
          ],
        ),
        const SizedBox(height: 38),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 15,
          runSpacing: 8,
          children: [
            HoverLink(label: 'GitHub', onTap: () => openUrl(kGithub)),
            const _Dot(),
            HoverLink(label: 'LinkedIn', onTap: () => openUrl(kLinkedin)),
            const _Dot(),
            HoverLink(label: 'Email', onTap: () => openUrl('mailto:$kEmail')),
          ],
        ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3,
      height: 3,
      decoration: const BoxDecoration(
        color: Color(0xFF547086),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _HeroVisual extends StatelessWidget {
  const _HeroVisual();

  @override
  Widget build(BuildContext context) {
    final mobile = R.isMobile(context);
    final small = R.isSmall(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: small ? 310 : (mobile ? 350 : 410),
      ),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          _Orbit(
            width: mobile ? 350 : 430,
            height: mobile ? 250 : 300,
            degrees: -22,
            color: AppColors.cyan.o(.12),
          ),
          _Orbit(
            width: mobile ? 290 : 340,
            height: mobile ? 350 : 430,
            degrees: 35,
            color: AppColors.purple.o(.15),
          ),
          const _CodeCard(),
          Positioned(
            top: mobile ? 20 : 54,
            right: 0,
            child: const _FloatingChip(
              icon: Icons.auto_awesome,
              label: 'Problem solver',
            ),
          ),
          Positioned(
            bottom: mobile ? 15 : 52,
            left: 0,
            child: const _FloatingChip(
              icon: Icons.code,
              label: 'Build · Learn · Improve',
            ),
          ),
        ],
      ),
    );
  }
}

class _Orbit extends StatelessWidget {
  const _Orbit({
    required this.width,
    required this.height,
    required this.degrees,
    required this.color,
  });

  final double width;
  final double height;
  final double degrees;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: degrees * math.pi / 180,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.all(
            Radius.elliptical(width / 2, height / 2),
          ),
        ),
      ),
    );
  }
}

class _FloatingChip extends StatelessWidget {
  const _FloatingChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final small = R.isSmall(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 8 : 13,
        vertical: small ? 8 : 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF11273B),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: AppColors.cyan.o(.2)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x55000000),
            blurRadius: 30,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: small ? 11 : 13, color: AppColors.cyan),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppText.body(
              size: small ? 9 : 11,
              color: const Color(0xFFD8E8F4),
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeCard extends StatelessWidget {
  const _CodeCard();

  @override
  Widget build(BuildContext context) {
    final small = R.isSmall(context);
    final codeSize = small ? 10.0 : 12.0;

    TextStyle base() => AppText.mono(
      size: codeSize,
      color: const Color(0xFFD4E4F4),
      height: 2.2,
    );
    TextSpan tint(String text, Color color) => TextSpan(
      text: text,
      style: TextStyle(color: color),
    );

    const purple = Color(0xFFC69AFF);
    const cyan = Color(0xFF63E5F6);
    const green = Color(0xFFA3E6B4);
    const blue = Color(0xFF7BA8FF);

    Widget line(String no, List<InlineSpan> spans, {Widget? trailing}) {
      return Row(
        children: [
          SizedBox(
            width: small ? 26 : 32,
            child: Text(
              no,
              style: AppText.mono(
                size: codeSize,
                color: const Color(0xFF4C667E),
                height: 2.2,
              ),
            ),
          ),
          Text.rich(TextSpan(style: base(), children: spans)),
          ?trailing,
        ],
      );
    }

    return Transform.rotate(
      angle: -3 * math.pi / 180,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 410),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF10253B), Color(0xFF091725)],
            ),
            border: Border.all(color: const Color(0x3870ACCD)),
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color(0x66000000),
                blurRadius: 60,
                offset: Offset(0, 30),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 13,
                ),
                decoration: const BoxDecoration(
                  color: Color(0x06FFFFFF),
                  border: Border(bottom: BorderSide(color: AppColors.line)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        _WindowDot(Color(0xFFFF6E78)),
                        SizedBox(width: 5),
                        _WindowDot(Color(0xFFFFC65C)),
                        SizedBox(width: 5),
                        _WindowDot(Color(0xFF4DD9A3)),
                      ],
                    ),
                    Text(
                      'developer.py',
                      style: AppText.body(
                        size: 10,
                        color: const Color(0xFF7892A9),
                      ),
                    ),
                    const Icon(
                      Icons.lock_outline,
                      size: 11,
                      color: AppColors.cyan,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  small ? 12 : 18,
                  small ? 18 : 27,
                  18,
                  small ? 18 : 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    line('01', [
                      tint('class', purple),
                      const TextSpan(text: ' '),
                      tint('Developer', cyan),
                      const TextSpan(text: ':'),
                    ]),
                    line('02', [
                      const TextSpan(text: '  name = '),
                      tint('"Ikram Yasin"', green),
                    ]),
                    line('03', [const TextSpan(text: '  focus = [')]),
                    line('04', [
                      const TextSpan(text: '    '),
                      tint('"Flutter"', green),
                      const TextSpan(text: ','),
                    ]),
                    line('05', [
                      const TextSpan(text: '    '),
                      tint('"Python"', green),
                      const TextSpan(text: ','),
                    ]),
                    line('06', [
                      const TextSpan(text: '    '),
                      tint('"AI / ML"', green),
                    ]),
                    line('07', [const TextSpan(text: '  ]')]),
                    line(
                      '08',
                      [
                        const TextSpan(text: '  learning = '),
                        tint('True', blue),
                      ],
                      trailing: Loop(
                        duration: const Duration(seconds: 1),
                        builder: (context, t) => Opacity(
                          opacity: t < 0.5 ? 1 : 0,
                          child: Text(
                            '▋',
                            style: AppText.mono(
                              size: codeSize,
                              color: AppColors.cyan,
                              height: 2.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 13,
                ),
                decoration: const BoxDecoration(
                  color: Color(0x06FFFFFF),
                  border: Border(top: BorderSide(color: AppColors.line)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const StatusDot(),
                        const SizedBox(width: 7),
                        Text(
                          'Always learning',
                          style: AppText.body(
                            size: 10,
                            color: const Color(0xFF7892A9),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'UTF-8   Python',
                      style: AppText.body(
                        size: 10,
                        color: const Color(0xFF7892A9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WindowDot extends StatelessWidget {
  const _WindowDot(this.color);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _ScrollCue extends StatelessWidget {
  const _ScrollCue({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 17,
              height: 28,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF557188)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Loop(
                duration: const Duration(milliseconds: 1500),
                builder: (context, t) {
                  final moving = t < 0.7;
                  final dy = moving ? 5 + 8 * (t / 0.7) : 5.0;
                  final opacity = moving
                      ? (1 - t / 0.7).clamp(0.0, 1.0).toDouble()
                      : 1.0;
                  return Stack(
                    children: [
                      Positioned(
                        top: dy,
                        left: 6,
                        child: Opacity(
                          opacity: opacity,
                          child: Container(
                            width: 2,
                            height: 5,
                            decoration: BoxDecoration(
                              color: AppColors.cyan,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'SCROLL TO EXPLORE',
              style: AppText.body(
                size: 9,
                color: const Color(0xFF60778C),
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
