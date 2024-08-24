import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// const Color textPrimary = Color(0xff000000);
// const Color textSecondary = Color(0xff838383);

class CustomDecoration {
  static InputDecoration inputDecoration({
    String? icon,
    Widget? prefixWidget,
    String? label,
    String? hint,
    TextStyle? hintStyle,
    Widget? suffix,
    bool floating = false,
    Color borderColor = Colors.transparent,
    Color bgColor = Colors.white,
    double borderRadius = 12.0,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.fromLTRB(20, 10, 10, 13),
  }) {
    assert(prefixWidget == null || icon == null, "Strings are equal So this message is been displayed!!");

    return InputDecoration(
      fillColor: bgColor,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: Colors.grey.shade500, width: 0.6),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: Colors.grey.shade500, width: 0.6),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: Colors.grey.shade500, width: 0.6),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: Colors.redAccent, width: 0.4),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: Colors.redAccent, width: 0.4),
      ),
      errorStyle: const TextStyle(
        fontFamily: "Segoeui",
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: Colors.redAccent,
      ),

      suffixIcon: suffix,
      label: label != null
          ? Text(
              label,
              style: const TextStyle(
                fontFamily: "Segoeui",
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xff292D32),
              ),
            )
          : null,
      hintText: hint ?? label,
      hintStyle: hintStyle ??
          const TextStyle(
            fontFamily: "Segoeui",
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Color(0xff6B6B6B),
          ),
      floatingLabelBehavior: floating ? FloatingLabelBehavior.always : FloatingLabelBehavior.never,
      contentPadding: contentPadding,
    );
  }

  static InputDecoration dropdown(
    BuildContext context, {
    String? icon,
    String? label,
    bool filled = true,
    TextStyle? hintStyle,
    bool floating = false,
  }) {
    return InputDecoration(
      fillColor: Colors.white,
      filled: filled,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 0.4),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 0.4),
      ),

      label: label != null
          ? Text(
              label,
              // textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: const Color(0xff292D32),
              ),
            )
          : null,
      hintText: label,
      hintStyle: hintStyle ??
          GoogleFonts.montserrat(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xff6B6B6B),
          ),
      floatingLabelBehavior: floating ? FloatingLabelBehavior.always : FloatingLabelBehavior.never,
      // contentPadding: const EdgeInsets.fromLTRB(12, 25, 12, 20),
    );
  }
}
