// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_options_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadingOptions _$ReadingOptionsFromJson(Map<String, dynamic> json) =>
    ReadingOptions(
      fontSizeBase: (json['fontSizeBase'] as num?)?.toDouble() ?? 16,
      pTextAlign: $enumDecodeNullable(_$TextAlignEnumMap, json['pTextAlign']) ??
          TextAlign.justify,
      lineHeightBase: (json['lineHeightBase'] as num?)?.toDouble() ?? 145,
      theme: $enumDecodeNullable(_$ThemeModeEnumMap, json['theme']) ??
          ThemeMode.light,
    );

Map<String, dynamic> _$ReadingOptionsToJson(ReadingOptions instance) =>
    <String, dynamic>{
      'fontSizeBase': instance.fontSizeBase,
      'pTextAlign': _$TextAlignEnumMap[instance.pTextAlign]!,
      'lineHeightBase': instance.lineHeightBase,
      'theme': _$ThemeModeEnumMap[instance.theme]!,
    };

const _$TextAlignEnumMap = {
  TextAlign.left: 'left',
  TextAlign.right: 'right',
  TextAlign.center: 'center',
  TextAlign.justify: 'justify',
  TextAlign.start: 'start',
  TextAlign.end: 'end',
};

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
