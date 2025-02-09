import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/cubits/home_data/home_data_cubit.dart';
import 'package:spotify_clone/presetation/widgets/app_bars/home_app_bar.dart';
import 'package:spotify_clone/presetation/widgets/loading_widget.dart';
import 'package:spotify_clone/presetation/widgets/take_back.dart';
import 'package:spotify_clone/presetation/widgets/play_list.dart';
import 'package:spotify_clone/presetation/widgets/artists.dart';

class HomeScreen extends StatefulWidget {
  static const String path = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppbar(),
      body: BlocBuilder<HomeDataCubit, HomeDataState>(
        builder: (context, state) {
          switch (state) {
            case HomeDataInitial():
              context.read<HomeDataCubit>().getHomeData();
              return LoadingWidget();
            case HomeDataLoading():
              return LoadingWidget();
            case HomeDataLoaded():
              final loadedState = state;
              return RefreshIndicator.adaptive(
                onRefresh: () async {
                  await context.read<HomeDataCubit>().getHomeData();
                  return;
                },
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Column(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Artists(artists: loadedState.response.artists),
                      TakeBack(songs: loadedState.response.recent),
                      PlayList(songs: loadedState.response.playList),
                    ],
                  ),
                ),
              );
            case HomeDataError():
              return const Center(
                child: Text('Error'),
              );
          }
        },
      ),
    );
  }
}
