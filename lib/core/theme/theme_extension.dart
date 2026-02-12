import 'package:flutter/material.dart';
import 'package:skin_firts/core/theme/app_color.dart';

extension ThemeX on BuildContext{
  AppColor get appColors => Theme.of(this).extension<AppColor>()!;
}