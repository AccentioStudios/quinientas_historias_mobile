import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/data/entities/story_entity.dart';
// ignore: library_prefixes
import '../../../../core/libs/custom_search_delegate.dart' as customSearch;
import '../../../../core/ui/widgets/story_cover.dart';
import '../../../../core/utils/constants.dart';
import '../../../reading_module/reading_story/reading_story_provider.dart';
import '../../../tournament/ui/widgets/no_item_found_widget.dart';
import '../cubit/explore_stories_cubit.dart';

class ExploreStoriesPage extends StatefulWidget {
  const ExploreStoriesPage({Key? key}) : super(key: key);

  @override
  State<ExploreStoriesPage> createState() => _ExploreStoriesPageState();
}

class _ExploreStoriesPageState extends State<ExploreStoriesPage> {
  final _pagingController = PagingController<int, Story>(firstPageKey: 1);
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
    return BlocBuilder<ExploreStoriesCubit, ExploreStoriesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            bottom: _filtersSearchToolbar(context),
            title: const Text('Explorar'),
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  customSearch.showSearch(
                      delegate: ExploreSearchDelegate(
                          toolbar: _filtersSearchToolbar(context)),
                      context: context);
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
                builderDelegate: PagedChildBuilderDelegate<Story>(
                  noItemsFoundIndicatorBuilder: (context) =>
                      const NoItemFound(),
                  firstPageErrorIndicatorBuilder: (context) =>
                      const PageErrorIndicator(),
                  itemBuilder: (context, item, index) => Padding(
                    padding: const EdgeInsets.only(top: Constants.space18),
                    child: StoryCover(
                        story: item,
                        onTap: () {
                          _navigateToStoryPage(context, item);
                        }),
                  ),

                  // GridView.count(
                  //   padding: EdgeInsets.zero,
                  //   physics: const AlwaysScrollableScrollPhysics()
                  //       .applyTo(const BouncingScrollPhysics()),
                  //   shrinkWrap: true,
                  //   crossAxisSpacing: Constants.space12,
                  //   mainAxisSpacing: Constants.space12,
                  //   childAspectRatio: 109 / 147,
                  //   crossAxisCount: 3,
                  //   children: [
                  //     ...state.exploreStories.map((story) => StoryCover(
                  //           story: story,
                  //           onTap: () {
                  //             _navigateToStoryPage(context, story);
                  //           },
                  //         )),
                  //   ],
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 109 / (147 + 25),
                  crossAxisSpacing: Constants.space12,
                  // mainAxisSpacing: Constants.space12,
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
      BlocProvider.of<ExploreStoriesCubit>(context).getStories(pageKey).then(
          (newPage) {
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

  void _navigateToStoryPage(
    BuildContext context,
    Story story,
  ) {
    ReadingStoryProvider.openStory(context, storyId: story.id);
  }
}

_filtersSearchToolbar(BuildContext context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(57.0),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor.withOpacity(0.05),
              width: 1.0,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 18),
        child: Flex(
            crossAxisAlignment: CrossAxisAlignment.center,
            direction: Axis.horizontal,
            children: [
              Container(
                height: 35,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12.0),
                    SizedBox(
                        width: 17,
                        height: 17,
                        child: SvgPicture.asset(
                          'assets/icons/orderby-icon.svg',
                          color:
                              Theme.of(context).colorScheme.onTertiaryContainer,
                        )),
                    const SizedBox(width: 12.0),
                    Text('Mas gustados',
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer)),
                    const SizedBox(width: 12.0),
                  ],
                ),
              ),
            ]),
      ),
    ),
  );
}

class ExploreSearchDelegate extends customSearch.CustomSearchDelegate {
  ExploreSearchDelegate({required this.toolbar});

  final PreferredSize toolbar;

  @override
  PreferredSize get toolbarWidget => toolbar;

  @override
  String get searchFieldLabel => 'Buscar historias...';

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
