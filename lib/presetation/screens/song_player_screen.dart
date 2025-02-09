import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/cubits/song/song_cubit.dart';
import 'package:spotify_clone/domain/cubits/song_player/song_player_cubit.dart';
import 'package:spotify_clone/domain/cubits/song_player/song_player_state.dart';
import 'package:spotify_clone/domain/helpers/assets/app_urls.dart';
import 'package:spotify_clone/domain/models/song_model.dart';
import 'package:spotify_clone/presetation/utils/colors.dart';
import 'package:spotify_clone/presetation/utils/text_styles.dart';
import 'package:spotify_clone/presetation/widgets/app_bars/base_app_bar.dart';
import 'package:spotify_clone/presetation/widgets/buttons/favorite_button.dart';
import 'package:spotify_clone/presetation/widgets/image_widget.dart';
import 'package:spotify_clone/presetation/widgets/loading_widget.dart';

class SongPlayerScreen extends StatelessWidget {
  static const String path = '/song-player';
  final String songId;

  const SongPlayerScreen({required this.songId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Stai ascoltando',
        isPlayer: true,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SongPlayerCubit(),
          ),
          BlocProvider(
            create: (context) => SongCubit(songRepository: context.read()),
          ),
        ],
        child: BlocConsumer<SongCubit, SongState>(
          listener: (context, state) {
            if (state is SongLoaded) {
              context.read<SongPlayerCubit>().loadSong(
                  '${AppURLs.songFirestorage}${state.response.artist} - ${state.response.title}.mp3?${AppURLs.mediaAlt}');
            }
          },
          builder: (context, state) {
            switch (state) {
              case SongInitial():
                context.read<SongCubit>().getSongById(songId);
                return LoadingWidget();
              case SongLoading():
                return LoadingWidget();
              case SongLoaded():
                return _body(state.response);
              case SongError():
                return const Center(
                  child: Text('Error'),
                );
            }
          },
        ),
      ),
    );
  }

  //  ..loadSong('${AppURLs.songFirestorage}${songEntity.artist} - ${songEntity.title}.mp3?${AppURLs.mediaAlt}'),

  Widget _body(SongModel songEntity) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxHeight = constraints.maxHeight;
        final double maxWidth = constraints.maxWidth;

        return Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, maxHeight * 0.036),
          child: Column(
            children: [
              Column(
                spacing: 8,
                children: [
                  ImageWidget(
                    artistName: songEntity.artist,
                    songTitle: songEntity.title,
                    borderRadius: 16,
                    fit: BoxFit.cover,
                    width: maxWidth,
                    height: MediaQuery.of(context).size.height / 1.9,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            songEntity.title,
                            style: bold_24,
                          ),
                          Text(
                            songEntity.artist,
                            style: regular_14,
                          ),
                        ],
                      ),
                      FavoriteButton(
                        songEntity: songEntity,
                        updateData: false,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: maxHeight * 0.02),
              Expanded(
                child: _songPlayer(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoaded || state is SongPlayerLoading || state is SongPlayerError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Slider(
                value: context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
                min: 0.0,
                max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble(),
                onChanged: (value) {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDuration(context.read<SongPlayerCubit>().songPosition),
                    style: regular_14,
                  ),
                  Text(
                    formatDuration(context.read<SongPlayerCubit>().songDuration),
                    style: regular_14,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.repeat),
                    GestureDetector(
                      onTap: () {
                        context.read<SongCubit>().back();
                      },
                      child: const Icon(
                        Icons.skip_previous,
                        size: 40,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<SongPlayerCubit>().playOrPauseSong();
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: primary,
                        ),
                        child: Icon(
                          context.read<SongPlayerCubit>().audioPlayer.playing ? Icons.pause : Icons.play_arrow,
                          size: 40,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<SongCubit>().getRandomSong();
                      },
                      child: const Icon(
                        Icons.skip_next,
                        size: 40,
                      ),
                    ),
                    const Icon(Icons.airplay),
                  ],
                ),
              ),
            ],
          );
        }

        return Container();
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
