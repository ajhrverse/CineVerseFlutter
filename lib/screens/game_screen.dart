import 'package:flutter/material.dart';
import '../data/dummy_movies.dart';
import '../theme/app_theme.dart';

class GameScreen extends StatefulWidget {
  final ValueChanged<String> onGameTap;
  const GameScreen({super.key, required this.onGameTap});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String _selectedCategory = 'Semua';
  final categories = const ['Semua', 'Action', 'Racing', 'Strategy', 'Adventure', 'Sports', 'Puzzle'];

  IconData _iconFor(String name) {
    switch (name) {
      case 'sports_motorsports': return Icons.sports_motorsports_rounded;
      case 'gps_fixed': return Icons.gps_fixed_rounded;
      case 'castle': return Icons.castle_rounded;
      case 'videogame_asset': return Icons.videogame_asset_rounded;
      case 'sports_soccer': return Icons.sports_soccer_rounded;
      default: return Icons.auto_awesome_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final games = dummyGames.where((game) => _selectedCategory == 'Semua' || game['category'] == _selectedCategory).toList();
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      children: [
        const Text('Mainkan sesuatu yang seru', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        const Text('Temukan hiburan interaktif pilihan.', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        const SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            hintText: 'Cari game...',
            prefixIcon: const Icon(Icons.search_rounded),
            filled: true,
            fillColor: AppColors.surface,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
          ),
          onChanged: (value) => setState(() {}),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final category = categories[index];
              final selected = _selectedCategory == category;
              return ChoiceChip(
                label: Text(category),
                selected: selected,
                onSelected: (_) => setState(() => _selectedCategory = category),
                selectedColor: AppColors.accent,
                backgroundColor: AppColors.surface,
                side: BorderSide(color: selected ? AppColors.accent : AppColors.border),
                labelStyle: TextStyle(fontSize: 11, color: Colors.white, fontWeight: selected ? FontWeight.bold : FontWeight.normal),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: games.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.84,
          ),
          itemBuilder: (context, index) {
            final game = games[index];
            final color = Color(game['color'] as int);
            return InkWell(
              onTap: () => widget.onGameTap(game['title'] as String),
              borderRadius: BorderRadius.circular(18),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [color.withValues(alpha: 0.9), color.withValues(alpha: 0.18), AppColors.surface],
                          ),
                        ),
                        child: Icon(_iconFor(game['icon'] as String), size: 58, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(game['title'] as String, maxLines: 1, overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
                          const SizedBox(height: 4),
                          Text(game['description'] as String, maxLines: 2, overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: AppColors.textSecondary, fontSize: 10, height: 1.3)),
                          const SizedBox(height: 8),
                          Text(game['category'] as String, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        if (games.isEmpty)
          const Padding(
            padding: EdgeInsets.all(30),
            child: Center(child: Text('Tidak ada game pada kategori ini.')),
          ),
      ],
    );
  }
}
