import "package:flutter/material.dart";

class MaterialTheme {
  const MaterialTheme();

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff266489),
      surfaceTint: Color(0xff266489),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffc9e6ff),
      onPrimaryContainer: Color(0xff001e2f),
      secondary: Color(0xff50606e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd3e5f5),
      onSecondaryContainer: Color(0xff0c1d29),
      tertiary: Color(0xff64597b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffeaddff),
      onTertiaryContainer: Color(0xff201634),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff7f9ff),
      onSurface: Color(0xff181c20),
      onSurfaceVariant: Color(0xff41474d),
      outline: Color(0xff72787e),
      outlineVariant: Color(0xffc1c7ce),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inversePrimary: Color(0xff95cdf7),
      primaryFixed: Color(0xffc9e6ff),
      onPrimaryFixed: Color(0xff001e2f),
      primaryFixedDim: Color(0xff95cdf7),
      onPrimaryFixedVariant: Color(0xff004b6f),
      secondaryFixed: Color(0xffd3e5f5),
      onSecondaryFixed: Color(0xff0c1d29),
      secondaryFixedDim: Color(0xffb7c9d9),
      onSecondaryFixedVariant: Color(0xff384956),
      tertiaryFixed: Color(0xffeaddff),
      onTertiaryFixed: Color(0xff201634),
      tertiaryFixedDim: Color(0xffcfc0e8),
      onTertiaryFixedVariant: Color(0xff4c4162),
      surfaceDim: Color(0xffd7dadf),
      surfaceBright: Color(0xfff7f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f4f9),
      surfaceContainer: Color(0xffebeef3),
      surfaceContainerHigh: Color(0xffe5e8ed),
      surfaceContainerHighest: Color(0xffe0e3e8),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff004769),
      surfaceTint: Color(0xff266489),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff417aa1),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff344552),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff667785),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff483d5e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff7b6f93),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff7f9ff),
      onSurface: Color(0xff181c20),
      onSurfaceVariant: Color(0xff3d4449),
      outline: Color(0xff5a6066),
      outlineVariant: Color(0xff757b82),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inversePrimary: Color(0xff95cdf7),
      primaryFixed: Color(0xff417aa1),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff236187),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff667785),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4d5e6c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff7b6f93),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff625679),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd7dadf),
      surfaceBright: Color(0xfff7f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f4f9),
      surfaceContainer: Color(0xffebeef3),
      surfaceContainerHigh: Color(0xffe5e8ed),
      surfaceContainerHighest: Color(0xffe0e3e8),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002539),
      surfaceTint: Color(0xff266489),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004769),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff132430),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff344552),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff271d3c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff483d5e),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff7f9ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff1e252a),
      outline: Color(0xff3d4449),
      outlineVariant: Color(0xff3d4449),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inversePrimary: Color(0xffddeeff),
      primaryFixed: Color(0xff004769),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003048),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff344552),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff1e2e3b),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff483d5e),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff312747),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd7dadf),
      surfaceBright: Color(0xfff7f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f4f9),
      surfaceContainer: Color(0xffebeef3),
      surfaceContainerHigh: Color(0xffe5e8ed),
      surfaceContainerHighest: Color(0xffe0e3e8),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff95cdf7),
      surfaceTint: Color(0xff95cdf7),
      onPrimary: Color(0xff00344e),
      primaryContainer: Color(0xff004b6f),
      onPrimaryContainer: Color(0xffc9e6ff),
      secondary: Color(0xffb7c9d9),
      onSecondary: Color(0xff22323f),
      secondaryContainer: Color(0xff384956),
      onSecondaryContainer: Color(0xffd3e5f5),
      tertiary: Color(0xffcfc0e8),
      onTertiary: Color(0xff352b4b),
      tertiaryContainer: Color(0xff4c4162),
      onTertiaryContainer: Color(0xffeaddff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff101417),
      onSurface: Color(0xffe0e3e8),
      onSurfaceVariant: Color(0xffc1c7ce),
      outline: Color(0xff8b9198),
      outlineVariant: Color(0xff41474d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e3e8),
      inversePrimary: Color(0xff266489),
      primaryFixed: Color(0xffc9e6ff),
      onPrimaryFixed: Color(0xff001e2f),
      primaryFixedDim: Color(0xff95cdf7),
      onPrimaryFixedVariant: Color(0xff004b6f),
      secondaryFixed: Color(0xffd3e5f5),
      onSecondaryFixed: Color(0xff0c1d29),
      secondaryFixedDim: Color(0xffb7c9d9),
      onSecondaryFixedVariant: Color(0xff384956),
      tertiaryFixed: Color(0xffeaddff),
      onTertiaryFixed: Color(0xff201634),
      tertiaryFixedDim: Color(0xffcfc0e8),
      onTertiaryFixedVariant: Color(0xff4c4162),
      surfaceDim: Color(0xff101417),
      surfaceBright: Color(0xff363a3e),
      surfaceContainerLowest: Color(0xff0b0f12),
      surfaceContainerLow: Color(0xff181c20),
      surfaceContainer: Color(0xff1c2024),
      surfaceContainerHigh: Color(0xff262a2e),
      surfaceContainerHighest: Color(0xff313539),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff99d1fc),
      surfaceTint: Color(0xff95cdf7),
      onPrimary: Color(0xff001827),
      primaryContainer: Color(0xff5f96bf),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffbbcddd),
      onSecondary: Color(0xff061824),
      secondaryContainer: Color(0xff8293a2),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffd3c4ec),
      onTertiary: Color(0xff1a102f),
      tertiaryContainer: Color(0xff988bb0),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff101417),
      onSurface: Color(0xfff9fbff),
      onSurfaceVariant: Color(0xffc5cbd2),
      outline: Color(0xff9da3aa),
      outlineVariant: Color(0xff7e848a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e3e8),
      inversePrimary: Color(0xff004d71),
      primaryFixed: Color(0xffc9e6ff),
      onPrimaryFixed: Color(0xff001320),
      primaryFixedDim: Color(0xff95cdf7),
      onPrimaryFixedVariant: Color(0xff003a56),
      secondaryFixed: Color(0xffd3e5f5),
      onSecondaryFixed: Color(0xff02131e),
      secondaryFixedDim: Color(0xffb7c9d9),
      onSecondaryFixedVariant: Color(0xff283845),
      tertiaryFixed: Color(0xffeaddff),
      onTertiaryFixed: Color(0xff150b29),
      tertiaryFixedDim: Color(0xffcfc0e8),
      onTertiaryFixedVariant: Color(0xff3b3151),
      surfaceDim: Color(0xff101417),
      surfaceBright: Color(0xff363a3e),
      surfaceContainerLowest: Color(0xff0b0f12),
      surfaceContainerLow: Color(0xff181c20),
      surfaceContainer: Color(0xff1c2024),
      surfaceContainerHigh: Color(0xff262a2e),
      surfaceContainerHighest: Color(0xff313539),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff9fbff),
      surfaceTint: Color(0xff95cdf7),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff99d1fc),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff9fbff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffbbcddd),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffff9ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffd3c4ec),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff101417),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff9fbff),
      outline: Color(0xffc5cbd2),
      outlineVariant: Color(0xffc5cbd2),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e3e8),
      inversePrimary: Color(0xff002d45),
      primaryFixed: Color(0xffd2eaff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff99d1fc),
      onPrimaryFixedVariant: Color(0xff001827),
      secondaryFixed: Color(0xffd7e9fa),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffbbcddd),
      onSecondaryFixedVariant: Color(0xff061824),
      tertiaryFixed: Color(0xffeee2ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffd3c4ec),
      onTertiaryFixedVariant: Color(0xff1a102f),
      surfaceDim: Color(0xff101417),
      surfaceBright: Color(0xff363a3e),
      surfaceContainerLowest: Color(0xff0b0f12),
      surfaceContainerLow: Color(0xff181c20),
      surfaceContainer: Color(0xff1c2024),
      surfaceContainerHigh: Color(0xff262a2e),
      surfaceContainerHighest: Color(0xff313539),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
