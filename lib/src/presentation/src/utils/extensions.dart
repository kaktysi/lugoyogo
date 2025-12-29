import 'package:flutter/material.dart';

import '../../../domain/domain.dart';
import '../theme/theme.dart';

extension SnackBarContextExtension on BuildContext {
  void showSnackBar(
    String message, {
    SnackBarTypeEnum type = SnackBarTypeEnum.error,
  }) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();

    final Color backgroundColor = switch (type) {
      SnackBarTypeEnum.success => AppTheme.greenColor,
      SnackBarTypeEnum.warning => AppTheme.orangeColor,
      SnackBarTypeEnum.error => AppTheme.redColor,
    };

    final SnackBar snackBar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_10),
      ),
    );

    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
