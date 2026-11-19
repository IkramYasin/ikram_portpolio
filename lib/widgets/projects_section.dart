import 'package:material_ui/material_ui.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'common.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key, required this.onNav});

  final void Function(int index) onNav;

  @override
  Widget build(BuildContext context) {
    final small = R.isSmall(context);
    final count = Text(
      '${kProjects.length.toString().padLeft(2, '0')} PROJECTS',
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
              for (var i = 0; i < kProjects.length; i++)
                _ProjectCard(project: kProjects[i], index: i, onNav: onNav),
            ],
          ),
        ],
      ),
    );
  }
}

const List<List<Color>> _artColors = [
  [Color(0xFF174B65), Color(0xFF0D2036)],
  [Color(0xFF253E75), Color(0xFF111B35)],
  [Color(0xFF28564E), Color(0xFF102B2B)],
];

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
    final colors = _artColors[index % _artColors.length];
    final hasLink = project.link.isNotEmpty;

    return HoverCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 155,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 0.9,
                colors: colors,
                stops: const [0, 0.7],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                _Ring(size: 190, color: AppColors.cyan.o(.2)),
                _Ring(size: 130, color: AppColors.purple.o(.28)),
                Text(
                  project.symbol,
                  style:
                      AppText.display(
                        size: 46,
                        color: const Color(0xFFA5F4FF),
                      ).copyWith(
                        shadows: const [
                          Shadow(color: Color(0x8800D9F5), blurRadius: 25),
                        ],
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.category,
                  style: AppText.body(
                    size: 9,
                    weight: FontWeight.w700,
                    color: AppColors.cyan,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(project.title, style: AppText.display(size: 19)),
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
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final t in project.technologies) TagChip(t, size: 9),
                  ],
                ),
                const SizedBox(height: 15),
                HoverLink(
                  label: hasLink ? 'View source' : 'Details coming soon',
                  size: 11,
                  color: AppColors.cyan,
                  hoverColor: AppColors.text,
                  onTap: () => hasLink ? openUrl(project.link) : onNav(5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Ring extends StatelessWidget {
  const _Ring({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      maxWidth: size,
      maxHeight: size,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color),
        ),
      ),
    );
  }
}
