import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_clone/domain/cubits/song_player/song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  final AudioPlayer audioPlayer = AudioPlayer();

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });

    audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        songDuration = duration;
        updateSongPlayer();
      }
    });
  }

  void updateSongPlayer() {
    emit(SongPlayerLoaded(time: DateTime.now()));
  }

  Future<void> loadSong(String url) async {
    try {
      audioPlayer.pause();
      await audioPlayer.setUrl(url);
      emit(SongPlayerLoaded(time: DateTime.now()));
      audioPlayer.play();
    } catch (e) {
      emit(SongPlayerError());
    }
  }

  void pauseSong() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
    }
    emit(SongPlayerCanExit());
  }

  void playOrPauseSong() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
    emit(SongPlayerLoaded(time: DateTime.now()));
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
