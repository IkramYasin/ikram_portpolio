import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ikram_portpolio/models/portfolio_data.dart';
import 'package:ikram_portpolio/services/portfolio_store.dart';
import 'package:ikram_portpolio/theme/app_theme.dart';
import 'package:ikram_portpolio/widgets/common.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key, required this.onNav});

  final void Function(int index) onNav;

  @override
  Widget build(BuildContext context) {
    final small = R.isSmall(context);
    return Consumer<PortfolioStore>(
      builder: (context, store, child) {
        final count = Text(
          '${store.portfolioData.projects.length.toString().padLeft(2, '0')} PROJECTS',
          style: AppText.body(size: 10, color: AppColors.muted, letterSpacing: 1.5),
        );
        const heading = SectionHeading(
          label: '03 / SELECTED WORK',
          title: 'Projects that bring ideas',
          accent: 'to life.',
          subtitle: 'A selection of university, personal and learning projects.',
        );

        return SectionBlock(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (small) ...[
                heading,
                const SizedBox(height: 10),
                count,
              ] else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(child: heading),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: count,
                    ),
                  ],
                ),
              const SizedBox(height: 35),
              ResponsiveGrid(
                columns: R.gridColumns(context),
                gap: 16,
                children: [
                  for (var i = 0; i < store.portfolioData.projects.length; i++)
                    _ProjectCard(project: store.portfolioData.projects[i], index: i, onNav: onNav),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.project,
    required this.index,
    required this.onNav,
  });

  final Project project;
  final int index;
  final void Function(int index) onNav;

  @override
  Widget build(BuildContext context) {
    final hasLink = project.url.isNotEmpty;

    return HoverCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(project.name, style: AppText.display(size: 19)),
                const SizedBox(height: 8),
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 60),
                  child: Text(
                    project.description,
                    style: AppText.body(
                      size: 12,
                      color: AppColors.muted,
                      height: 1.65,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                HoverLink(
                  label: hasLink ? 'View source' : 'Details coming soon',
                  size: 11,
                  color: AppColors.cyan,
                  hoverColor: AppColors.text,
                  onTap: () => hasLink ? openUrl(project.url) : onNav(5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}