import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../data/dummy_movies.dart';
import '../theme/app_theme.dart';
import '../widgets/movie_card.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  final bool isFavoriteInitially;
  final bool isDownloadedInitially;
  final ValueChanged<bool> onFavoriteChanged;
  final ValueChanged<bool> onDownloadChanged;
  final ValueChanged<Movie> onMovieTap;

  const MovieDetailScreen({
    super.key,
    required this.movie,
    required this.isFavoriteInitially,
    required this.isDownloadedInitially,
    required this.onFavoriteChanged,
    required this.onDownloadChanged,
    required this.onMovieTap,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late bool _favorite = widget.isFavoriteInitially;
  late bool _downloaded = widget.isDownloadedInitially;

  @override
  Widget build(BuildContext context) {
    final related = dummyMovies
        .where((movie) => movie.id != widget.movie.id)
        .take(5)
        .toList();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 310,
            backgroundColor: AppColors.background,
            leading: IconButton(
              tooltip: 'Kembali',
              onPressed: () => Navigator.maybePop(context),
              icon: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.55), shape: BoxShape.circle),
                child: const Icon(Icons.arrow_back_rounded, size: 20),
              ),
            ),
            actions: [
              IconButton(
                tooltip: 'Favorit',
                onPressed: () {
                  setState(() => _favorite = !_favorite);
                  widget.onFavoriteChanged(_favorite);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(_favorite ? 'Ditambahkan ke favorit.' : 'Dihapus dari favorit.')),
                  );
                },
                icon: Icon(_favorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: _favorite ? AppColors.accent : Colors.white),
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.movie.backdropUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [Color(0xFF383B54), AppColors.background]),
                      ),
                      child: const Icon(Icons.movie_rounded, size: 70, color: Colors.white24),
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x33000000), Color(0xFF0B0D17)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 112,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: AspectRatio(
                            aspectRatio: 0.69,
                            child: Image.network(
                              widget.movie.posterUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: AppColors.surface,
                                child: const Icon(Icons.movie_outlined, size: 40),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.movie.title, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900, height: 1.08)),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 7,
                                runSpacing: 7,
                                children: [
                                  _InfoChip(widget.movie.year),
                                  _InfoChip(widget.movie.duration),
                                  _InfoChip(widget.movie.isSeries ? 'Serial' : 'Film'),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.star_rounded, color: Color(0xFFFFC857), size: 18),
                                  const SizedBox(width: 4),
                                  Text('${widget.movie.rating}/10', style: const TextStyle(fontWeight: FontWeight.w800)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Text(widget.movie.genre, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  const SizedBox(height: 10),
                  Text(widget.movie.synopsis, style: const TextStyle(fontSize: 13, height: 1.65, color: Color(0xFFD6D9E3))),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Pemutar video belum dihubungkan.')),
                          ),
                          icon: const Icon(Icons.play_arrow_rounded),
                          label: const Text('Putar'),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            setState(() => _downloaded = !_downloaded);
                            widget.onDownloadChanged(_downloaded);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(_downloaded ? 'Ditambahkan ke Download Saya.' : 'Dihapus dari Download Saya.')),
                            );
                          },
                          icon: Icon(_downloaded ? Icons.download_done_rounded : Icons.download_rounded),
                          label: Text(_downloaded ? 'Tersimpan' : 'Download'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: AppColors.border),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  const Text('Pemeran', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 94,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.movie.cast.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 18),
                      itemBuilder: (context, index) => SizedBox(
                        width: 72,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 27,
                              backgroundColor: AppColors.surfaceLight,
                              child: Text(widget.movie.cast[index].split(' ').map((part) => part.isNotEmpty ? part[0] : '').take(2).join(),
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(height: 7),
                            Text(widget.movie.cast[index], maxLines: 2, textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (widget.movie.isSeries && widget.movie.episodes.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    const Text('Episode', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 10),
                    ...widget.movie.episodes.map((episode) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        width: 76,
                        height: 48,
                        decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.play_circle_outline_rounded),
                      ),
                      title: Text(episode, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                      trailing: const Icon(Icons.play_arrow_rounded),
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$episode dipilih. Pemutar belum dihubungkan.')),
                      ),
                    )),
                  ],
                  const SizedBox(height: 24),
                  const Text('Kamu Mungkin Suka', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 246,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: related.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) => MovieCard(
                        movie: related[index],
                        compact: true,
                        onTap: () => widget.onMovieTap(related[index]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  const _InfoChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(7)),
      child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
    );
  }
}
