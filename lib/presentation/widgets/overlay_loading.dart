import 'package:base_template/core/config/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lottie/lottie.dart';

import 'package:base_template/core/config/app_colors.dart';

Future<Null> overlayLoading({
  required Future<Null> Function() asyncFunction,
  String? textTitle,
  String? textSubTitle = '',
  // int? imageNumber = 0,
}) {
  return Get.showOverlay(
    asyncFunction: () async {
      // cerrar el teclado
      FocusScope.of(Get.context!).requestFocus(FocusNode());
      await asyncFunction();
    },
    loadingWidget: ZoomIn(
      child: Card(
        color: AppColors.background(Theme.of(Get.context!).brightness),
        elevation: 20,
        margin: const EdgeInsets.all(0),
        shape: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/loading-circular.json',
              height: 150,
            ),
            Text(
              textTitle ?? 'global.isLoadingText'.tr,
              style: AppTextStyles.title(Get.context!).copyWith(
                  color: AppColors.primary(Theme.of(Get.context!).brightness)),
            ),
            Text(
              textSubTitle!,
              style: AppTextStyles.subtitle(Get.context!).copyWith(
                  color: AppColors.primary(Theme.of(Get.context!).brightness)),
            ),
          ],
        ),
      ),
    ),
  );
}

// class OverlayLoadingCustom extends StatelessWidget {
//   final String? textTitle;
//   final String? textSubTitle;
//   final int? imageNumber;
//   const OverlayLoadingCustom(
//       {super.key, this.textTitle, this.textSubTitle, this.imageNumber = 0});

//   @override
//   Widget build(BuildContext context) {
//     return ZoomIn(
//       child: Center(
//         child: Card(
//           color: ColorsTheme.backgroundColor,
//           elevation: 20,
//           child: SizedBox(
//               width: double.infinity,
//               height: 200,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Pulse(
//                     infinite: true,
//                     child: SizedBox(
//                         height: 100,
//                         width: 100,
//                         child: Image.asset(image[imageNumber!])),
//                   ),
//                   Text(
//                     textTitle ?? 'Cargando...',
//                     style: TextStylesTheme.bodyLargeBold
//                         .copyWith(color: ColorsTheme.primaryColor),
//                   ),
//                   Text(
//                     textSubTitle ?? 'Un momento por favor.',
//                     style: TextStylesTheme.bodyMediumBold
//                         .copyWith(color: ColorsTheme.primaryColor),
//                   ),
//                 ],
//               )),
//         ),
//       ),
//     );
//   }
// }
