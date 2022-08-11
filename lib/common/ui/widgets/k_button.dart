import 'package:flutter/material.dart';
import 'package:the_green_manual/common/constants/app_dimens.dart';
import 'package:the_green_manual/common/ui/ui_helpers.dart';
import 'package:the_green_manual/themes/app_theme.dart';

enum ButtonSize { small, medium, large }

// ignore: must_be_immutable
class KButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  final ButtonSize size;
  Color? borderColor;
  final bool isBusy;
  String? variant;
  final bool? bordered;
  final Color? backgroundColor, foregroundColor;
  @override
  KButton({
    required this.child,
    required this.onPressed,
    this.variant,
    this.isBusy = false,
    this.size = ButtonSize.small,
    this.backgroundColor,
    this.borderColor,
    this.foregroundColor,
    this.bordered,
    Key? key,
  }) : super(key: key);

  double getFontSizeBySize(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return AppDimens.buttonFontSizeSmall;
      case ButtonSize.medium:
        return AppDimens.buttonFontSizeMedium;
      case ButtonSize.large:
        return AppDimens.buttonFontSizeLarge;
    }
  }

  EdgeInsetsGeometry getPaddingBySize(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return AppDimens.buttonPaddingSmall;
      case ButtonSize.medium:
        return AppDimens.buttonPaddingMedium;
      case ButtonSize.large:
        return AppDimens.buttonPaddingLarge;
    }
  }

  double getProgressRadiusByButtonSize(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return 18;
      case ButtonSize.medium:
        return 20;
      case ButtonSize.large:
        return 22;
    }
  }

  double getProgressWidthByButtonSize(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return 2;
      case ButtonSize.medium:
        return 3;
      case ButtonSize.large:
        return 3;
    }
  }

  /// Button is wrapped inside of theme to change the font-size of the
  /// child text widget based on the size passed.
  ///
  /// The buttons can be wrapped to fit content by Wrapping it inside of Row,
  /// and setting the mainAxisSize: MainAxisSize.min

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.copyWith(
              button: Theme.of(context).textTheme.button?.copyWith(
                    fontSize: getFontSizeBySize(size),
                  ),
            ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(
              color: variant == 'ghost' ? Colors.black : Colors.white),
          elevation: 0,
          padding: getPaddingBySize(size),
          shape: RoundedRectangleBorder(
            side: (bordered ?? false)
                ? BorderSide(color: borderColor ?? Colors.black)
                : BorderSide.none,
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
          ),
        ).copyWith(
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return foregroundColor ?? buttonColor;
            },
          ),
          backgroundColor: variant == 'ghost'
              ? MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return (Colors.transparent);
                    } else if (states.contains(MaterialState.disabled)) {
                      return (Colors.grey[500] ??
                              Theme.of(context).primaryColor)
                          .withOpacity(0.5);
                    } else {
                      return (Colors.transparent);
                    }
                  },
                )
              : MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return (backgroundColor ?? Theme.of(context).primaryColor)
                          .withOpacity(0.5);
                    } else if (states.contains(MaterialState.disabled)) {
                      return (backgroundColor ?? Theme.of(context).primaryColor)
                          .withOpacity(0.5);
                    } else {
                      return (backgroundColor ??
                          Theme.of(context).primaryColor);
                    }
                  },
                ),
        ),
        onPressed: isBusy ? null : onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isBusy)
              Row(
                children: [
                  SizedBox(
                    width: getProgressRadiusByButtonSize(size),
                    height: getProgressRadiusByButtonSize(size),
                    child: CircularProgressIndicator(
                      strokeWidth: getProgressWidthByButtonSize(size),
                      valueColor: const AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                  lWidthSpan,
                ],
              ),
            child,
          ],
        ),
      ),
    );
  }
}
