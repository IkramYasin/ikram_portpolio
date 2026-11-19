import 'package:material_ui/material_ui.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'common.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionBlock(
      child: Column(
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
            children: [for (final group in kSkills) _SkillCard(group)],
          ),
          const SizedBox(height: 15),
          Text(
            'Skill list is editable. Add proficiency levels only when you can confidently support them with practical work.',
            style: AppText.body(size: 12, color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}
class _SkillCard extends StatelessWidget {
  const _SkillCard(this.group);

  final SkillGroup group;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: Padding(
        padding: EdgeInsets.all(R.isSmall(context) ? 20 : 23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 37,
              height: 37,
              decoration: BoxDecoration(
                color: AppColors.cyan.o(.09),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(group.icon, size: 18, color: AppColors.cyan),
            ),
            const SizedBox(height: 17),
            Text(group.title, style: AppText.display(size: 16)),
            const SizedBox(height: 14),
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: [for (final tag in group.tags) TagChip(tag)],
            ),
          ],
        ),
      ),
    );
  }
}
