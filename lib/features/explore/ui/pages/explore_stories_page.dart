import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/data/entities/story_entity.dart';
import '../../../../core/libs/custom_search_delegate.dart' as customSearch;
import '../../../../core/ui/widgets/story_cover.dart';
import '../../../../core/utils/constants.dart';
import '../../../home/ui/bloc/cubit/home_cubit.dart';
import '../../../reading_module/reading_story/reading_story_provider.dart';
import '../cubit/explore_stories_cubit.dart';

class ExploreStoriesPage extends StatefulWidget {
  const ExploreStoriesPage({Key? key}) : super(key: key);

  @override
  State<ExploreStoriesPage> createState() => _ExploreStoriesPageState();
}

class _ExploreStoriesPageState extends State<ExploreStoriesPage> {
  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    getStories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreStoriesCubit, ExploreStoriesState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(57.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color:
                              Theme.of(context).dividerColor.withOpacity(0.05),
                          width: 1.0,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 11, horizontal: 18),
                    child: Flex(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        direction: Axis.horizontal,
                        children: [
                          Container(
                            height: 35,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
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
              ),
              title: const Text('Explorar'),
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
            body: RefreshIndicator(
              onRefresh: () => getStories(),
              child: GridView.count(
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics()
                    .applyTo(const BouncingScrollPhysics()),
                shrinkWrap: true,
                crossAxisSpacing: Constants.space12,
                mainAxisSpacing: Constants.space12,
                childAspectRatio: 109 / 147,
                crossAxisCount: 3,
                children: [
                  ...state.exploreStories.map((story) => StoryCover(
                        story: story,
                        onTap: () {
                          _navigateToStoryPage(context, story);
                        },
                      )),
                ],
              ),
            ));
      },
    );
  }

  Future<void> getStories() {
    return BlocProvider.of<ExploreStoriesCubit>(context).getStories();
  }

  void _navigateToStoryPage(
    BuildContext context,
    Story story,
  ) {
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (_) => ReadingStoryProvider(
              homeCubit: BlocProvider.of<HomeCubit>(context),
              storyId: story.id,
            )));
  }
}

class ExploreSearchDelegate extends customSearch.CustomSearchDelegate {
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
            showResults(context);
          },
        );
      },
    );
  }
}
