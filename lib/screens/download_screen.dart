import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../theme/app_theme.dart';
import '../widgets/movie_card.dart';

class DownloadScreen extends StatelessWidget {
  final List<Movie> movies;
  final ValueChanged<Movie> onMovieTap;
  final ValueChanged<Movie> onRemove;
  final ValueChanged<Movie> onPlay;

  const DownloadScreen({
    super.key,
    required this.movies,
    required this.onMovieTap,
    required this.onRemove,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      children: [
        const Text('Download Saya', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        const Text('Tontonan yang tersedia untuk akses offline (simulasi).',
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        const SizedBox(height: 22),
        if (movies.isEmpty)
          Container(
            padding: const EdgeInsets.fromLTRB(24, 38, 24, 38),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: AppColors.border),
            ),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: Color(0xFF282B3C),
                  child: Icon(Icons.download_for_offline_rounded, size: 38, color: AppColors.textSecondary),
                ),
                SizedBox(height: 18),
                Text('Belum ada download', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                SizedBox(height: 8),
                Text('Film yang kamu simpan untuk ditonton offline akan muncul di sini.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, height: 1.5, color: AppColors.textSecondary)),
              ],
            ),
          )
        else
          ...movies.map((movie) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 86,
                    child: MovieCard(movie: movie, compact: true, onTap: () => onMovieTap(movie)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(movie.title, maxLines: 2, overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 6),
                        const Text('1080p • 1.2 GB', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                        const SizedBox(height: 9),
                        Row(
                          children: [
                            const Icon(Icons.check_circle_rounded, size: 14, color: Color(0xFF50D890)),
                            const SizedBox(width: 5),
                            const Expanded(child: Text('Siap ditonton', style: TextStyle(fontSize: 10, color: Color(0xFF50D890)))),
                            IconButton(
                              tooltip: 'Putar',
                              visualDensity: VisualDensity.compact,
                              onPressed: () => onPlay(movie),
                              icon: const Icon(Icons.play_circle_fill_rounded, color: AppColors.accent),
                            ),
                            IconButton(
                              tooltip: 'Hapus',
                              visualDensity: VisualDensity.compact,
                              onPressed: () => onRemove(movie),
                              icon: const Icon(Icons.delete_outline_rounded, color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
      ],
    );
  }
}
