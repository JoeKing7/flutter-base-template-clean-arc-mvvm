import 'dart:ui';

import 'package:base_template/core/config/app_text_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:base_template/core/config/app_colors.dart';

final borderFocused = DecoratedInputBorder(
    child: OutlineInputBorder(
      borderSide: BorderSide(
          color: AppColors.primary(Theme.of(Get.context!).brightness)),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    shadow: BoxShadow(
        // color: AppColors.secondary(Theme.of(Get.context!).brightness),
        // blurRadius: 5,
        ));

final enabledBorder = DecoratedInputBorder(
    child: OutlineInputBorder(
      borderSide: BorderSide(
          color: AppColors.textFieldBorder(Theme.of(Get.context!).brightness)),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    shadow: BoxShadow(
        // color: AppColors.secondary(Theme.of(Get.context!).brightness),
        // blurRadius: 5,
        ));

final otpBorder = DecoratedInputBorder(
    child: OutlineInputBorder(
      borderSide: BorderSide(
          color: AppColors.textFieldBorder(Theme.of(Get.context!).brightness)),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    shadow: BoxShadow(
        // color: AppColors.secondary(Theme.of(Get.context!).brightness),
        // blurRadius: 5,
        ));

// OutlineInputBorder(
//     borderSide: BorderSide(color: AppColors.primary(Theme.of(context).brightness)),
//     borderRadius: BorderRadius.circular(50));

class AppTextFormField extends StatefulWidget {
  final bool? isNumericKeyboard;
  final TextEditingController textEditingController;
  final String? labelText;
  final String? Function(String?)? validator;
  final bool? enabled;
  final bool? readOnly;
  final Widget? suffixIcon;
  final Widget prefixIcon;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String hintText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final IconData? icon;
  final String? hint;
  final String? errorMessage;
  final bool? enableSuggestions;
  final bool? autocorrect;
  final TextCapitalization? textCapitalization;
  final FocusNode? focusNode;
  final Function(PointerDownEvent)? onTapOutside;
  final void Function()? onTap;

  const AppTextFormField({
    super.key,
    required this.textEditingController,
    required this.prefixIcon,
    required this.hintText,
    this.labelText,
    this.validator,
    this.suffixIcon,
    this.enabled = true,
    this.maxLength,
    this.readOnly = false,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction,
    this.minLines = 1,
    this.maxLines = 1,
    this.icon,
    this.hint,
    this.errorMessage,
    this.enableSuggestions = false,
    this.autocorrect = false,
    this.textCapitalization = TextCapitalization.words,
    this.isNumericKeyboard = false,
    this.focusNode,
    this.onTapOutside,
    this.onTap,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus && widget.validator != null) {
          setState(() {
            _errorText = widget.validator!(widget.textEditingController.text);
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Text(
                widget.labelText ?? '',
                style: AppTextStyles.bodyLarge(context).copyWith(
                    fontWeight: FontWeight.w500,
                    color: widget.enabled!
                        ? AppColors.darkWhiteLightBlack(
                            Theme.of(context).brightness)
                        : AppColors.darkSecondary),
              ),
            ),
            TextFormField(
              onTapOutside: widget.onTapOutside,
              onTap: widget.onTap,
              focusNode: widget.focusNode,
              enableInteractiveSelection: false,
              keyboardType: widget.isNumericKeyboard!
                  ? const TextInputType.numberWithOptions(decimal: false)
                  : widget.keyboardType,
              controller: widget.textEditingController,
              enabled: widget.enabled,
              readOnly: widget.readOnly!,
              obscureText: widget.obscureText!,
              cursorColor: AppColors.primary(Theme.of(context).brightness),
              decoration: InputDecoration(
                  errorText: _errorText,
                  hintText: widget.hintText,
                  hintStyle: AppTextStyles.bodyLarge(context).copyWith(
                      color: AppColors.darkWhiteLightBlack(
                          Theme.of(context).brightness),
                      fontWeight: FontWeight.w200),
                  filled: true,
                  fillColor: widget.enabled!
                      ? AppColors.darkBlackLightWhite(
                          Theme.of(context).brightness)
                      : AppColors.secondary(Theme.of(context).brightness),
                  enabledBorder: borderFocused.copyWith(
                      borderSide: BorderSide(
                          color: AppColors.textFieldBorder(
                              Theme.of(context).brightness))),
                  // labelText: labelText
                  labelStyle: AppTextStyles.bodyLarge(context),
                  floatingLabelStyle: AppTextStyles.bodyLarge(context),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: borderFocused,
                  border: borderFocused.copyWith(
                      borderSide: BorderSide(
                          color: AppColors.textFieldBorder(
                              Theme.of(Get.context!).brightness))),
                  suffixIcon: widget.suffixIcon,
                  prefixIcon: widget.prefixIcon,
                  prefixIconColor:
                      AppColors.primary(Theme.of(Get.context!).brightness),
                  counterText: ''),
              validator: widget.validator,
              onChanged: (value) {
                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }
                if (widget.validator != null) {
                  setState(() {
                    _errorText = widget.validator!(value);
                  });
                }
              },
              onFieldSubmitted: widget.onFieldSubmitted,
              textInputAction: widget.textInputAction,
              style: AppTextStyles.bodyLarge(context).copyWith(
                  // fontSize: 20,
                  color: AppColors.darkWhiteLightBlack(
                      Theme.of(Get.context!).brightness)),
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              inputFormatters: widget.isNumericKeyboard!
                  ? [
                      LengthLimitingTextInputFormatter(widget.maxLength),
                      FilteringTextInputFormatter.digitsOnly
                    ]
                  : [LengthLimitingTextInputFormatter(widget.maxLength)],
              textCapitalization: widget.textCapitalization!,
            ),
          ],
        ),
      ),
    );
  }
}

