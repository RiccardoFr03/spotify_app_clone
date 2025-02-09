import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/cubits/history/history_cubit.dart';
import 'package:spotify_clone/presetation/widgets/empty_search_history.dart';
import 'package:spotify_clone/presetation/widgets/loading_widget.dart';
import 'package:spotify_clone/presetation/widgets/play_list.dart';

class SearchHistory extends StatelessWidget {
  const SearchHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        switch (state) {
          case HistoryInitial():
            context.read<HistoryCubit>().getHistory();
            return LoadingWidget();
          case HistoryLoading():
            return LoadingWidget();
          case HistoryLoaded():
            return state.history.isEmpty
                ? EmptySearchHistory()
                : RefreshIndicator.adaptive(
                    onRefresh: () async {
                      await context.read<HistoryCubit>().getHistory();
                      return;
                    },
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Column(
                        spacing: 16,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PlayList(
                            songs: state.history,
                            title: 'Ricerche recenti',
                            showDelete: true,
                            showFavorites: false,
                          ),
                        ],
                      ),
                    ),
                  );
          case HistoryError():
            return const Center(
              child: Text('Error'),
            );
        }
      },
    );
  }
}
