import 'package:flutter/material.dart';
import 'package:the_green_manual/common/constants/app_dimens.dart';
import 'package:the_green_manual/common/ui/ui_helpers.dart';
import 'package:the_green_manual/themes/app_theme.dart';

class KSelectableList extends StatelessWidget {
  final Widget child;
  final bool active;
  const KSelectableList({required this.child, required this.active, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: mPadding,
      decoration: BoxDecoration(
        borderRadius: AppDimens.cardBorderRadius,
        color: active ? primaryColor : shutleGrey,
      ),
      child: child,
    );
  }
}
