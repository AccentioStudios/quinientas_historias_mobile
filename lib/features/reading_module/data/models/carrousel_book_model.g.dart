// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carrousel_book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarouselBookModel _$CarouselBookModelFromJson(Map<String, dynamic> json) =>
    CarouselBookModel(
      bookId: json['bookId'] as String,
      author: Author.fromJson(json['author'] as String),
      title: json['title'] as String,
      readingTime: json['readingTime'] as String,
      readingState: $enumDecodeNullable(
              _$ReadingBookStateEnumMap, json['readingState']) ??
          ReadingBookState.unread,
    );

Map<String, dynamic> _$CarouselBookModelToJson(CarouselBookModel instance) =>
    <String, dynamic>{
      'bookId': instance.bookId,
      'author': instance.author,
      'title': instance.title,
      'readingTime': instance.readingTime,
      'readingState': _$ReadingBookStateEnumMap[instance.readingState],
    };

const _$ReadingBookStateEnumMap = {
  ReadingBookState.done: 'done',
  ReadingBookState.reading: 'reading',
  ReadingBookState.unread: 'unread',
};
