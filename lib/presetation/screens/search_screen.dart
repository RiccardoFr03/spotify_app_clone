import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/blocs/search/search_bloc.dart';
import 'package:spotify_clone/presetation/utils/dimensions.dart';
import 'package:spotify_clone/presetation/widgets/empty_search_result.dart';
import 'package:spotify_clone/presetation/widgets/fields/input_field.dart';
import 'package:spotify_clone/presetation/widgets/loading_widget.dart';
import 'package:spotify_clone/presetation/widgets/play_list.dart';
import 'package:spotify_clone/presetation/widgets/search_history.dart';

class SearchScreen extends StatefulWidget {
  static const String path = '/search';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: InputField(
                height: 48,
                label: 'Cerca',
                icon: Icons.search,
                controller: _searchController,
                keyboardType: TextInputType.text,
                onChanged: (value) => _search(context, value),
              ),
            ),
            width_4,
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Annulla',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return switch (state) {
              SearchLoading() => const LoadingWidget(),
              SearchLoaded() => state.songs.isEmpty
                  ? EmptySearchResult(
                      searchQuery: _searchController.text,
                    )
                  : ListView(
                    
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                      children: [
                        _searchController.text.isEmpty
                            ? SearchHistory()
                            : PlayList(
                                songs: state.songs,
                                title: 'Risultati',
                                showFavorites: false,
                                showMoreVert: true,
                                addToHistory: true,
                              )
                      ],
                    ),
              SearchError() => const Center(
                  child: Text('Errore nel caricamento delle canzoni'),
                ),
            };
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search(BuildContext context, String query) {
    context.read<SearchBloc>().searchChange(query);
  }
}
