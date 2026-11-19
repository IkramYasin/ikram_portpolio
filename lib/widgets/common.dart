import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_theme.dart';

/// Responsive helpers (same breakpoints as the original CSS: 900 / 700 / 480).
class R {
  R._();

  static double width(BuildContext c) => MediaQuery.sizeOf(c).width;
  static bool isMobile(BuildContext c) => width(c) <= 700;
  static bool isSmall(BuildContext c) => width(c) <= 480;
  static bool isTablet(BuildContext c) => width(c) <= 900;
  static int gridColumns(BuildContext c) =>
      isSmall(c) ? 1 : (isTablet(c) ? 2 : 3);
  static double pad(BuildContext c) => isSmall(c) ? 17 : 24;
  static double headerHeight(BuildContext c) => isMobile(c) ? 70 : 82;
}

Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);
  await launchUrl(
    uri,
    webOnlyWindowName: url.startsWith('mailto:') ? '_self' : '_blank',
  );
}

/// Centers content and limits its width, like `.section-wrap`.
class SectionWrap extends StatelessWidget {
  const SectionWrap({super.key, required this.child, this.maxWidth = 1120});

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: R.pad(context)),
          child: child,
        ),
      ),
    );
  }
}

/// A wrapped section with the vertical spacing of `.section-block`.
class SectionBlock extends StatelessWidget {
  const SectionBlock({super.key, required this.child, this.bottom = 20});

  final Widget child;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    return SectionWrap(
      child: Padding(
        padding: EdgeInsets.only(
          top: R.isMobile(context) ? 70 : 95,
          bottom: bottom,
        ),
        child: child,
      ),
    );
  }
}

BoxDecoration panelDecoration({Color? border}) {
  return BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.panelA, AppColors.panelB],
    ),
    border: Border.all(color: border ?? AppColors.line),
    borderRadius: BorderRadius.circular(13),
  );
}

class Panel extends StatelessWidget {
  const Panel({super.key, required this.child, this.padding = EdgeInsets.zero});

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: panelDecoration(),
      child: child,
    );
  }
}

/// Panel that lifts and gets a cyan border on hover.
class HoverCard extends StatefulWidget {
  const HoverCard({super.key, required this.child});

  final Widget child;

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _hover ? -4 : 0, 0),
        clipBehavior: Clip.antiAlias,
        decoration: panelDecoration(
          border: _hover ? AppColors.cyan.o(.4) : AppColors.line,
        ),
        child: widget.child,
      ),
    );
  }
}

/// Lays children out in rows of equal-height cards.
class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    super.key,
    required this.children,
    required this.columns,
    this.gap = 14,
  });

  final List<Widget> children;
  final int columns;
  final double gap;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < children.length; i += columns) {
      final slice = children.sublist(i, math.min(i + columns, children.length));
      final cells = <Widget>[];
      for (var j = 0; j < columns; j++) {
        if (j > 0) cells.add(SizedBox(width: gap));
        cells.add(
          Expanded(
            child: j < slice.length ? slice[j] : const SizedBox.shrink(),
          ),
        );
      }
      if (rows.isNotEmpty) rows.add(SizedBox(height: gap));
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: cells,
          ),
        ),
      );
    }
    return Column(children: rows);
  }
}