class TextFormFieldSearchCustom extends StatelessWidget {
  final bool? isNumericKeyboard;
  final TextEditingController textEditingController;
  final String labelText;
  final String? Function(String?)? validator;
  final bool? enabled;
  final bool? readOnly;
  final Widget? suffixIcon;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? hintText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final IconData? icon;
  final String? hint;
  final String? errorMessage;
  final bool? enableSuggestions;
  final bool? autocorrect;
  final TextCapitalization? textCapitalization;

  const TextFormFieldSearchCustom({
    super.key,
    required this.textEditingController,
    required this.labelText,
    this.validator,
    this.suffixIcon,
    this.enabled = true,
    this.maxLength,
    this.readOnly = false,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onFieldSubmitted,
    this.minLines = 1,
    this.maxLines = 1,
    this.hintText,
    this.icon,
    this.hint,
    this.errorMessage,
    this.enableSuggestions = false,
    this.autocorrect = false,
    this.textCapitalization = TextCapitalization.words,
    this.isNumericKeyboard = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: TextFormField(
        enableInteractiveSelection: false,
        keyboardType: isNumericKeyboard!
            ? const TextInputType.numberWithOptions(decimal: false)
            : keyboardType,
        controller: textEditingController,
        enabled: enabled,
        readOnly: readOnly!,
        obscureText: obscureText!,
        cursorColor: AppColors.primary(Theme.of(context).brightness),
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.bodyMedium(context),
            filled: true,
            fillColor: enabled!
                ? Colors.white
                : AppColors.secondary(Theme.of(context).brightness),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(width: 0, color: Colors.white)),
            // labelText: labelText
            labelStyle: AppTextStyles.bodyLarge(context),
            floatingLabelStyle: AppTextStyles.bodyLarge(context),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            focusedBorder: borderFocused,
            border: borderFocused,
            suffixIcon: suffixIcon,
            counterText: ''),
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        style: AppTextStyles.bodyMedium(context).copyWith(
            fontSize: 20,
            color: AppColors.primary(Theme.of(context).brightness)),
        minLines: minLines,
        maxLines: maxLines,
        inputFormatters: isNumericKeyboard!
            ? [
                LengthLimitingTextInputFormatter(maxLength),
                FilteringTextInputFormatter.digitsOnly
              ]
            : [LengthLimitingTextInputFormatter(maxLength)],
        textCapitalization: textCapitalization!,
      ),
    );
  }
}

class TextFormFieldOtpCodeCustom extends StatelessWidget {
  final TextEditingController textEditingController;

  final String? Function(String?)? validator;
  final bool? enabled;
  final bool? readOnly;
  final Widget? suffixIcon;
  final int? maxLength;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;

  const TextFormFieldOtpCodeCustom(
      {super.key,
      required this.textEditingController,
      this.validator,
      this.enabled,
      this.readOnly = false,
      this.suffixIcon,
      this.maxLength,
      this.obscureText = false,
      this.keyboardType,
      this.onChanged,
      this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      enableInteractiveSelection: false,
      enabled: enabled,
      readOnly: readOnly!,
      obscureText: obscureText!,
      cursorColor: AppColors.primary(Theme.of(context).brightness),
      decoration: InputDecoration(
          hintText: '0',
          hintStyle: AppTextStyles.subtitle(context).copyWith(
              color: AppColors.secondary(Theme.of(context).brightness)),
          filled: true,
          fillColor: Colors.white,
          errorStyle: AppTextStyles.subtitle(context),
          focusedErrorBorder: otpBorder.copyWith(
              borderSide: BorderSide(
                  color: AppColors.errorColor(Theme.of(context).brightness))),
          errorBorder: otpBorder.copyWith(
              borderSide: BorderSide(
                  color: AppColors.errorColor(Theme.of(context).brightness))),
          disabledBorder: otpBorder,
          enabledBorder: otpBorder,
          labelStyle: AppTextStyles.bodyMedium(context),
          floatingLabelStyle: AppTextStyles.bodyLarge(context),
          focusedBorder: otpBorder.copyWith(
              borderSide: BorderSide(
                  color: AppColors.primary(Theme.of(context).brightness))),
          // border: borderFocused,
          suffixIcon: suffixIcon,
          counterText: ''),
      validator: validator,

      // onChanged: onChanged,
      onChanged: (value) {
        if (value.length == 1) {
          try {
            FocusScope.of(context).nextFocus();
          } catch (e) {}
        }
      },
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      onFieldSubmitted: onFieldSubmitted,
      style: AppTextStyles.subtitle(context).copyWith(
          fontSize: 20, color: AppColors.primary(Theme.of(context).brightness)),
      maxLines: 1,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly
      ],
    );
  }
}

