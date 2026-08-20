import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/currency.dart';
import '../../core/theme/app_icons.dart';

enum AppInputVariant { text, email, password, number }

/// Champ de saisie — quatre variantes, cinq états visuels.
///
/// États : repos, focus, rempli, erreur, valide.
/// Design System `components/input.component.md`.
class AppInput extends StatefulWidget {
  const AppInput({
    super.key,
    required this.label,
    required this.controller,
    this.variant = AppInputVariant.text,
    this.hint,
    this.errorText,
    this.isValid = false,
    this.optional = false,
    this.maxLength,
    this.autofocus = false,
    this.onChanged,
    this.onEditingComplete,
    this.textInputAction,
  });

  final String label;
  final TextEditingController controller;
  final AppInputVariant variant;
  final String? hint;

  /// Non nul ⇒ le champ passe en état erreur et affiche ce message.
  final String? errorText;

  /// Affiche une bordure verte et une coche de confirmation.
  final bool isValid;

  /// Ajoute « (optionnel) » au label.
  final bool optional;

  final int? maxLength;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  final _focusNode = FocusNode();
  bool _isFocused = false;
  bool _obscure = true;

  bool get _hasError => widget.errorText != null;
  bool get _isNumber => widget.variant == AppInputVariant.number;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Color get _borderColor {
    if (_hasError) return AppColors.error;
    if (widget.isValid) return AppColors.success;
    if (_isFocused) return AppColors.primary;
    return AppColors.border;
  }

  double get _borderWidth =>
      _hasError || widget.isValid || _isFocused ? 2 : 1;

  TextInputType get _keyboardType => switch (widget.variant) {
        AppInputVariant.email => TextInputType.emailAddress,
        AppInputVariant.number => TextInputType.number,
        _ => TextInputType.text,
      };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text.rich(
          TextSpan(
            text: widget.label,
            style: AppTypography.headingXxs.copyWith(
              color: AppColors.neutral700,
              fontWeight: FontWeight.w500,
            ),
            children: [
              if (widget.optional)
                TextSpan(
                  text: ' (optionnel)',
                  style: AppTypography.headingXxs.copyWith(
                    color: AppColors.neutral500,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Champ
        Container(
          height: AppSizes.inputHeight,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.neutral100,
            borderRadius: BorderRadius.circular(AppSizes.radiusInput),
            border: Border.all(color: _borderColor, width: _borderWidth),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  autofocus: widget.autofocus,
                  keyboardType: _keyboardType,
                  textInputAction: widget.textInputAction,
                  obscureText:
                      widget.variant == AppInputVariant.password && _obscure,
                  autocorrect: widget.variant == AppInputVariant.text,
                  enableSuggestions: widget.variant == AppInputVariant.text,
                  textCapitalization: widget.variant == AppInputVariant.text
                      ? TextCapitalization.sentences
                      : TextCapitalization.none,
                  maxLength: widget.maxLength,
                  inputFormatters: _isNumber
                      ? [
                          FilteringTextInputFormatter.digitsOnly,
                          _ThousandsSeparatorFormatter(),
                        ]
                      : null,
                  onChanged: widget.onChanged,
                  onEditingComplete: widget.onEditingComplete,
                  style: AppTypography.headingXs,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    counterText: '',
                    hintText: widget.hint,
                    hintStyle: AppTypography.headingXs.copyWith(
                      color: AppColors.neutral500,
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),

              // Suffixe devise
              if (_isNumber && widget.controller.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    'FCFA',
                    style: AppTypography.headingXxs.copyWith(
                      color: AppColors.neutral500,
                    ),
                  ),
                ),

              // Bascule de visibilité du mot de passe
              if (widget.variant == AppInputVariant.password)
                GestureDetector(
                  onTap: () => setState(() => _obscure = !_obscure),
                  behavior: HitTestBehavior.opaque,
                  child: Semantics(
                    button: true,
                    label: _obscure
                        ? 'Afficher le mot de passe'
                        : 'Masquer le mot de passe',
                    child: Icon(
                      _obscure
                          ? AppIcons.eye
                          : AppIcons.eyeOff,
                      size: 20,
                      color: AppColors.neutral500,
                    ),
                  ),
                ),

              // Confirmation de validité
              if (widget.isValid && !_hasError)
                const Icon(
                  AppIcons.circleCheck,
                  size: 20,
                  color: AppColors.success,
                ),
            ],
          ),
        ),

        // Message d'erreur
        if (_hasError) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            widget.errorText!,
            style: AppTypography.headingXxs.copyWith(color: AppColors.error),
          ),
        ],
      ],
    );
  }
}

/// Insère les séparateurs de milliers pendant la frappe, en conservant
/// la position du curseur en fin de saisie.
class _ThousandsSeparatorFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    final value = Currency.parse(newValue.text);
    if (value == 0) return const TextEditingValue();

    final formatted = Currency.formatAmount(value);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
