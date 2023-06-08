import 'package:flutter/material.dart';

const rikePrimaryColor = Color(0xFF509bf8);
const rikeSecondaryColor = Color(0xFFFF5733);
const rikeAccentColor = Color(0xFF84495F);
const rikeDisabledColor = Color(0xFFcccccc);
const rikeOutsideColor = Color(0xFFbfbfbf);

const rikeTextColorLight = Color(0xFF080808);

const rikeLightColor = Color(0xFFF4F4F4);
const rikeDarkColor = Color(0xFF272727);

const rikeIndicatorBubble = Color(0xFF39B54A);
const rikeGreenBattery = Color(0xFF39B54A);
const rikeYellowBattery = Color(0xFFFFC300);
const rikeRedBattery = Color(0xFFFF0000);

// SYSTEM COLORS

const rikePrimaryColorLight = Color(0xFF509bf8);
const rikeOnPrimaryColorLight = Color(0xFFffffff);
const rikePrimaryContainerColorLight = Color(0xFFf3f3f3);
const rikeSecondaryColorLight = Color(0xFFFF5733);
const rikeOnSecondaryColorLight = Color(0xFFfcfff7);
const rikeScrimColoLight = Color(0xFFdbdada);
const rikeSurfaceColoLight = Color(0xFFcfcece);
const rikeOnSurfaceColoLight = Color(0xFF1d2125);
const rikeBackgroundColorLight = Color(0xFFffffff);
const rikeOnBackgroundColorLight = Color(0xFF080808);
const rikeErrorColorLight = Color(0xFFea3321);
const rikeOnErrorColorLight = Color(0xFFffffff);

const rikePrimaryColorDark = Color(0xFF97d1fc);
const rikeOnPrimaryColorDark = Color(0xFF1d2125);
const rikePrimaryContainerColorDark = Color(0xFF252526);
const rikeSecondaryColorDark = Color(0xFFfc876d);
const rikeOnSecondaryColorDark = Color(0xFF1d2125);
const rikeScrimColoDark = Color(0xFF3d3d3d);
const rikeSurfaceColoDark = Color(0xFF4e4e4e);
const rikeOnSurfaceColoDark = Color(0xFFfcfff7);
const rikeBackgroundColorDark = Color(0xFF1d2125);
const rikeOnBackgroundColorDark = Color(0xFFfcfff7);
const rikeErrorColorDark = Color(0xFFCF6679);
const rikeOnErrorColorDark = Color(0xFF1d2125);

class SkeletonColorStyle {
  static const LinearGradient DEFAULT_SHIMMER_LIGHT = LinearGradient(
    colors: [
      Color(0xFFF1F2EE),
      Color(0xFFF1F2EE),
      Color(0xFFF4F4F2),
      Color(0xFFF1F2EE),
      Color(0xFFF1F2EE),
      Color(0xFFF4F4F2),
    ],
    stops: [
      0.1,
      0.3,
      0.5,
      0.7,
      0.9,
      1,
    ],
    begin: Alignment(-2.4, -0.2),
    end: Alignment(2.4, 0.2),
    transform: GradientRotation(45 * 3.1415927 / 180),
    tileMode: TileMode.clamp,
  );

  static const LinearGradient ON_SHIMMER_LIGHT = LinearGradient(
    colors: [
      Color(0xFFE0E4DE),
      Color(0xFFE0E4DE),
      Color(0xFFD2D7D1),
      Color(0xFFE0E4DE),
      Color(0xFFE0E4DE),
      Color(0xFFD2D7D1),
    ],
    stops: [
      0.1,
      0.3,
      0.5,
      0.7,
      0.9,
      1,
    ],
    begin: Alignment(-2.4, -0.2),
    end: Alignment(2.4, 0.2),
    transform: GradientRotation(45 * 3.1415927 / 180),
    tileMode: TileMode.clamp,
  );

  static const LinearGradient DEFAULT_SHIMMER_DARK = LinearGradient(
    colors: [
      Color(0xFF70726F),
      Color(0xFF70726F),
      Color(0xFF3D3F3D),
      Color(0xFF70726F),
      Color(0xFF70726F),
      Color(0xFF3D3F3D),
    ],
    stops: [
      0.1,
      0.3,
      0.5,
      0.7,
      0.9,
      1,
    ],
    begin: Alignment(-2.4, -0.2),
    end: Alignment(2.4, 0.2),
    transform: GradientRotation(45 * 3.1415927 / 180),
    tileMode: TileMode.clamp,
  );
}
