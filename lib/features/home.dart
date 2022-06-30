import 'package:flutter/material.dart';

import '../../../../core/data/entities/author_entitiy.dart';
import '../../../../core/ui/widgets/big_button.dart';
import '../../../../core/ui/widgets/headline.dart';
import '../../../../core/ui/widgets/padding_column.dart';
import '../../../../core/utils/constants.dart';
import 'home/ui/widgets/header_points_and_favorites_row.dart';
import 'home/ui/widgets/hero_header_widget.dart';
import 'reading_module/data/models/carrousel_book_model.dart';
import 'reading_module/reading_challenge/ui/widgets/reading_carousel_book.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: Constants.space16),
            ReadingCarouselBook(bookList: bookList),
            const SizedBox(height: Constants.space41),
            PaddingColumn(
              padding:
                  const EdgeInsets.symmetric(horizontal: Constants.space16),
              children: [
                const HeroHeader(
                  dayState: HeroHeaderDayState.day,
                ),
                const SizedBox(height: Constants.space16),
                const HeroHeader(
                  small: true,
                  dayState: HeroHeaderDayState.night,
                ),
                const SizedBox(height: Constants.space16),
                BigButton(
                  elevation: 8,
                  text: 'Comenzar la lectura',
                  onPressed: () {},
                  svgIconPath: 'assets/icons/book-open.svg',
                ),
                const SizedBox(height: Constants.space16),
                const BigButton(
                  elevation: 18,
                  text: 'Comenzar la lectura',
                  onPressed: null,
                  svgIconPath: 'assets/icons/book-open.svg',
                ),
                const SizedBox(height: Constants.space16),
                const HeaderPointsAndFavoritesRow(),
                const Headline(
                  label: 'Lecturas Recomendadas',
                  linkText: 'Ver más',
                ),
              ],
            ),
            const PaddingColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              padding: EdgeInsets.symmetric(horizontal: Constants.space16),
              children: [
                Headline(
                  label: 'Top 5 de mi equipo',
                  linkText: 'Ver más',
                ),
                Text('TEST'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final List<CarouselBookModel> bookList = [
  CarouselBookModel(
    bookId: '1',
    title: 'The Amazing Book',
    readingTime: '5 min',
    author: Author(name: 'Felipe', lastname: 'Hernandez'),
    readingState: ReadingBookState.done,
  ),
  CarouselBookModel(
    bookId: '2',
    title: 'The Awesome Book',
    readingTime: '5 min',
    author: Author(name: 'Felipe', lastname: 'Hernandez'),
    readingState: ReadingBookState.done,
  ),
  CarouselBookModel(
    bookId: '3',
    title: 'The Unforgettable Book',
    readingTime: '5 min',
    author: Author(name: 'Felipe', lastname: 'Hernandez'),
    readingState: ReadingBookState.reading,
  ),
  CarouselBookModel(
    bookId: '4',
    title: 'The Chosen One Book',
    readingTime: '5 min',
    author: Author(name: 'Felipe', lastname: 'Hernandez'),
  ),
  CarouselBookModel(
    bookId: '5',
    title: 'Ella es la sensacion del bloque',
    readingTime: '5 min',
    author: Author(name: 'Felipe', lastname: 'Hernandez'),
  ),
  CarouselBookModel(
    bookId: '5',
    title:
        'Caramba ñero se oscurecieron mis dias, alzo al vuelo mi alegria cuando menos lo esperaba',
    readingTime: '5 min',
    author: Author(name: 'Felipe', lastname: 'Hernandez'),
  ),
];
