import 'package:material_ui/material_ui.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'common.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionBlock(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            label: '04 / LEARNING PATH',
            title: 'Education &',
            accent: 'certifications.',
          ),
          const SizedBox(height: 35),
          Container(
            margin: const EdgeInsets.only(left: 8),
            constraints: const BoxConstraints(maxWidth: 760),
            padding: const EdgeInsets.only(left: 30),
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: AppColors.cyan.o(.25))),
            ),
            child: Column(
              children: [for (final entry in kTimeline) _TimelineItem(entry)],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem(this.entry);

  final TimelineEntry entry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -36,
            top: 25,
            child: Container(
              width: 11,
              height: 11,
              decoration: BoxDecoration(
                color: AppColors.cyan,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.bg, width: 3),
                boxShadow: const [
                  BoxShadow(color: AppColors.cyan, spreadRadius: 1),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Panel(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.tag,
                    style: AppText.body(
                      size: 9,
                      weight: FontWeight.w700,
                      color: AppColors.cyan,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(entry.title, style: AppText.display(size: 18)),
                  const SizedBox(height: 6),
                  Text(
                    entry.subtitle,
                    style: AppText.body(
                      size: 12,
                      color: const Color(0xFFC4D6E5),
                      height: 1.65,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    entry.description,
                    style: AppText.body(
                      size: 12,
                      color: AppColors.muted,
                      height: 1.65,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
