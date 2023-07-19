import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/data/entities/story_entity.dart';
// ignore: library_prefixes
import '../../../../core/libs/custom_search_delegate.dart' as customSearch;
import '../../../../core/mixins/bottom_sheet_messages.dart';
import '../../../../core/ui/widgets/padding_column.dart';
import '../../../../core/ui/widgets/story_cover.dart';
import '../../../../core/utils/constants.dart';
import '../../../reading_module/reading_story/reading_story_provider.dart';
import '../../../tournament/ui/widgets/no_item_found_widget.dart';
import '../../data/dto/explore_stories_filtes.dto.dart';
import '../cubit/explore_stories_cubit.dart';

class ExploreStoriesPage extends StatefulWidget with SheetMessages {
  const ExploreStoriesPage({super.key});

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
            bottom: _filtersSearchToolbar(context, filters: state.filters,
                onTapOrderBy: () {
              _openOrderBySheet(state.filters.orderBy);
            }),
            title: const Text('Explorar'),
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  _showSearch(context);
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
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
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

  _showSearch(BuildContext context) {
    Navigator.of(context, rootNavigator: true).push(SearchBarPopupRoute<void>(
        filters: context.read<ExploreStoriesCubit>().state.filters,
        onSearch: (newFilters) {
          context.read<ExploreStoriesCubit>().applyFilters(
                id: newFilters?.id,
                title: newFilters?.title,
                tournamentId: newFilters?.tournamentId,
                orderBy: newFilters?.orderBy,
              );
          _pagingController.refresh();
        },
        onClear: () {
          context.read<ExploreStoriesCubit>().clearFilters();
          _pagingController.refresh();
        }));
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

  void _openOrderBySheet(StoryOrderBy selectedOrderBy) {
    widget
        .showExploreStoryOrderBy<StoryOrderBy>(
          context,
          selectedOption: selectedOrderBy,
        )
        .then((newSelectedOrderBy) => {
              if (newSelectedOrderBy != null)
                {
                  setState(() {
                    context
                        .read<ExploreStoriesCubit>()
                        .applyFilters(orderBy: newSelectedOrderBy);
                    _pagingController.refresh();
                  })
                }
            });
  }
}

_filtersSearchToolbar(BuildContext context,
    {required void Function() onTapOrderBy,
    required ExploreSearchFilters filters}) {
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
              GestureDetector(
                onTap: onTapOrderBy,
                child: Container(
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
                            color: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                          )),
                      const SizedBox(width: 12.0),
                      Text(filters.orderBy.name,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer)),
                      const SizedBox(width: 12.0),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    ),
  );
}

class ExploreSearchDelegate extends customSearch.CustomSearchDelegate {
  ExploreSearchDelegate({required this.context, required this.state});

  final BuildContext context;
  final ExploreStoriesState state;

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

class SearchBarPopupRoute<T> extends PopupRoute<T> {
  SearchBarPopupRoute(
      {required this.filters, required this.onSearch, required this.onClear});
  final ExploreSearchFilters? filters;
  final void Function(ExploreSearchFilters?) onSearch;
  final void Function() onClear;
  TextEditingController? _searchFieldController;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.3);

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => 'SearchBarPopupRoute';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    _searchFieldController = TextEditingController(text: filters?.title);
    final top = MediaQuery.paddingOf(context).top;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Material(
        type: MaterialType.transparency,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: double.infinity,
            height: 112 + top,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: PaddingColumn(
              padding: EdgeInsets.only(
                  top: top + 3,
                  left: 4,
                  right: Constants.space16,
                  bottom: Constants.space16),
              children: [
                Row(
                  children: [
                    // Back button
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    // Search field with icon and close button
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer
                              .withOpacity(0.08),
                        ),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            const SizedBox(width: 8),
                            const Icon(Icons.search),
                            Expanded(
                              child: Transform.translate(
                                offset: const Offset(0, -3),
                                child: TextField(
                                    autofocus: true,
                                    controller: _searchFieldController,
                                    style: const TextStyle(
                                        height: 1, fontSize: 15),
                                    decoration: const InputDecoration(
                                      hintText: 'Buscar historias...',
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 0),
                                    ),
                                    onSubmitted: (value) {
                                      final newFilter = filters?.copyWith(
                                        title: value,
                                      );
                                      Navigator.of(context).pop(value);
                                      onSearch(newFilter);
                                    }),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                onClear();
                                _searchFieldController?.clear();
                                Navigator.of(context).pop(null);
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);
}
