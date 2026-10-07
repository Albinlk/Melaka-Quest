import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static TextTheme _buildTextTheme(ThemeData base) {
    return TextTheme(
      displayLarge: GoogleFonts.spaceGrotesk(fontSize: 48, fontWeight: FontWeight.bold, letterSpacing: -0.02, color: const Color(0xFF171d1d), height: 1.1),
      displayMedium: GoogleFonts.spaceGrotesk(fontSize: 40, fontWeight: FontWeight.bold, color: const Color(0xFF171d1d), height: 1.1),
      displaySmall: GoogleFonts.spaceGrotesk(fontSize: 32, fontWeight: FontWeight.w600, letterSpacing: -0.01, color: const Color(0xFF171d1d), height: 1.2),
      headlineLarge: GoogleFonts.spaceGrotesk(fontSize: 32, fontWeight: FontWeight.w600, color: const Color(0xFF171d1d)),
      headlineMedium: GoogleFonts.spaceGrotesk(fontSize: 24, fontWeight: FontWeight.w600, color: const Color(0xFF171d1d), height: 1.3),
      headlineSmall: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w600, color: const Color(0xFF171d1d)),
      titleLarge: GoogleFonts.spaceGrotesk(fontSize: 22, fontWeight: FontWeight.w600, color: const Color(0xFF171d1d)),
      titleMedium: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w600, color: const Color(0xFF171d1d)),
      titleSmall: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xFF171d1d)),
      bodyLarge: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.normal, color: const Color(0xFF171d1d), height: 1.6),
      bodyMedium: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.normal, color: const Color(0xFF171d1d), height: 1.5),
      bodySmall: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.normal, color: const Color(0xFF171d1d), height: 1.5),
      labelLarge: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF171d1d), letterSpacing: 0.5),
      labelMedium: GoogleFonts.spaceGrotesk(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF171d1d), letterSpacing: 0.5, height: 1.4),
      labelSmall: GoogleFonts.spaceGrotesk(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF171d1d), letterSpacing: 0.5),
    );
  }

  static ThemeData get lightTheme {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: const Color(0xFFf5fafa), // background
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF00696e),
        onPrimary: Color(0xFFffffff),
        primaryContainer: Color(0xFF00a8af),
        onPrimaryContainer: Color(0xFF003639),
        secondary: Color(0xFF7f5600),
        onSecondary: Color(0xFFffffff),
        secondaryContainer: Color(0xFFf9ad00),
        onSecondaryContainer: Color(0xFF664500),
        tertiary: Color(0xFF006a62),
        onTertiary: Color(0xFFffffff),
        tertiaryContainer: Color(0xFF00aa9d),
        onTertiaryContainer: Color(0xFF003732),
        error: Color(0xFFba1a1a),
        onError: Color(0xFFffffff),
        background: Color(0xFFf5fafa),
        onBackground: Color(0xFF171d1d),
        surface: Color(0xFFffffff),
        onSurface: Color(0xFF171d1d),
        surfaceVariant: Color(0xFFe9efef),
        onSurfaceVariant: Color(0xFF3d494a),
        outline: Color(0xFF6c797a),
        shadow: Colors.black26,
      ),
      textTheme: _buildTextTheme(base),
      cardTheme: CardTheme(
        color: const Color(0xFFffffff).withOpacity(0.8), // Glass effect
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), // xl
        elevation: 0, // Using backdrop filter for elevation
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          backgroundColor: const Color(0xFF00696e),
          foregroundColor: const Color(0xFFffffff),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFe9efef), // Fog / surface-container
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFbcc9ca)), // pale slate / outline variant
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFbcc9ca)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF00696e), width: 2), // luminous teal
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  static ThemeData get darkTheme {
    return lightTheme; // Forcing light theme globally as per Daylight Adventure guidelines
  }
}
