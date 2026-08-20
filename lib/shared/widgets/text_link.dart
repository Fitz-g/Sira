import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_motion.dart';
import '../../core/theme/app_typography.dart';

/// Lien texte — action tertiaire, volontairement discrète.
///
/// Reste en gris neutre : il ne doit jamais concurrencer le CTA principal.
/// Design System `components/secondary-actions.component.md`.
class TextLink extends StatefulWidget {
  const TextLink({
    super.key,
    required this.label,
    required this.onPressed,
    this.align = TextAlign.center,
  });

  final String label;
  final VoidCallback onPressed;
  final TextAlign align;

  @override
  State<TextLink> createState() => _TextLinkState();
}

class _TextLinkState extends State<TextLink> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      link: true,
      label: widget.label,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onPressed,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          // Garantit une zone tactile confortable (NFR-A1).
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: AnimatedDefaultTextStyle(
            duration: AppMotion.pressDuration,
            style: AppTypography.headingXxs.copyWith(
              color: AppColors.neutral500,
              decoration:
                  _isPressed ? TextDecoration.underline : TextDecoration.none,
              decorationColor: AppColors.neutral500,
            ),
            child: Text(widget.label, textAlign: widget.align),
          ),
        ),
      ),
    );
  }
}
