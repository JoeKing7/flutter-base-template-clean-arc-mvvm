import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:base_template/core/config/app_colors.dart';
import 'package:base_template/core/config/app_text_styles.dart';

const radius = Radius.circular(10);

class AppFilledButton extends StatelessWidget {
  final String text;
  final Color? color;
  final bool? isLoading;
  final void Function()? onTap;

  const AppFilledButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.isLoading = false,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: MaterialButton(
            color: color ?? AppColors.primary(Theme.of(context).brightness),
            disabledColor: AppColors.lightTertiary,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(radius)),
            height: 50.0,
            padding: const EdgeInsets.all(10.0),
            onPressed: isLoading! ? null : onTap,
            child: Text(
              text,
              style: AppTextStyles.bodyLarge(context).copyWith(
                color: AppColors.lightBackground,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Visibility(
            visible: isLoading!,
            child: Center(
              child: Lottie.asset('assets/lottie/loading-circular.json',
                  fit: BoxFit.fill),
            ),
          ),
        ),
      ],
    );
  }
}

class AppOutlinedButton extends StatelessWidget {
  final String text;
  final Color? color;
  final bool? isLoading;
  final void Function()? onTap;

  const AppOutlinedButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.isLoading = false,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: OutlinedButton(
            // color: color ?? AppColors.primary(Theme.of(context).brightness),
            // disabledColor: AppColors.lightTertiary,
            // shape: const RoundedRectangleBorder(
            //     borderRadius: BorderRadius.all(radius)),
            // height: 50.0,
            // padding: const EdgeInsets.all(10.0),
            style: OutlinedButton.styleFrom(
              // backgroundColor:
              //     color ?? AppColors.primary(Theme.of(context).brightness),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(radius),
              ),
              minimumSize: const Size(double.infinity, 50.0),
              disabledBackgroundColor: AppColors.lightTertiary,
              padding: const EdgeInsets.all(10.0),
              side: BorderSide(
                color: color ?? AppColors.primary(Theme.of(context).brightness),
              ),
            ),
            onPressed: isLoading! ? null : onTap,
            child: Text(
              text,
              style: AppTextStyles.bodyLarge(context).copyWith(
                color: color ?? AppColors.primary(Theme.of(context).brightness),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Visibility(
            visible: isLoading!,
            child: Center(
              child: Lottie.asset('assets/lottie/loading-circular.json',
                  fit: BoxFit.fill),
            ),
          ),
        ),
      ],
    );
  }
}

class AppIconButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final Color? color;
  final bool? isLoading;
  final void Function()? onTap;

  const AppIconButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.icon,
    this.isLoading = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: ElevatedButton.icon(
            // color: color ?? AppColors.primary(Theme.of(context).brightness),
            // disabledColor: AppColors.lightTertiary,
            // shape: const RoundedRectangleBorder(
            //     borderRadius: BorderRadius.all(radius)),
            // height: 50.0,
            // padding: const EdgeInsets.all(10.0),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  color ?? AppColors.primary(Theme.of(context).brightness),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(radius),
              ),
              minimumSize: const Size(double.infinity, 50.0),
              disabledBackgroundColor: AppColors.lightTertiary,
              padding: const EdgeInsets.all(10.0),
            ),
            onPressed: isLoading! ? null : onTap,
            icon: icon,
            label: Text(
              text,
              style: AppTextStyles.bodyLarge(context).copyWith(
                color: AppColors.lightBackground,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Visibility(
            visible: isLoading!,
            child: Center(
              child: Lottie.asset('assets/lottie/loading-circular.json',
                  fit: BoxFit.fill),
            ),
          ),
        ),
      ],
    );
  }
}
