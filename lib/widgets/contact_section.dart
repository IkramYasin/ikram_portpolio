import 'package:material_ui/material_ui.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'common.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = R.isMobile(context);
    final small = R.isSmall(context);

    const heading = SectionHeading(
      label: '05 / CONTACT',
      title: "Have an idea? Let's",
      accent: 'build it.',
      subtitle: "I'm interested in learning opportunities, collaboration and meaningful projects. Feel free to reach out.",
    );

    Widget email({bool full = false}) => AppButton(
      label: 'Send an email',
      fullWidth: full,
      onTap: () => openUrl('mailto:$kEmail'),
    );
    Widget linkedin({bool full = false}) => AppButton(
      label: 'Connect on LinkedIn',
      primary: false,
      fullWidth: full,
      onTap: () => openUrl(kLinkedin),
    );

    final Widget panelChild;
    if (!mobile) {
      panelChild = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: heading),
          const SizedBox(width: 30),
          IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                email(full: true),
                const SizedBox(height: 12),
                linkedin(full: true),
              ],
            ),
          ),
        ],
      );
    } else if (small) {
      panelChild = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          heading,
          const SizedBox(height: 30),
          email(full: true),
          const SizedBox(height: 12),
          linkedin(full: true),
        ],
      );
    } else {
      panelChild = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading,
          const SizedBox(height: 30),
          Wrap(spacing: 12, runSpacing: 12, children: [email(), linkedin()]),
        ],
      );
    }

    return SectionBlock(
      bottom: 100,
      child: Container(
        padding: EdgeInsets.all(mobile ? 27 : 38),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF10243B), Color(0xFF0A192A)],
          ),
          border: Border.all(color: AppColors.line),
          borderRadius: BorderRadius.circular(13),
        ),
        child: panelChild,
      ),
    );
  }
}