class GradientText extends StatelessWidget {
  const GradientText(this.text, {super.key, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (rect) => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [AppColors.cyan, AppColors.gradientEnd],
      ).createShader(rect),
      child: Text(text, style: style.copyWith(color: Colors.white)),
    );
  }
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.label,
    required this.title,
    required this.accent,
    this.subtitle,
  });

  final String label;
  final String title;
  final String accent;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final size = (R.width(context) * 0.04).clamp(30.0, 43.0).toDouble();
    final style = AppText.display(
      size: size,
      weight: FontWeight.w600,
      height: 1.2,
      letterSpacing: -size * 0.042,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppText.body(
            size: 10,
            weight: FontWeight.w700,
            color: AppColors.cyan,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 13),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: '$title '),
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: GradientText(accent, style: style),
              ),
            ],
          ),
          style: style,
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: Text(
                subtitle!,
                style: AppText.body(
                  size: 14,
                  color: AppColors.muted,
                  height: 1.65,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Re-runs [builder] every animation frame with t in 0..1, repeating forever.
class Loop extends StatefulWidget {
  const Loop({super.key, required this.duration, required this.builder});

  final Duration duration;
  final Widget Function(BuildContext context, double t) builder;

  @override
  State<Loop> createState() => _LoopState();
}

class _LoopState extends State<Loop> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => widget.builder(context, _controller.value),
    );
  }
}

class TagChip extends StatelessWidget {
  const TagChip(this.label, {super.key, this.size = 10});

  final String label;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0x05FFFFFF),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.line),
      ),
      child: Text(
        label,
        style: AppText.body(size: size, color: AppColors.tagText),
      ),
    );
  }
}

class StatusDot extends StatelessWidget {
  const StatusDot({super.key, this.size = 7});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.green,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: AppColors.green.o(.65), blurRadius: 10)],
      ),
    );
  }
}

class Brand extends StatelessWidget {
  const Brand({
    super.key,
    required this.onTap,
    this.size = 21,
    this.markSize = 34,
  });

  final VoidCallback onTap;
  final double size;
  final double markSize;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: markSize,
              height: markSize,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.cyan.o(.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.cyan.o(.55)),
              ),
              child: Text(
                'IY',
                style: AppText.display(
                  size: 12,
                  weight: FontWeight.w700,
                  color: AppColors.cyan,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text.rich(
              const TextSpan(
                text: 'ikram',
                children: [
                  TextSpan(
                    text: '.',
                    style: TextStyle(color: AppColors.cyan),
                  ),
                ],
              ),
              style: AppText.display(
                size: size,
                weight: FontWeight.w700,
                letterSpacing: -0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HoverLink extends StatefulWidget {
  const HoverLink({
    super.key,
    required this.label,
    required this.onTap,
    this.size = 12,
    this.color = AppColors.muted,
    this.hoverColor = AppColors.cyan,
    this.arrow = true,
    this.weight = FontWeight.w400,
  });

  final String label;
  final VoidCallback onTap;
  final double size;
  final Color color;
  final Color hoverColor;
  final bool arrow;
  final FontWeight weight;

  @override
  State<HoverLink> createState() => _HoverLinkState();
}

class _HoverLinkState extends State<HoverLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final color = _hover ? widget.hoverColor : widget.color;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: AppText.body(
                size: widget.size,
                color: color,
                weight: widget.weight,
              ),
            ),
            if (widget.arrow) ...[
              const SizedBox(width: 6),
              Icon(Icons.north_east, size: widget.size, color: color),
            ],
          ],
        ),
      ),
    );
  }
}

class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.primary = true,
    this.arrow = true,
    this.fullWidth = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool primary;
  final bool arrow;
  final bool fullWidth;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final fg = widget.primary ? const Color(0xFF04111C) : AppColors.text;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hover ? -3 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 13),
          decoration: BoxDecoration(
            color: widget.primary ? AppColors.cyan : null,
            borderRadius: BorderRadius.circular(8),
            border: widget.primary
                ? null
                : Border.all(color: _hover ? AppColors.cyan : AppColors.line),
            boxShadow: widget.primary
                ? [
                    BoxShadow(
                      color: AppColors.cyan.o(.15),
                      blurRadius: 30,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: widget.fullWidth
                ? MainAxisSize.max
                : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  widget.label,
                  style: AppText.body(
                    size: 13,
                    weight: FontWeight.w700,
                    color: fg,
                  ),
                ),
              ),
              if (widget.arrow) ...[
                const SizedBox(width: 14),
                Icon(Icons.north_east, size: 14, color: fg),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
