import "package:flutter/material.dart";

class CustomTheme {
  const CustomTheme();

  ThemeData lightTheme() {
    return ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: const Color.fromARGB(255, 197, 134, 39),
      ),
    );
  }

  ThemeData darkTheme() {
    return ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: const Color.fromARGB(255, 249, 213, 159),
      ),
    );
  }
}
