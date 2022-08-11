import 'package:flutter/cupertino.dart';
import 'package:flutter_html/style.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reading_options_model.g.dart';

@JsonSerializable()
class ReadingOptions {
  ReadingOptions({
    this.fontSizeBase = 1.20,
    this.pTextAlign = TextAlign.justify,
    this.lineHeightBase = 145,
    this.theme = ReadingTheme.light,
  });

  final double fontSizeBase;
  final TextAlign pTextAlign;
  final double lineHeightBase;
  final ReadingTheme theme;

  LineHeight get lineHeight =>
      LineHeight(lineHeightBase / 100.0 * 1.2, units: "%");
  FontSize get fontSize => FontSize(fontSizeBase * 16 - 2, units: "rem");
  FontSize get h1fontSize => FontSize.rem(fontSizeBase + 0.4);
  FontSize get h2fontSize => FontSize.rem(fontSizeBase + 0.2);

  Brightness get brightness =>
      theme == ReadingTheme.light ? Brightness.light : Brightness.dark;

  factory ReadingOptions.fromJson(Map<String, dynamic> json) =>
      _$ReadingOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$ReadingOptionsToJson(this);
}

enum ReadingTheme { light, dark }
