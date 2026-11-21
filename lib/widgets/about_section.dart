import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ikram_portpolio/services/portfolio_store.dart';
import '../theme/app_theme.dart';
import 'common.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.onNav});

  final void Function(int index) onNav;

  @override
  Widget build(BuildContext context) {
    final mobile = R.isMobile(context);
    final small = R.isSmall(context);

    return Consumer<PortfolioStore>(
      builder: (context, store, child) {
        final main = Panel(
          padding: EdgeInsets.all(small ? 23 : 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                store.portfolioData.about.summary,
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
                  children: [main, const SizedBox(height: 18)],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 135, child: main),
                    const SizedBox(width: 18),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}