import 'package:material_ui/material_ui.dart';

import '../theme/app_theme.dart';
import 'common.dart';

class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key, required this.onHome});

  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    final mobile = R.isMobile(context);
    final small = R.isSmall(context);
    final textStyle = AppText.body(
      size: small ? 10 : 11,
      color: AppColors.muted,
    );

    final brand = Brand(onTap: onHome, size: 17, markSize: 29);
    final tagline = Text(
      'Designed & built with curiosity by Ikram Yasin.',
      style: textStyle,
    );
    final copyright = Text(
      '© ${DateTime.now().year} Ikram Yasin',
      style: textStyle,
    );

    return SectionWrap(
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 25, 0, 32),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.line)),
        ),
        child: mobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [brand, copyright],
                  ),
                  const SizedBox(height: 15),
                  tagline,
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  brand,
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: tagline,
                    ),
                  ),
                  copyright,
                ],
              ),
      ),
    );
  }
}
