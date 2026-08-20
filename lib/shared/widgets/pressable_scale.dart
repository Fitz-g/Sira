import 'package:flutter/material.dart';
import '../../core/theme/app_motion.dart';

/// Enveloppe un widget d'un feedback tactile cohérent :
/// réduction d'échelle et d'opacité pendant l'appui.
///
/// Design System `tokens/interactions.md` — `press-feedback`.
class PressableScale extends StatefulWidget {
  const PressableScale({
    super.key,
    required this.child,
    this.onTap,
    this.enabled = true,
    this.semanticLabel,
    this.isButton = true,
  });

  final Widget child;
  final VoidCallback? onTap;
  final bool enabled;
  final String? semanticLabel;
  final bool isButton;

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppMotion.pressDuration,
  );

  late final Animation<double> _scale = Tween<double>(
    begin: 1,
    end: AppMotion.pressScale,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

  late final Animation<double> _opacity = Tween<double>(
    begin: 1,
    end: AppMotion.pressOpacity,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

  bool get _isInteractive => widget.enabled && widget.onTap != null;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    if (_isInteractive) _controller.forward();
  }

  void _onTapUp(TapUpDetails _) {
    if (_isInteractive) _controller.reverse();
  }

  void _onTapCancel() {
    if (_isInteractive) _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: widget.isButton,
      enabled: widget.enabled,
      label: widget.semanticLabel,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: _isInteractive ? widget.onTap : null,
        behavior: HitTestBehavior.opaque,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Opacity(
            opacity: widget.enabled
                ? _opacity.value
                : AppMotion.disabledOpacity,
            child: Transform.scale(scale: _scale.value, child: child),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
