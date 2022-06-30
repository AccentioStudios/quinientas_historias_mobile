import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/entities/author_entitiy.dart';

part 'carrousel_book_model.g.dart';

@JsonSerializable()
class CarouselBookModel {
  CarouselBookModel(
      {required this.bookId,
      required this.author,
      required this.title,
      required this.readingTime,
      this.readingState = ReadingBookState.unread});
  final String bookId;
  final Author author;
  final String title;
  final String readingTime;
  @JsonKey(defaultValue: ReadingBookState.unread)
  ReadingBookState readingState;

  Map<String, dynamic> toJson() => _$CarouselBookModelToJson(this);
}

enum ReadingBookState {
  @JsonValue('done')
  done,
  @JsonValue('reading')
  reading,
  @JsonValue('unread')
  unread,
}
