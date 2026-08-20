import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'pressable_scale.dart';
import '../../core/theme/app_icons.dart';

/// Taille du titre d'en-tête.
enum PageHeaderVariant {
  /// 30 px — début de flux : inscription, étapes d'onboarding.
  hero,

  /// 24 px — page principale : dashboard, écrans de détail.
  primary,

  /// 20 px — page standard.
  standard,
}

/// Action affichée à gauche du titre.
enum HeaderLeadingAction { none, back, close }

/// Action affichée à droite du titre.
class HeaderAction {
  const HeaderAction({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;

  /// Libellé lu par les lecteurs d'écran.
  final String label;

  final VoidCallback onPressed;
}

/// En-tête de page — titre et actions contextuelles.
///
/// Design System `components/page-header.component.md`.
class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.title,
    this.variant = PageHeaderVariant.standard,
    this.leading = HeaderLeadingAction.none,
    this.action,
    this.onLeadingPressed,
    this.titleAlign,
  });

  final String title;
  final PageHeaderVariant variant;
  final HeaderLeadingAction leading;
  final HeaderAction? action;

  /// Par défaut, revient à l'écran précédent.
  final VoidCallback? onLeadingPressed;

  final TextAlign? titleAlign;

  TextStyle get _titleStyle => switch (variant) {
        PageHeaderVariant.hero => AppTypography.headingXl,
        PageHeaderVariant.primary => AppTypography.headingLg,
        PageHeaderVariant.standard => AppTypography.headingMd,
      };

  TextAlign get _align =>
      titleAlign ??
      (variant == PageHeaderVariant.hero ? TextAlign.center : TextAlign.left);

  @override
  Widget build(BuildContext context) {
    const slotWidth = AppSizes.minTouchTarget;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingPage,
        AppSpacing.md,
        AppSizes.paddingPage,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          // Action gauche
          SizedBox(
            width: slotWidth,
            child: leading == HeaderLeadingAction.none
                ? null
                : PressableScale(
                    onTap: onLeadingPressed ?? () => Navigator.maybePop(context),
                    semanticLabel: leading == HeaderLeadingAction.close
                        ? 'Fermer'
                        : 'Retour',
                    child: SizedBox(
                      width: slotWidth,
                      height: slotWidth,
                      child: Icon(
                        leading == HeaderLeadingAction.close
                            ? AppIcons.close
                            : AppIcons.chevronLeft,
                        size: 26,
                        color: AppColors.onSurface,
                      ),
                    ),
                  ),
          ),

          // Titre
          Expanded(
            child: Semantics(
              header: true,
              child: Text(
                title,
                style: _titleStyle,
                textAlign: _align,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          // Action droite
          SizedBox(
            width: slotWidth,
            child: action == null
                ? null
                : Align(
                    alignment: Alignment.centerRight,
                    child: PressableScale(
                      onTap: action!.onPressed,
                      semanticLabel: action!.label,
                      child: SizedBox(
                        width: slotWidth,
                        height: slotWidth,
                        child: Icon(
                          action!.icon,
                          size: 24,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
