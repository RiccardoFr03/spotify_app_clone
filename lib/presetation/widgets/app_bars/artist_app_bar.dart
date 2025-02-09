import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone/domain/helpers/is_dark_mode.dart';
import 'package:spotify_clone/presetation/widgets/image_widget.dart';
import '../../utils/text_styles.dart';

class ArtistAppBar extends StatefulWidget {
  final String name;
  final ValueNotifier<bool> isExpandedNotifier;
  const ArtistAppBar({super.key, required this.name, required this.isExpandedNotifier});

  @override
  State<ArtistAppBar> createState() => _ArtistAppBarState();
}

class _ArtistAppBarState extends State<ArtistAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height / 2.8,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.fromLTRB(16, 0, 0, 4),
        background: ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.7),
                Colors.black.withValues(alpha: 0.1),
              ],
            ).createShader(rect);
          },
          blendMode: BlendMode.darken,
          child: ImageWidget(
            artistName: widget.name,
            songTitle: null,
            height: MediaQuery.of(context).size.height / 2.8,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            borderRadius: 0,
          ),
        ),
        title: ValueListenableBuilder<bool>(
          valueListenable: widget.isExpandedNotifier,
          builder: (context, isExpanded, child) {
            return AnimatedOpacity(
              opacity: isExpanded ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: Text(
                widget.name,
                style: bold_24.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
        centerTitle: false,
      ),
      title: ValueListenableBuilder<bool>(
        valueListenable: widget.isExpandedNotifier,
        builder: (context, isExpanded, child) {
          return AnimatedOpacity(
            opacity: isExpanded ? 0.0 : 1.0,
            duration: Duration(milliseconds: 300),
            child: Text(
              widget.name,
              style: bold_22,
            ),
          );
        },
      ),
      centerTitle: true,
      leading: ValueListenableBuilder<bool>(
        valueListenable: widget.isExpandedNotifier,
        builder: (context, isExpanded, child) {
          return IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha: isExpanded ? 0.30 : 0)
                    : Colors.white.withValues(alpha: isExpanded ? 0.50 : 0),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: context.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          );
        },
      ),
      actions: [
        ValueListenableBuilder<bool>(
          valueListenable: widget.isExpandedNotifier,
          builder: (context, isExpanded, child) {
            return IconButton(
              onPressed: () {},
              icon: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha: isExpanded ? 0.30 : 0)
                      : Colors.white.withValues(alpha: isExpanded ? 0.50 : 0),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.more_vert,
                  size: 24,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
