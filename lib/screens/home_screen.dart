import 'package:flutter/material.dart';
import '../data/dummy_movies.dart';
import '../models/movie.dart';
import '../theme/app_theme.dart';
import '../widgets/featured_movie_banner.dart';
import '../widgets/movie_section.dart';

class HomeScreen extends StatelessWidget {
  final ValueChanged<Movie> onMovieTap;
  final ValueChanged<Movie> onPlayTap;

  const HomeScreen({
    super.key,
    required this.onMovieTap,
    required this.onPlayTap,
  });

  @override
  Widget build(BuildContext context) {
    final popular = dummyMovies.where((movie) => !movie.isSeries).toList();
    final series = dummyMovies.where((movie) => movie.isSeries).toList();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 18),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Selamat datang 👋', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      SizedBox(height: 4),
                      Text('Malam ini nonton apa?', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.workspace_premium_rounded, color: Color(0xFFFFC857), size: 15),
                      SizedBox(width: 5),
                      Text('STANDARD', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: FeaturedMovieBanner(
            movie: dummyMovies.first,
            onPlay: () => onPlayTap(dummyMovies.first),
            onDetails: () => onMovieTap(dummyMovies.first),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 28)),
        SliverToBoxAdapter(
          child: MovieSection(
            title: 'Sedang Populer',
            subtitle: 'Pilihan yang sedang banyak ditonton',
            movies: popular,
            onMovieTap: onMovieTap,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverToBoxAdapter(
          child: MovieSection(
            title: 'Rekomendasi Untukmu',
            subtitle: 'Dipilih berdasarkan selera tontonanmu',
            movies: [dummyMovies[2], dummyMovies[4], dummyMovies[1], dummyMovies[3]],
            onMovieTap: onMovieTap,
            compact: true,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverToBoxAdapter(
          child: MovieSection(
            title: 'Serial Populer',
            subtitle: 'Cerita yang bisa kamu lanjutkan',
            movies: series,
            onMovieTap: onMovieTap,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 28)),
      ],
    );
  }
}
