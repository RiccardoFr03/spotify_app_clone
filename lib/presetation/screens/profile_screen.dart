import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/cubits/auth/auth_cubit.dart';
import 'package:spotify_clone/domain/cubits/most_played/most_played_cubit.dart';
import 'package:spotify_clone/presetation/widgets/app_bars/profile_app_bar.dart';
import 'package:spotify_clone/presetation/widgets/loading_widget.dart';
import 'package:spotify_clone/presetation/widgets/play_list.dart';

class ProfileScreen extends StatefulWidget {
  static const String path = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ScrollController _scrollController;
  late ValueNotifier<bool> _isExpandedNotifier;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _isExpandedNotifier = ValueNotifier(true);

    _scrollController.addListener(() {
      _isExpandedNotifier.value = _scrollController.offset < MediaQuery.of(context).size.height / 3.2 - 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthCubit>().state.user;
    return Scaffold(
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        slivers: [
          ProfileAppBar(
            isExpandedNotifier: _isExpandedNotifier,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => BlocBuilder<MostPlayedCubit, MostPlayedState>(
                builder: (context, state) {
                  switch (state) {
                    case MostPlayedInitial():
                      context.read<MostPlayedCubit>().getMostPlayed(user.id);
                      return const LoadingWidget();
                    case MostPlayedLoading():
                      return const LoadingWidget();
                    case MostPlayedLoaded():
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: PlayList(
                          songs: state.songs,
                          title: 'I brani che più hai ascoltato',
                          showMoreVert: true,
                          showFavorites: false,
                        ),
                      );
                    case MostPlayedError():
                      return const Center(
                        child: Text('Errore nel caricamento delle canzoni'),
                      );
                  }
                },
              ),
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
