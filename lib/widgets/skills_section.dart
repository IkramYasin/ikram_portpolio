import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ikram_portpolio/models/portfolio_data.dart';
import 'package:ikram_portpolio/services/portfolio_store.dart';
import '../theme/app_theme.dart';
import 'common.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionBlock(
      child: Consumer<PortfolioStore>(
        builder: (context, store, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading(
                label: '02 / TOOLKIT',
                title: 'Technologies I',
                accent: 'work with.',
                subtitle: 'A growing toolkit for designing, developing and improving digital products.',
              ),
              const SizedBox(height: 35),
              ResponsiveGrid(
                columns: R.gridColumns(context),
                children: [for (final skill in store.portfolioData.skills) _SkillCard(skill)],
              ),
              const SizedBox(height: 15),
              Text(
                'Skill list is editable. Add proficiency levels only when you can confidently support them with practical work.',
                style: AppText.body(size: 12, color: AppColors.muted),
              ),
            ],
          );
        },
      ),
    );
  }
}
class _SkillCard extends StatelessWidget {
  const _SkillCard(this.skill);

  final Skill skill;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: Padding(
        padding: EdgeInsets.all(R.isSmall(context) ? 20 : 23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(skill.name, style: AppText.display(size: 16)),
            const SizedBox(height: 14),
            LinearProgressIndicator(
              value: skill.level,
              backgroundColor: AppColors.cyan.o(.1),
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.cyan),
            ),
          ],
        ),
      ),
    );
  }
}