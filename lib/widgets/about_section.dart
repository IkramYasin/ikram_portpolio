import 'package:material_ui/material_ui.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'common.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.onNav});

  final void Function(int index) onNav;

  @override
  Widget build(BuildContext context) {
    final mobile = R.isMobile(context);
    final small = R.isSmall(context);

    final main = Panel(
      padding: EdgeInsets.all(small ? 23 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: "I'm a Computer Science student at the "),
                TextSpan(
                  text: 'University of Turbat',
                  style: TextStyle(color: AppColors.cyan),
                ),
                const TextSpan(
                  text: ', passionate about turning ideas into useful digital products.',
                ),
              ],
            ),
            style: AppText.display(
              size: small ? 19 : 22,
              weight: FontWeight.w500,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 19),
          Text(
            'My current focus is mobile application development with Flutter and Dart, alongside Python programming and web technologies. I enjoy learning by building projects, solving problems, and exploring how technology can make everyday tasks easier.',
            style: AppText.body(size: 14, color: AppColors.muted, height: 1.65),
          ),
          const SizedBox(height: 13),
          Text(
            "I'm also growing my knowledge of Artificial Intelligence and Machine Learning, with the goal of combining intelligent systems with practical software.",
            style: AppText.body(size: 14, color: AppColors.muted, height: 1.65),
          ),
          const SizedBox(height: 26),
          HoverLink(
            label: "Let's connect",
            size: 13,
            color: AppColors.cyan,
            hoverColor: AppColors.text,
            onTap: () => onNav(5),
          ),
        ],
      ),
    );

    final stats = Column(
      children: [
        for (var i = 0; i < kStats.length; i += 2) ...[
          if (i > 0) SizedBox(height: small ? 9 : 13),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _StatCard(kStats[i])),
                SizedBox(width: small ? 9 : 13),
                Expanded(child: _StatCard(kStats[i + 1])),
              ],
            ),
          ),
        ],
      ],
    );

    return SectionBlock(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            label: '01 / ABOUT ME',
            title: 'A little about',
            accent: 'my journey.',
          ),
          const SizedBox(height: 35),
          if (mobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [main, const SizedBox(height: 18), stats],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 135, child: main),
                const SizedBox(width: 18),
                Expanded(flex: 85, child: stats),
              ],
            ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard(this.stat);

  final Stat stat;

  @override
  Widget build(BuildContext context) {
    final small = R.isSmall(context);
    return Panel(
      padding: EdgeInsets.all(small ? 15 : 20),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: small ? 60 : 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stat.value,
              style: AppText.display(size: 21, color: AppColors.cyan),
            ),
            const SizedBox(height: 4),
            Text(
              stat.label,
              style: AppText.body(size: 11, color: AppColors.muted),
            ),
          ],
        ),
      ),
    );
  }
}
