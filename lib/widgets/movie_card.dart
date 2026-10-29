import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../theme/app_theme.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;
  final bool compact;

  const MovieCard({
    super.key,
    required this.movie,
    required this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final width = compact ? 126.0 : 142.0;
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: AspectRatio(
                aspectRatio: 0.69,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      movie.posterUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _PosterFallback(movie: movie),
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const _PosterLoading();
                      },
                    ),
                    Positioned(
                      left: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.72),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_rounded, color: Color(0xFFFFC857), size: 13),
                            const SizedBox(width: 3),
                            Text(movie.rating, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    if (movie.isSeries)
                      Positioned(
                        right: 7,
                        top: 7,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text('SERIAL', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w800)),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 9),
            Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
            const SizedBox(height: 3),
            Text(
              '${movie.year} • ${movie.genre.split(' • ').first}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _PosterFallback extends StatelessWidget {
  final Movie movie;
  const _PosterFallback({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceLight,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.movie_creation_outlined, size: 36, color: AppColors.textSecondary),
          const SizedBox(height: 10),
          Text(movie.title, textAlign: TextAlign.center, maxLines: 3, overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _PosterLoading extends StatelessWidget {
  const _PosterLoading();

  @override
  Widget build(BuildContext context) => Container(
    color: AppColors.surface,
    alignment: Alignment.center,
    child: const SizedBox(
      height: 22,
      width: 22,
      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.accent),
    ),
  );
}
