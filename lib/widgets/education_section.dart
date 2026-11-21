import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ikram_portpolio/services/portfolio_store.dart';
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
              children: [
                _TrainingList(expanded: true),
                _CertificateList(expanded: true),
              ],
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
    return Consumer<PortfolioStore>(
      builder: (context, store, child) {
        final records = expanded ? store.portfolioData.training : store.portfolioData.training.take(3).toList();
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
                      '${record.institution} · ${record.name}',
                      style: AppText.body(
                        size: 12,
                        weight: FontWeight.w600,
                        color: const Color(0xFFC4D6E5),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

class _CertificateList extends StatelessWidget {
  const _CertificateList({required this.expanded});

  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return Consumer<PortfolioStore>(
      builder: (context, store, child) {
        final records = expanded ? store.portfolioData.certificates : store.portfolioData.certificates.take(3).toList();
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
                      '${record.name} · ${record.institution}',
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
                          label: 'Verify',
                          size: 10,
                          color: AppColors.cyan,
                          onTap: () => openUrl(record.url),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}