import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'movie_card.dart';

class MovieSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Movie> movies;
  final ValueChanged<Movie> onMovieTap;
  final bool compact;

  const MovieSection({
    super.key,
    required this.title,
    required this.movies,
    required this.onMovieTap,
    this.subtitle,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    if (subtitle != null) ...[
                      const SizedBox(height: 3),
                      Text(subtitle!, style: const TextStyle(fontSize: 11, color: Color(0xFFADB2C3))),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_rounded, size: 19, color: Color(0xFFADB2C3)),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: compact ? 222 : 246,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            separatorBuilder: (_, __) => const SizedBox(width: 13),
            itemBuilder: (context, index) => MovieCard(
              movie: movies[index],
              compact: compact,
              onTap: () => onMovieTap(movies[index]),
            ),
          ),
        ),
      ],
    );
  }
}
