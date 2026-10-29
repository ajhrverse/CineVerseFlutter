import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../theme/app_theme.dart';

class FeaturedMovieBanner extends StatelessWidget {
  final Movie movie;
  final VoidCallback onPlay;
  final VoidCallback onDetails;

  const FeaturedMovieBanner({
    super.key,
    required this.movie,
    required this.onPlay,
    required this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: SizedBox(
          height: 390,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                movie.backdropUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xFF34364F), Color(0xFF111321), Color(0xFF4A152A)],
                    ),
                  ),
                  child: const Icon(Icons.movie_filter_rounded, size: 76, color: Colors.white24),
                ),
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black12, Color(0x22000000), Color(0xF20B0D17)],
                    stops: [0, 0.35, 1],
                  ),
                ),
              ),
              Positioned(
                top: 15,
                left: 15,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('PILIHAN MINGGU INI', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 0.7)),
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Color(0xFFFFC857), size: 17),
                        const SizedBox(width: 4),
                        Text(movie.rating, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        const SizedBox(width: 10),
                        Text(movie.year, style: const TextStyle(fontSize: 12, color: Colors.white70)),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(movie.genre, maxLines: 1, overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 11, color: Colors.white70)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 9),
                    Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900, height: 1.0, letterSpacing: -0.7),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      movie.synopsis,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, height: 1.45, color: Colors.white70),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: onPlay,
                            icon: const Icon(Icons.play_arrow_rounded, size: 22),
                            label: const Text('Tonton Sekarang'),
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton.filledTonal(
                          tooltip: 'Detail film',
                          onPressed: onDetails,
                          icon: const Icon(Icons.info_outline_rounded),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white.withValues(alpha: 0.16),
                            foregroundColor: Colors.white,
                            fixedSize: const Size(48, 48),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
