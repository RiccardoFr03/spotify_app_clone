import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/cubits/artist_songs/artist_songs_cubit.dart';
import 'package:spotify_clone/presetation/widgets/app_bars/artist_app_bar.dart';
import 'package:spotify_clone/presetation/widgets/loading_widget.dart';
import 'package:spotify_clone/presetation/widgets/play_list.dart';

class ArtistiScreen extends StatefulWidget {
  static const String path = '/artist';
  final String name;
  const ArtistiScreen({super.key, required this.name});

  @override
  State<ArtistiScreen> createState() => _ArtistiScreenState();
}

class _ArtistiScreenState extends State<ArtistiScreen> {
  late ScrollController _scrollController;
  late ValueNotifier<bool> _isExpandedNotifier;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _isExpandedNotifier = ValueNotifier(true);

    _scrollController.addListener(() {
      _isExpandedNotifier.value = _scrollController.offset < MediaQuery.of(context).size.height / 2.8 - 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        slivers: [
          ArtistAppBar(
            name: widget.name,
            isExpandedNotifier: _isExpandedNotifier,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => BlocBuilder<ArtistSongsCubit, ArtistSongsState>(
                builder: (context, state) {
                  switch (state) {
                    case ArtistSongsInitial():
                      context.read<ArtistSongsCubit>().getArtistSongs(widget.name);
                      return LoadingWidget();
                    case ArtistSongsLoading():
                      return LoadingWidget();
                    case ArtistSongsLoaded():
                      final loadedState = state;
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: PlayList(
                          songs: loadedState.songs,
                          title: 'Brani',
                        ),
                      );
                    case ArtistSongsError():
                      return const Center(
                        child: Text('Error'),
                      );
                  }
                },
              ),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
