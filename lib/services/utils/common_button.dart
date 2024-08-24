import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant.dart';

enum ButtonType { primary, secondary, tertiary }

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.title,
    this.child,
    this.type = ButtonType.primary,
    required this.onTap,
    this.disabledColor,
    this.color,
    this.height = 45,
    this.isLoading = false,
    this.radius = 14,
    this.elevation = 0,
    this.fontSize = 14,
  }) : assert(title == null || child == null, 'Cannot provide both a title and a child\n');

  const CustomButton.tertiary({
    super.key,
    this.title,
    this.child,
    this.type = ButtonType.tertiary,
    required this.onTap,
    this.disabledColor,
    this.color,
    this.height = 45,
    this.isLoading = false,
    this.radius = 14,
    this.elevation = 10,
    this.fontSize,
  }) : assert(title == null || child == null, 'Cannot provide both a title and a child\n');

  ///Button Title text
  final String? title;

  ///Button Title text
  final Widget? child;

  ///Button Type i.e. Primary or Secondary or Ternary
  final ButtonType type;

  ///Button isLoading if provided true will disable click on button and circular progress indicator will be visible
  final bool isLoading;

  ///Button buttonDisabled Color
  final Color? disabledColor;

  ///Button Color
  final Color? color;

  ///Button Height
  final double? height;

  ///Button Radius
  final double radius;

  ///Button onTap()
  final Function()? onTap;

  final double elevation;

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    if (type == ButtonType.primary) {
      return MaterialButton(
        onPressed: isLoading ? null : onTap,
        height: height,
        minWidth: 80,
        elevation: elevation,
        focusElevation: 0,
        highlightElevation: 0,
        disabledElevation: 0,
        hoverElevation: 0,
        color: color ?? primaryColor,
        disabledColor: disabledColor ?? Theme.of(context).disabledColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: Builder(
            builder: (context) {
              if (isLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: color ?? Colors.white,
                    strokeWidth: 2,
                  ),
                );
              }

              return child ??
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Text(
                      title!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: fontSize,
                      ),
                    ),
                  );
            },
          ),
        ),
      );
    } else if (type == ButtonType.secondary) {
      return MaterialButton(
        onPressed: isLoading ? null : onTap,
        height: height,
        minWidth: 80,
        elevation: elevation,
        focusElevation: 0,
        highlightElevation: 0,
        disabledElevation: 0,
        hoverElevation: 0,
        color: color ?? Colors.transparent,
        disabledColor: disabledColor ?? Theme.of(context).disabledColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: Theme.of(context).primaryColor),
        ),
        child: Center(
          child: Builder(
            builder: (context) {
              if (isLoading) {
                return CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  strokeWidth: 2,
                );
              }

              return child ??
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Text(
                      title!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Theme.of(context).primaryColor,
                        fontSize: fontSize,
                      ),
                    ),
                  );
            },
          ),
        ),
      );
    } else {
      return TextButton(
        onPressed: isLoading ? null : onTap,
        child: Builder(
          builder: (context) {
            if (isLoading) {
              return CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
                strokeWidth: 2,
              );
            }
            if (child != null) {
              return child!;
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                title!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: fontSize,
                    ),
              ),
            );
          },
        ),
      );
    }
  }
}
