import 'package:flutter/material.dart';
import '../data/dummy_movies.dart';
import '../models/movie.dart';
import '../theme/app_theme.dart';
import '../widgets/app_header.dart';
import 'download_screen.dart';
import 'game_screen.dart';
import 'home_screen.dart';
import 'movie_detail_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Set<String> _downloadedIds = {'m3'};
  final Set<String> _favoriteIds = {'m1'};

  void _openMovie(Movie movie) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MovieDetailScreen(
          movie: movie,
          isFavoriteInitially: _favoriteIds.contains(movie.id),
          isDownloadedInitially: _downloadedIds.contains(movie.id),
          onFavoriteChanged: (favorite) {
            setState(() {
              favorite ? _favoriteIds.add(movie.id) : _favoriteIds.remove(movie.id);
            });
          },
          onDownloadChanged: (downloaded) {
            setState(() {
              downloaded ? _downloadedIds.add(movie.id) : _downloadedIds.remove(movie.id);
            });
          },
          onMovieTap: _openMovie,
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _openSearch() async {
    final result = await showSearch<Movie>(
      context: context,
      delegate: _MovieSearchDelegate(dummyMovies),
    );
    if (result != null && mounted) _openMovie(result);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        onMovieTap: _openMovie,
        onPlayTap: (movie) => _showMessage('Pemutar untuk "${movie.title}" belum dihubungkan.'),
      ),
      GameScreen(onGameTap: (title) => _showMessage('$title dipilih.')),
      DownloadScreen(
        movies: dummyMovies.where((movie) => _downloadedIds.contains(movie.id)).toList(),
        onMovieTap: _openMovie,
        onRemove: (movie) {
          setState(() => _downloadedIds.remove(movie.id));
          _showMessage('${movie.title} dihapus dari daftar unduhan.');
        },
        onPlay: (movie) => _showMessage('Pemutar untuk "${movie.title}" belum dihubungkan.'),
      ),
      ProfileScreen(onAction: _showMessage),
    ];

    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildLeftDrawer(),
      endDrawer: _buildRightDrawer(),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            if (_selectedIndex == 0)
              AppHeader(
                onSearchTap: _openSearch,
                onNotificationTap: () => _showMessage('Belum ada notifikasi baru.'),
                onProfileTap: () => _scaffoldKey.currentState?.openEndDrawer(),
                onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
              )
            else
              _SimpleTopBar(
                title: ['Beranda', 'Game', 'Download Saya', 'Profil'][_selectedIndex],
                onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
                onProfileTap: () => _scaffoldKey.currentState?.openEndDrawer(),
              ),
            Expanded(
              child: IndexedStack(index: _selectedIndex, children: pages),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Beranda'),
          NavigationDestination(icon: Icon(Icons.sports_esports_outlined), selectedIcon: Icon(Icons.sports_esports_rounded), label: 'Game'),
          NavigationDestination(icon: Icon(Icons.download_outlined), selectedIcon: Icon(Icons.download_rounded), label: 'Download'),
          NavigationDestination(icon: Icon(Icons.person_outline_rounded), selectedIcon: Icon(Icons.person_rounded), label: 'Profil'),
        ],
      ),
    );
  }

  Widget _buildLeftDrawer() {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            const CircleAvatar(
              radius: 36,
              backgroundColor: Color(0xFF34394D),
              child: Icon(Icons.person_rounded, size: 40),
            ),
            const SizedBox(height: 12),
            const Text('Ajhar Viewer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            const Text('viewer@cineverse.app', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            const SizedBox(height: 24),
            const Divider(color: AppColors.border),
            _drawerItem(Icons.person_outline, 'Akun', () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 3);
            }),
            _drawerItem(Icons.settings_outlined, 'Pengaturan', () {
              Navigator.pop(context);
              _showMessage('Pengaturan akan tersedia di pengembangan berikutnya.');
            }),
            _drawerItem(Icons.help_outline_rounded, 'Bantuan', () {
              Navigator.pop(context);
              _showMessage('Pusat bantuan CineVerse.');
            }),
            _drawerItem(Icons.info_outline_rounded, 'Tentang aplikasi', () {
              Navigator.pop(context);
              _showMessage('CineVerse UI prototype • v1.0.0');
            }),
            const Spacer(),
            _drawerItem(Icons.logout_rounded, 'Keluar', () {
              Navigator.pop(context);
              _showMessage('Simulasi keluar akun.');
            }),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildRightDrawer() {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 12),
            const Text('Profil Cepat', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 22),
            const Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Color(0xFF34394D),
                  child: Icon(Icons.person_rounded, size: 32),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ajhar Viewer', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('Paket Standard', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            const Divider(color: AppColors.border),
            _drawerItem(Icons.switch_account_rounded, 'Ganti profil', () {
              Navigator.pop(context);
              _showMessage('Pemilihan profil masih berupa simulasi.');
            }),
            _drawerItem(Icons.language_rounded, 'Bahasa: Indonesia', () {
              Navigator.pop(context);
              _showMessage('Bahasa saat ini: Indonesia.');
            }),
            _drawerItem(Icons.dark_mode_outlined, 'Preferensi tampilan', () {
              Navigator.pop(context);
              _showMessage('Tema gelap sedang aktif.');
            }),
            _drawerItem(Icons.manage_accounts_outlined, 'Pengaturan akun', () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 3);
            }),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _showMessage('Simulasi keluar akun.');
              },
              icon: const Icon(Icons.logout_rounded),
              label: const Text('Keluar'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: AppColors.border),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondary),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18),
    );
  }
}

class _SimpleTopBar extends StatelessWidget {
  final String title;
  final VoidCallback onMenuTap;
  final VoidCallback onProfileTap;

  const _SimpleTopBar({
    required this.title,
    required this.onMenuTap,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 18, 8),
      child: Row(
        children: [
          IconButton(onPressed: onMenuTap, icon: const Icon(Icons.menu_rounded)),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800))),
          IconButton(onPressed: onProfileTap, icon: const Icon(Icons.account_circle_outlined)),
        ],
      ),
    );
  }
}

class _MovieSearchDelegate extends SearchDelegate<Movie> {
  final List<Movie> movies;
  _MovieSearchDelegate(this.movies);

  @override
  String get searchFieldLabel => 'Cari film atau serial';

  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context).copyWith(
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.surface),
    inputDecorationTheme: const InputDecorationTheme(border: InputBorder.none),
  );

  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear_rounded)),
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    onPressed: () => Navigator.of(context).pop(),
    icon: const Icon(Icons.arrow_back_rounded),
  );

  @override
  Widget buildResults(BuildContext context) => _results();

  @override
  Widget buildSuggestions(BuildContext context) => _results();

  Widget _results() {
    final matches = movies.where((movie) => movie.title.toLowerCase().contains(query.toLowerCase())).toList();
    if (matches.isEmpty) {
      return const Center(child: Text('Film tidak ditemukan', style: TextStyle(color: AppColors.textSecondary)));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: matches.length,
      separatorBuilder: (_, __) => const Divider(color: AppColors.border),
      itemBuilder: (context, index) {
        final movie = matches[index];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              movie.posterUrl,
              width: 48,
              height: 66,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox(width: 48, child: Icon(Icons.movie_outlined)),
            ),
          ),
          title: Text(movie.title),
          subtitle: Text('${movie.year} • ${movie.genre}'),
          onTap: () => close(context, movie),
        );
      },
    );
  }
}
