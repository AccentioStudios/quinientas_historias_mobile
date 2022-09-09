import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reading_options_model.g.dart';

@JsonSerializable()
class ReadingOptions {
  ReadingOptions({
    this.fontSizeBase = 1.20,
    this.pTextAlign = TextAlign.justify,
    this.lineHeightBase = 145,
    this.theme = ThemeMode.light,
  });

  final double fontSizeBase;
  final TextAlign pTextAlign;
  final double lineHeightBase;
  final ThemeMode theme;

  LineHeight get lineHeight =>
      LineHeight(lineHeightBase / 100.0 * 1.2, units: "%");
  FontSize get fontSize => FontSize(fontSizeBase * 16 - 2, units: "rem");
  FontSize get h1fontSize => FontSize.rem(fontSizeBase + 0.4);
  FontSize get h2fontSize => FontSize.rem(fontSizeBase + 0.2);

  Brightness get brightness =>
      theme == ThemeMode.light ? Brightness.light : Brightness.dark;

  bool get isDarkMode => theme == ThemeMode.dark;

  factory ReadingOptions.fromJson(Map<String, dynamic> json) =>
      _$ReadingOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$ReadingOptionsToJson(this);

  ReadingOptions copyWith({
    double? fontSizeBase,
    TextAlign? pTextAlign,
    double? lineHeightBase,
    ThemeMode? theme,
  }) {
    return ReadingOptions(
      fontSizeBase: fontSizeBase ?? this.fontSizeBase,
      pTextAlign: pTextAlign ?? this.pTextAlign,
      lineHeightBase: lineHeightBase ?? this.lineHeightBase,
      theme: theme ?? this.theme,
    );
  }
}
