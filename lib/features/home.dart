// import 'package:flutter/material.dart';
// import 'package:quinientas_historias/core/data/entities/story_progress_entity.dart';

// import '../../../../core/ui/widgets/big_button.dart';
// import '../../../../core/ui/widgets/headline.dart';
// import '../../../../core/ui/widgets/padding_column.dart';
// import '../../../../core/utils/constants.dart';
// import '../core/data/entities/story_entity.dart';
// import 'home/ui/widgets/header_points_and_favorites_row.dart';
// import 'home/ui/widgets/hero_header_widget.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.white,
//       body: SafeArea(
//         child: ListView(
//           physics: const BouncingScrollPhysics(),
//           children: [
//             const SizedBox(height: Constants.space16),
//             ReadingCarouselBook(stories: bookList),
//             const SizedBox(height: Constants.space41),
//             PaddingColumn(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: Constants.space16),
//               children: [
//                 const HeroHeader(
//                   dayState: HeroHeaderDayState.day,
//                 ),
//                 const SizedBox(height: Constants.space16),
//                 const HeroHeader(
//                   small: true,
//                   dayState: HeroHeaderDayState.night,
//                 ),
//                 const SizedBox(height: Constants.space16),
//                 BigButton(
//                   elevation: 8,
//                   text: 'Comenzar la lectura',
//                   onPressed: () {},
//                   svgIconPath: 'assets/icons/book-open.svg',
//                 ),
//                 const SizedBox(height: Constants.space16),
//                 const BigButton(
//                   elevation: 18,
//                   text: 'Comenzar la lectura',
//                   onPressed: null,
//                   svgIconPath: 'assets/icons/book-open.svg',
//                 ),
//                 const SizedBox(height: Constants.space16),
//                 const HeaderPointsAndFavoritesRow(),
//                 const Headline(
//                   label: 'Lecturas Recomendadas',
//                   linkText: 'Ver más',
//                 ),
//               ],
//             ),
//             const PaddingColumn(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               padding: EdgeInsets.symmetric(horizontal: Constants.space16),
//               children: [
//                 Headline(
//                   label: 'Top 5 de mi equipo',
//                   linkText: 'Ver más',
//                 ),
//                 Text('TEST'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// final List<StoryProgress> bookList = [
//   StoryProgress(
//     story: Story(
//       id: '1',
//       title: 'The Amazing Book',
//       readingTime: '5 min',
//       author: Author(name: 'Felipe', lastname: 'Hernandez'),
//     ),
//     state: ReadingBookState.done,
//     progress: 100,
//   ),
//   StoryProgress(
//     story: Story(
//       id: '2',
//       title: 'The Amazing Book',
//       readingTime: '5 min',
//       author: Author(name: 'Felipe', lastname: 'Hernandez'),
//     ),
//     state: ReadingBookState.done,
//     progress: 100,
//   ),
//   StoryProgress(
//     story: Story(
//       id: '3',
//       title: 'The Amazing Book',
//       readingTime: '5 min',
//       author: Author(name: 'Felipe', lastname: 'Hernandez'),
//     ),
//     state: ReadingBookState.done,
//     progress: 100,
//   ),
//   StoryProgress(
//     story: Story(
//       id: '4',
//       title: 'The Amazing Book',
//       readingTime: '5 min',
//       author: Author(name: 'Felipe', lastname: 'Hernandez'),
//     ),
//     state: ReadingBookState.done,
//     progress: 100,
//   ),
//   StoryProgress(
//     story: Story(
//       id: '5',
//       title: 'The Amazing Book',
//       readingTime: '5 min',
//       author: Author(name: 'Felipe', lastname: 'Hernandez'),
//     ),
//     state: ReadingBookState.done,
//     progress: 100,
//   ),
// ];
