import 'dart:async';

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_motion.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_icons.dart';

enum ToastType { success, error, info }

/// Confirmation légère et non bloquante.
///
/// Apparaît en bas de l'écran, disparaît seule après 2 secondes.
/// Design System `components/toast.component.md`.
///
/// ```dart
/// AppToast.show(context, 'Dépense ajoutée');
/// ```
abstract final class AppToast {
  static OverlayEntry? _current;

  static void show(
    BuildContext context,
    String message, {
    ToastType type = ToastType.success,
    Duration duration = AppMotion.toastDuration,
  }) {
    // Un seul toast à la fois : le nouveau remplace le précédent.
    _dismiss();

    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) => _ToastView(
        message: message,
        type: type,
        duration: duration,
        onDismissed: _dismiss,
      ),
    );

    _current = entry;
    overlay.insert(entry);
  }

  static void _dismiss() {
    _current?.remove();
    _current = null;
  }
}

class _ToastView extends StatefulWidget {
  const _ToastView({
    required this.message,
    required this.type,
    required this.duration,
    required this.onDismissed,
  });

  final String message;
  final ToastType type;
  final Duration duration;
  final VoidCallback onDismissed;

  @override
  State<_ToastView> createState() => _ToastViewState();
}

class _ToastViewState extends State<_ToastView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppMotion.toastTransition,
  );

  late final Animation<double> _fade = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  );

  late final Animation<Offset> _slide = Tween<Offset>(
    begin: const Offset(0, 0.6),
    end: Offset.zero,
  ).animate(_fade);

  /// Retenu pour être annulé : un minuteur qui survit à son widget se
  /// déclenche dans le vide, et fait échouer les tests qui l'attrapent.
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller.forward();
    _timer = Timer(widget.duration, _dismiss);
  }

  Future<void> _dismiss() async {
    if (!mounted) return;
    await _controller.reverse();
    if (!mounted) return;
    widget.onDismissed();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  ({Color background, Color accent, IconData icon}) get _style =>
      switch (widget.type) {
        ToastType.success => (
            background: AppColors.primaryLight,
            accent: AppColors.primary,
            icon: AppIcons.circleCheck,
          ),
        ToastType.error => (
            background: const Color(0xFFFEF2F2),
            accent: AppColors.error,
            icon: AppIcons.circleX,
          ),
        ToastType.info => (
            background: AppColors.primaryLight,
            accent: AppColors.primary,
            icon: AppIcons.info,
          ),
      };

  @override
  Widget build(BuildContext context) {
    final style = _style;
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Positioned(
      left: AppSizes.paddingPage,
      right: AppSizes.paddingPage,
      bottom: bottomInset + AppSpacing.lg,
      child: SlideTransition(
        position: _slide,
        child: FadeTransition(
          opacity: _fade,
          child: Material(
            color: Colors.transparent,
            // Le liseré est un élément posé à l'intérieur, et non une bordure :
            // Flutter refuse une bordure aux côtés de couleurs différentes dès
            // qu'il y a des coins arrondis.
            child: Container(
              decoration: BoxDecoration(
                color: style.background,
                borderRadius: BorderRadius.circular(AppSizes.radiusInput),
                border: Border.all(
                  color: style.accent.withValues(alpha: 0.25),
                ),
                boxShadow: AppElevation.card,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusInput - 1),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(width: 4, child: ColoredBox(color: style.accent)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              Icon(style.icon, size: 20, color: style.accent),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  widget.message,
                                  style: AppTypography.headingXxs.copyWith(
                                    color: style.accent,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
