import 'package:flutter/material.dart';

import 'package:base_template/core/config/app_text_styles.dart';

mixin TextPropertiesMixin {
  String get text;
  TextAlign? get align;
  int? get maxLines;
  TextOverflow? get overflow;
  Color? get color;

  Widget buildText(BuildContext context, TextStyle baseStyle) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        text,
        style: baseStyle.copyWith(
          color: color ?? baseStyle.color,
        ),
        textAlign: align,
        maxLines: maxLines,
        overflow: overflow ?? TextOverflow.ellipsis,
      ),
    );
  }
}

class AppTextTitle extends StatelessWidget with TextPropertiesMixin {
  @override
  final String text;
  @override
  final TextAlign? align;
  @override
  final int? maxLines;
  @override
  final TextOverflow? overflow;
  @override
  final Color? color;

  AppTextTitle(this.text,
      {super.key, this.align, this.maxLines, this.overflow, this.color});

  @override
  Widget build(BuildContext context) {
    return buildText(context, AppTextStyles.title(context));
  }
}

class AppTextSubtitle extends StatelessWidget with TextPropertiesMixin {
  @override
  final String text;
  @override
  final TextAlign? align;
  @override
  final int? maxLines;
  @override
  final TextOverflow? overflow;
  @override
  final Color? color;

  AppTextSubtitle(this.text,
      {super.key, this.align, this.maxLines, this.overflow, this.color});

  @override
  Widget build(BuildContext context) {
    return buildText(context, AppTextStyles.subtitle(context));
  }
}

class AppTextBodyLarge extends StatelessWidget with TextPropertiesMixin {
  @override
  final String text;
  @override
  final TextAlign? align;
  @override
  final int? maxLines;
  @override
  final TextOverflow? overflow;
  @override
  final Color? color;

  AppTextBodyLarge(this.text,
      {super.key, this.align, this.maxLines, this.overflow, this.color});

  @override
  Widget build(BuildContext context) {
    return buildText(context, AppTextStyles.bodyLarge(context));
  }
}

class AppTextBodyMedium extends StatelessWidget with TextPropertiesMixin {
  @override
  final String text;
  @override
  final TextAlign? align;
  @override
  final int? maxLines;
  @override
  final TextOverflow? overflow;
  @override
  final Color? color;

  AppTextBodyMedium(this.text,
      {super.key, this.align, this.maxLines, this.overflow, this.color});

  @override
  Widget build(BuildContext context) {
    return buildText(context, AppTextStyles.bodyMedium(context));
  }
}

class AppTextBodySmall extends StatelessWidget with TextPropertiesMixin {
  @override
  final String text;
  @override
  final TextAlign? align;
  @override
  final int? maxLines;
  @override
  final TextOverflow? overflow;
  @override
  final Color? color;

  AppTextBodySmall(this.text,
      {super.key, this.align, this.maxLines, this.overflow, this.color});

  @override
  Widget build(BuildContext context) {
    return buildText(context, AppTextStyles.bodySmall(context));
  }
}
