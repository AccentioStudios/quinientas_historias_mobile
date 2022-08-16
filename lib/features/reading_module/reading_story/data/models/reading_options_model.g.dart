// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_options_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadingOptions _$ReadingOptionsFromJson(Map<String, dynamic> json) =>
    ReadingOptions(
      fontSizeBase: (json['fontSizeBase'] as num?)?.toDouble() ?? 1.20,
      pTextAlign: $enumDecodeNullable(_$TextAlignEnumMap, json['pTextAlign']) ??
          TextAlign.justify,
      lineHeightBase: (json['lineHeightBase'] as num?)?.toDouble() ?? 145,
      theme: $enumDecodeNullable(_$ReadingThemeEnumMap, json['theme']) ??
          ReadingTheme.light,
    );

Map<String, dynamic> _$ReadingOptionsToJson(ReadingOptions instance) =>
    <String, dynamic>{
      'fontSizeBase': instance.fontSizeBase,
      'pTextAlign': _$TextAlignEnumMap[instance.pTextAlign],
      'lineHeightBase': instance.lineHeightBase,
      'theme': _$ReadingThemeEnumMap[instance.theme],
    };

const _$TextAlignEnumMap = {
  TextAlign.left: 'left',
  TextAlign.right: 'right',
  TextAlign.center: 'center',
  TextAlign.justify: 'justify',
  TextAlign.start: 'start',
  TextAlign.end: 'end',
};

const _$ReadingThemeEnumMap = {
  ReadingTheme.light: 'light',
  ReadingTheme.dark: 'dark',
};