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

class _TimelineItem extends StatefulWidget {
  const _TimelineItem(this.entry);

  final TimelineEntry entry;

  @override
  State<_TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<_TimelineItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final entry = widget.entry;
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
                  if (entry.tag == 'TRAINING') ...[
                    const SizedBox(height: 14),
                    _TrainingList(expanded: _expanded),
                  ],
                  if (entry.tag == 'CERTIFICATES') ...[
                    const SizedBox(height: 14),
                    _CertificateList(expanded: _expanded),
                  ],
                  if (entry.tag == 'TRAINING' ||
                      entry.tag == 'CERTIFICATES') ...[
                    const SizedBox(height: 10),
                    HoverLink(
                      label: _expanded ? 'Show less' : 'View all',
                      size: 11,
                      color: AppColors.cyan,
                      onTap: () => setState(() => _expanded = !_expanded),
                      arrow: true,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrainingList extends StatelessWidget {
  const _TrainingList({required this.expanded});

  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final records = expanded ? kTraining : kTraining.take(3).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final record in records)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${record.provider} · ${record.title}',
                  style: AppText.body(
                    size: 12,
                    weight: FontWeight.w600,
                    color: const Color(0xFFC4D6E5),
                  ),
                ),
                const SizedBox(height: 5),
                Wrap(
                  spacing: 14,
                  runSpacing: 4,
                  children: [
                    HoverLink(
                      label: 'Course',
                      size: 10,
                      color: AppColors.cyan,
                      onTap: () => openUrl(record.courseUrl),
                    ),
                    HoverLink(
                      label: 'Certificate',
                      size: 10,
                      color: AppColors.cyan,
                      onTap: () => openUrl(record.certificateUrl),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _CertificateList extends StatelessWidget {
  const _CertificateList({required this.expanded});

  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final records = expanded ? kCertificates : kCertificates.take(3).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final record in records)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${record.title} · ${record.provider}',
                  style: AppText.body(
                    size: 12,
                    weight: FontWeight.w600,
                    color: const Color(0xFFC4D6E5),
                  ),
                ),
                const SizedBox(height: 5),
                Wrap(
                  spacing: 14,
                  runSpacing: 4,
                  children: [
                    HoverLink(
                      label: 'Course',
                      size: 10,
                      color: AppColors.cyan,
                      onTap: () => openUrl(record.courseUrl),
                    ),
                    HoverLink(
                      label: 'Verify',
                      size: 10,
                      color: AppColors.cyan,
                      onTap: () => openUrl(record.verificationUrl),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
