import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/data/entities/challenge_sar_entity.dart';
// ignore: library_prefixes
import '../../../../../core/libs/custom_search_delegate.dart' as customSearch;
import '../../../../../core/utils/constants.dart';
import '../../cubit/challenges_admin_cubit.dart';

@RoutePage()
class ChallengesAdminExplorePage extends StatefulWidget {
  const ChallengesAdminExplorePage({super.key});

  @override
  State<ChallengesAdminExplorePage> createState() =>
      _ChallengesAdminExplorePageState();
}

class _ChallengesAdminExplorePageState
    extends State<ChallengesAdminExplorePage> {
  final _pagingController =
      PagingController<int, ChallengeSar>(firstPageKey: 1);
  @override
  initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController
        .removePageRequestListener((pageKey) => _fetchPage(pageKey));
    _pagingController.dispose();

    super.dispose();
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChallengesAdminCubit, ChallengesAdminState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Explorar retos registrados'),
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  customSearch.showSearch(
                      delegate: ExploreSearchDelegate(), context: context);
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Constants.space18),
            child: RefreshIndicator(
              onRefresh: () => Future.sync(
                () => _pagingController.refresh(),
              ),
              child: PagedGridView(
                showNewPageProgressIndicatorAsGridChild: false,
                showNewPageErrorIndicatorAsGridChild: false,
                showNoMoreItemsIndicatorAsGridChild: false,
                physics: const AlwaysScrollableScrollPhysics()
                    .applyTo(const BouncingScrollPhysics()),
                pagingController: _pagingController,
                shrinkWrap: true,
                builderDelegate: PagedChildBuilderDelegate<ChallengeSar>(
                  noItemsFoundIndicatorBuilder: (context) => const Center(
                      child: Text(
                    'Hubo un problema al intentar buscar los retos o todavía no existe ninguno :(',
                    textAlign: TextAlign.center,
                  )),
                  firstPageErrorIndicatorBuilder: (context) => const Center(
                      child: Text(
                    'Hubo un problema al intentar buscar los retos o todavía no existe ninguno :(',
                    textAlign: TextAlign.center,
                  )),
                  itemBuilder: (context, item, index) => Padding(
                    padding: const EdgeInsets.only(top: Constants.space18),
                    child: InkWell(
                        // card item of minigame, showing name and placeholder image, using primary container color as background, rounded corners
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: SvgPicture.asset(
                                      'assets/images/challenge-placeholder-image.svg',
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: Constants.space12,
                                    left: Constants.space12,
                                    right: Constants.space12,
                                    bottom: Constants.space12),
                                child: Text(
                                  item.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer,
                                          fontWeight: FontWeight.w600),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //       top: Constants.space12,
                              //       left: Constants.space12,
                              //       right: Constants.space12),
                              //   child: Text(
                              //     item.name,
                              //     style: Theme.of(context)
                              //         .textTheme
                              //         .bodyText2!
                              //         .copyWith(
                              //             color: Theme.of(context)
                              //                 .colorScheme
                              //                 .onPrimaryContainer,
                              //             fontWeight: FontWeight.w400),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        onTap: () {
                          _navigateToSarGame(context, item);
                        }),
                  ),
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 109 / (147 + 25),
                  crossAxisSpacing: Constants.space12,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _fetchPage(int pageKey) {
    if (mounted) {
      BlocProvider.of<ChallengesAdminCubit>(context)
          .getChallenges(pageKey)
          .then((newPage) {
        final previouslyFetchedItemsCount =
            _pagingController.itemList?.length ?? 0;
        final isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
        final newItems = newPage.itemList;
        if (isLastPage) {
          _pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(newItems, nextPageKey);
        }
      }, onError: (e) {
        _pagingController.error = e;
      });
    }
  }

  void _navigateToSarGame(
    BuildContext context,
    ChallengeSar story,
  ) {
    // ReadingStoryProvider.openStory(context, storyId: story.id);
  }
}

_filtersSearchToolbar(BuildContext context) {
  return const PreferredSize(
    preferredSize: Size.fromHeight(57.0),
    child: SizedBox.shrink(),
    // child: Align(
    //   alignment: Alignment.centerLeft,
    //   child: Container(
    //     decoration: BoxDecoration(
    //       border: Border(
    //         bottom: BorderSide(
    //           color: Theme.of(context).dividerColor.withOpacity(0.05),
    //           width: 1.0,
    //         ),
    //       ),
    //     ),
    //     padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 18),
    //     child: Flex(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         direction: Axis.horizontal,
    //         children: [
    //           Container(
    //             height: 35,
    //             decoration: BoxDecoration(
    //               color: Theme.of(context).colorScheme.tertiaryContainer,
    //               borderRadius: BorderRadius.circular(8.0),
    //             ),
    //             child: Row(
    //               children: [
    //                 const SizedBox(width: 12.0),
    //                 SizedBox(
    //                     width: 17,
    //                     height: 17,
    //                     child: SvgPicture.asset(
    //                       'assets/icons/orderby-icon.svg',
    //                       color:
    //                           Theme.of(context).colorScheme.onTertiaryContainer,
    //                     )),
    //                 const SizedBox(width: 12.0),
    //                 Text('Mas gustados',
    //                     style: TextStyle(
    //                         color: Theme.of(context)
    //                             .colorScheme
    //                             .onTertiaryContainer)),
    //                 const SizedBox(width: 12.0),
    //               ],
    //             ),
    //           ),
    //         ]),
    //   ),
    // ),
  );
}

class ExploreSearchDelegate extends customSearch.CustomSearchDelegate {
  ExploreSearchDelegate();

  @override
  String get searchFieldLabel => 'Buscar retos...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      textTheme: Theme.of(context).textTheme.copyWith(
            titleLarge: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 15,
            ),
          ),
      appBarTheme: AppBarTheme(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
        // borders bottom rounded
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            }
            query = '';
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query,
          style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = [];

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            close(context, query);
          },
        );
      },
    );
  }
}
