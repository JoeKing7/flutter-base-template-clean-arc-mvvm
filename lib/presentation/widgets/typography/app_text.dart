import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:base_template/core/config/app_colors.dart';
import 'package:base_template/core/config/app_text_styles.dart';

class AppTextTitle extends StatelessWidget {
  final String text;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppTextTitle(this.text,
      {super.key, this.align, this.maxLines, this.overflow});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.title(context)
          .copyWith(color: AppColors.primary(Theme.of(context).brightness)),
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
    );
  }
}

class AppTextSubtitle extends StatelessWidget {
  final String text;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppTextSubtitle(this.text,
      {super.key, this.align, this.maxLines, this.overflow});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.subtitle(context)
          .copyWith(color: AppColors.primary(Theme.of(context).brightness)),
      textAlign: align,
    );
  }
}
