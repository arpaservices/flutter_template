import 'package:flutter/material.dart';

class AppTextStyles {
  // Large title text style (for main headings or screen titles)
  static TextStyle titleLarge(BuildContext context) {
    return Theme.of(context).textTheme.headline4!.copyWith(
      fontSize: 32, // Adjust size as needed
      fontWeight: FontWeight.bold,
      color: Theme.of(context).textTheme.headline4!.color,
    );
  }

  // Medium title text style (for section headings)
  static TextStyle titleMedium(BuildContext context) {
    return Theme.of(context).textTheme.headline5!.copyWith(
      fontSize: 24, // Adjust size as needed
      fontWeight: FontWeight.w600,
      color: Theme.of(context).textTheme.headline5!.color,
    );
  }

  // Small title text style (for smaller titles or subtitles)
  static TextStyle titleSmall(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
      fontSize: 20, // Adjust size as needed
      fontWeight: FontWeight.w500,
      color: Theme.of(context).textTheme.headline6!.color,
    );
  }

  // Primary body text style (for main content)
  static TextStyle body(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
      fontSize: 16, // Adjust size as needed
      fontWeight: FontWeight.normal,
      color: Theme.of(context).textTheme.bodyText1!.color,
    );
  }

  // Secondary body text style (for descriptions or details)
  static TextStyle bodyMedium(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2!.copyWith(
      fontSize: 14, // Adjust size as needed
      fontWeight: FontWeight.normal,
      color: Theme.of(context).textTheme.bodyText2!.color,
    );
  }

  // Minor body text style (for footnotes or disclaimers)
  static TextStyle bodySmall(BuildContext context) {
    return Theme.of(context).textTheme.caption!.copyWith(
      fontSize: 12, // Adjust size as needed
      fontWeight: FontWeight.normal,
      color: Theme.of(context).textTheme.caption!.color,
    );
  }

  // Button text style (typically bold or all caps)
  static TextStyle buttonText(BuildContext context) {
    return Theme.of(context).textTheme.button!.copyWith(
      fontSize: 16, // Adjust size as needed
      fontWeight: FontWeight.bold,
      color: Theme.of(context).textTheme.button!.color,
    );
  }

  // Caption text style (for image descriptions or small notes)
  static TextStyle captionText(BuildContext context) {
    return Theme.of(context).textTheme.caption!.copyWith(
      fontSize: 12, // Adjust size as needed
      fontWeight: FontWeight.normal,
      color: Theme.of(context).textTheme.caption!.color,
    );
  }

  // Label text style (for labels or tags on UI elements)
  static TextStyle labelText(BuildContext context) {
    return Theme.of(context).textTheme.subtitle2!.copyWith(
      fontSize: 14, // Adjust size as needed
      fontWeight: FontWeight.w600,
      color: Theme.of(context).textTheme.subtitle2!.color,
    );
  }

  // Link text style (for clickable text such as hyperlinks)
  static TextStyle linkText(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
      fontSize: 16, // Adjust size as needed
      fontWeight: FontWeight.normal,
      color: Theme.of(context).primaryColor, // Typically a color used for links
      decoration: TextDecoration.underline, // Underlined for links
    );
  }
}