class OutlineShadowInputBorder extends OutlineInputBorder {
  final double shadowWidth;
  final Color shadowColor;

  const OutlineShadowInputBorder({
    BorderSide borderSide = const BorderSide(),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(50)),
    double gapPadding = 40.0,
    this.shadowWidth = 40.0,
    this.shadowColor = const Color(0xFFFFFFFF),
  }) : super(
          borderSide: borderSide,
          borderRadius: borderRadius,
          gapPadding: gapPadding,
        );

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double? gapExtent,
    double? gapPercentage,
    TextDirection? textDirection,
  }) {
    if (borderRadius.topLeft != Radius.zero) {
      final RRect outer = borderRadius.toRRect(rect);
      final RRect inner = outer.deflate(borderSide.width);
      final Paint paint = borderSide.toPaint()
        ..color = shadowColor
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowWidth);
      canvas.drawRRect(outer, paint);
      canvas.drawRRect(inner, paint);
    } else {
      final Rect outer = rect;
      final Rect inner = outer.deflate(borderSide.width);
      final Paint paint = borderSide.toPaint()
        ..color = shadowColor
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowWidth);
      canvas.drawRect(outer, paint);
      canvas.drawRect(inner, paint);
    }
    super.paint(
      canvas,
      rect,
      gapStart: gapStart ?? 0.0, // Valor predeterminado si es null
      gapExtent: gapExtent ?? 0.0, // Valor predeterminado si es null
      gapPercentage: gapPercentage ?? 0.0, // Valor predeterminado si es null
      textDirection: textDirection,
    );
  }
}

class DecoratedInputBorder extends InputBorder {
  DecoratedInputBorder({
    required this.child,
    required this.shadow,
  }) : super(borderSide: child.borderSide);

  final InputBorder child;

  final BoxShadow shadow;

  @override
  bool get isOutline => child.isOutline;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      child.getInnerPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      child.getOuterPath(rect, textDirection: textDirection);

  @override
  EdgeInsetsGeometry get dimensions => child.dimensions;

  @override
  InputBorder copyWith(
      {BorderSide? borderSide,
      InputBorder? child,
      BoxShadow? shadow,
      bool? isOutline}) {
    return DecoratedInputBorder(
      child: (child ?? this.child).copyWith(borderSide: borderSide),
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  ShapeBorder scale(double t) {
    final scalledChild = child.scale(t);

    return DecoratedInputBorder(
      child: scalledChild is InputBorder ? scalledChild : child,
      shadow: BoxShadow.lerp(null, shadow, t)!,
    );
  }

  @override
  void paint(Canvas canvas, Rect rect,
      {double? gapStart,
      double gapExtent = 0.0,
      double gapPercentage = 0.0,
      TextDirection? textDirection}) {
    final clipPath = Path()
      ..addRect(const Rect.fromLTWH(-5000, -5000, 10000, 10000))
      ..addPath(getInnerPath(rect), Offset.zero)
      ..fillType = PathFillType.evenOdd;
    canvas.clipPath(clipPath);

    final Paint paint = shadow.toPaint();
    final Rect bounds = rect.shift(shadow.offset).inflate(shadow.spreadRadius);

    canvas.drawPath(getOuterPath(bounds), paint);

    child.paint(canvas, rect,
        gapStart: gapStart,
        gapExtent: gapExtent,
        gapPercentage: gapPercentage,
        textDirection: textDirection);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is DecoratedInputBorder &&
        other.borderSide == borderSide &&
        other.child == child &&
        other.shadow == shadow;
  }

  // @override
  // int get hashCode => hashValues(borderSide, child, shadow);

  @override
  String toString() {
    return '${objectRuntimeType(this, 'DecoratedInputBorder')}($borderSide, $shadow, $child)';
  }
}
