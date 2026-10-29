import 'package:flutter/material.dart';

void main() {
  runApp(const NavigationApp());
}

// ============================================================
// 1. KONFIGURASI APLIKASI
// ============================================================

class NavigationApp extends StatelessWidget {
  const NavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Structure',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFF9FB),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE75480),
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
      ),
      home: const NavigationHomePage(),
    );
  }
}

// ============================================================
// 2. MODEL MENU
// ============================================================

class NavigationMenu {
  final String title;
  final IconData icon;

  const NavigationMenu({
    required this.title,
    required this.icon,
  });
}

// ============================================================
// 3. HALAMAN UTAMA
// ============================================================

class NavigationHomePage extends StatefulWidget {
  const NavigationHomePage({super.key});

  @override
  State<NavigationHomePage> createState() =>
      _NavigationHomePageState();
}

class _NavigationHomePageState extends State<NavigationHomePage> {
  String? selectedMenu;

  final TextEditingController searchController =
      TextEditingController();

  final List<NavigationMenu> bottomMenus = const [
    NavigationMenu(title: 'Beranda', icon: Icons.home_rounded),
    NavigationMenu(title: 'Game', icon: Icons.sports_esports_rounded),
    NavigationMenu(title: 'Download', icon: Icons.download_rounded),
    NavigationMenu(title: 'Profil', icon: Icons.person_rounded),
  ];

  final List<NavigationMenu> detailMenus = const [
    NavigationMenu(title: 'Detail Film', icon: Icons.info_rounded),
    NavigationMenu(title: 'Episode', icon: Icons.play_circle_rounded),
    NavigationMenu(title: 'Pemain', icon: Icons.people_rounded),
    NavigationMenu(title: 'Rekomendasi', icon: Icons.groups_rounded),
  ];

  final List<NavigationMenu> drawerMenus = const [
    NavigationMenu(title: 'Akun', icon: Icons.person_rounded),
    NavigationMenu(title: 'Pengaturan', icon: Icons.settings_rounded),
    NavigationMenu(title: 'Bantuan', icon: Icons.help_rounded),
    NavigationMenu(title: 'Keluar', icon: Icons.logout_rounded),
  ];

  final List<NavigationMenu> endDrawerMenus = const [
    NavigationMenu(
      title: 'Ganti Profil',
      icon: Icons.account_circle_rounded,
    ),
    NavigationMenu(title: 'Bahasa', icon: Icons.language_rounded),
    NavigationMenu(
      title: 'Keluar',
      icon: Icons.power_settings_new_rounded,
    ),
  ];

  void selectMenu(String title) {
    setState(() {
      selectedMenu = title;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Menu "$title" dipilih'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        searchController: searchController,
        onNotificationTap: () {
          selectMenu('Notifikasi');
        },
      ),

      // Menu samping kiri.
      drawer: _buildDrawer(),

      // Menu samping kanan.
      endDrawer: _buildEndDrawer(),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Struktur Navigasi',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF29243D),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Visualisasi struktur navigasi aplikasi',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF817C8D),
                ),
              ),

              const SizedBox(height: 28),

              // Panel navigasi menyesuaikan lebar layar.
              LayoutBuilder(
                builder: (context, constraints) {
                  final double width = constraints.maxWidth;

                  final int columnCount;

                  if (width >= 1100) {
                    columnCount = 4;
                  } else if (width >= 600) {
                    columnCount = 2;
                  } else {
                    columnCount = 1;
                  }

                  const double spacing = 18;

                  final double panelWidth =
                      (width -
                          spacing * (columnCount - 1)) /
                      columnCount;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: [
                      SizedBox(
                        width: panelWidth,
                        child: NavigationPanel(
                          title: 'NavigationBar',
                          subtitle: 'Navigasi utama',
                          icon: Icons.dashboard_rounded,
                          color: const Color(0xFFE75480),
                          backgroundColor: const Color(0xFFFFF0F5),
                          menus: bottomMenus,
                          selectedMenu: selectedMenu,
                          onMenuTap: selectMenu,
                        ),
                      ),

                      SizedBox(
                        width: panelWidth,
                        child: NavigationPanel(
                          title: 'Stack Navigation',
                          subtitle: 'Detail film dan serial',
                          icon: Icons.movie_rounded,
                          color: const Color(0xFF3985E8),
                          backgroundColor: const Color(0xFFEEF5FF),
                          menus: detailMenus,
                          selectedMenu: selectedMenu,
                          onMenuTap: selectMenu,
                        ),
                      ),

                      SizedBox(
                        width: panelWidth,
                        child: NavigationPanel(
                          title: 'Drawer',
                          subtitle: 'Menu samping',
                          icon: Icons.menu_rounded,
                          color: const Color(0xFF8960D8),
                          backgroundColor: const Color(0xFFF5F0FF),
                          menus: drawerMenus,
                          selectedMenu: selectedMenu,
                          onMenuTap: selectMenu,
                        ),
                      ),

                      SizedBox(
                        width: panelWidth,
                        child: NavigationPanel(
                          title: 'EndDrawer',
                          subtitle: 'Menu profil',
                          icon: Icons.account_circle_rounded,
                          color: const Color(0xFFF39A42),
                          backgroundColor: const Color(0xFFFFF5E9),
                          menus: endDrawerMenus,
                          selectedMenu: selectedMenu,
                          onMenuTap: selectMenu,
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 28),

              // Keterangan tambahan.
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFEDE7F0),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.touch_app_rounded,
                      color: Color(0xFF8960D8),
                      size: 28,
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Interaksi Navigasi',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF29243D),
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            selectedMenu == null
                                ? 'Pilih salah satu menu untuk melihat interaksi.'
                                : 'Menu aktif: $selectedMenu',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF817C8D),
                            ),
                          ),
                        ],
                      ),
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

  // ==========================================================
  // DRAWER KIRI
  // ==========================================================

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFFFFF9FB),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFFF5F0FF),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.dashboard_rounded,
                    color: Color(0xFF8960D8),
                    size: 40,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Menu Navigasi',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Akses menu aplikasi',
                    style: TextStyle(
                      color: Color(0xFF817C8D),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: drawerMenus.map((menu) {
                  return ListTile(
                    leading: Icon(menu.icon),
                    title: Text(menu.title),
                    selected: selectedMenu == menu.title,
                    selectedTileColor: const Color(0xFFF5F0FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      selectMenu(menu.title);
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // END DRAWER KANAN
  // ==========================================================

  Widget _buildEndDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFFFFF9FB),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFFFFF5E9),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFFF39A42),
                    child: Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Menu Profil',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Pengaturan profil aplikasi',
                    style: TextStyle(
                      color: Color(0xFF817C8D),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: endDrawerMenus.map((menu) {
                  return ListTile(
                    leading: Icon(menu.icon),
                    title: Text(menu.title),
                    selected: selectedMenu == menu.title,
                    selectedTileColor: const Color(0xFFFFF0DC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      selectMenu(menu.title);
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 4. HEADER APLIKASI
// ============================================================

class AppHeader extends StatelessWidget
    implements PreferredSizeWidget {
  final TextEditingController searchController;
  final VoidCallback onNotificationTap;

  const AppHeader({
    super.key,
    required this.searchController,
    required this.onNotificationTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFFFFE7EF),
      surfaceTintColor: Colors.transparent,
      elevation: 0,

      titleSpacing: 20,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
        side: BorderSide(
          color: Color(0xFFE75480),
          width: 1.2,
        ),
      ),

      title: Row(
        children: [
          // Logo aplikasi.
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFFE75480),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.movie_filter_rounded,
              color: Colors.white,
              size: 27,
            ),
          ),

          const SizedBox(width: 12),

          // Judul aplikasi.
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'NaviSpace',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF29243D),
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Navigation System',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF817C8D),
                ),
              ),
            ],
          ),

          const SizedBox(width: 24),

          // Kolom pencarian menyesuaikan ruang tersedia.
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 420,
              ),
              child: SizedBox(
                height: 44,
                child: TextField(
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Cari menu...',
                    hintStyle: const TextStyle(
                      color: Color(0xFF9B94A5),
                      fontSize: 13,
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      size: 21,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFFF3C6D5),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFFE75480),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Tombol notifikasi.
          IconButton(
            tooltip: 'Notifikasi',
            onPressed: onNotificationTap,
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFFE75480),
              fixedSize: const Size(44, 44),
            ),
            icon: const Icon(
              Icons.notifications_none_rounded,
              size: 24,
            ),
          ),

          // Tombol membuka EndDrawer.
          const SizedBox(width: 4),

          Builder(
            builder: (buttonContext) {
              return IconButton(
                tooltip: 'Menu profil',
                onPressed: () {
                  Scaffold.of(buttonContext).openEndDrawer();
                },
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF29243D),
                  fixedSize: const Size(44, 44),
                ),
                icon: const Icon(
                  Icons.account_circle_outlined,
                  size: 25,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 5. PANEL NAVIGASI YANG DAPAT DIGUNAKAN KEMBALI
// ============================================================

class NavigationPanel extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final List<NavigationMenu> menus;
  final String? selectedMenu;
  final ValueChanged<String> onMenuTap;

  const NavigationPanel({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.backgroundColor,
    required this.menus,
    required this.selectedMenu,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(22),

        border: Border.all(
          color: color,
          width: 1.4,
        ),

        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.10),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header panel.
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 23,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF817C8D),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Garis pemisah.
          Container(
            height: 1,
            color: color.withValues(alpha: 0.22),
          ),

          const SizedBox(height: 12),

          // Daftar menu.
          ...menus.map((menu) {
            return NavigationMenuItem(
              menu: menu,
              color: color,
              selected: selectedMenu == menu.title,
              onTap: () => onMenuTap(menu.title),
            );
          }),
        ],
      ),
    );
  }
}

// ============================================================
// 6. ITEM MENU
// ============================================================

class NavigationMenuItem extends StatelessWidget {
  final NavigationMenu menu;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const NavigationMenuItem({
    super.key,
    required this.menu,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),

      child: Material(
        color: selected
            ? color.withValues(alpha: 0.12)
            : Colors.white.withValues(alpha: 0.75),

        borderRadius: BorderRadius.circular(13),

        child: InkWell(
          onTap: onTap,

          borderRadius: BorderRadius.circular(13),

          child: Container(
            constraints: const BoxConstraints(
              minHeight: 46,
            ),

            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),

              border: Border.all(
                color: selected
                    ? color
                    : color.withValues(alpha: 0.12),
                width: selected ? 1.3 : 0.8,
              ),
            ),

            child: Row(
              children: [
                Icon(
                  menu.icon,
                  size: 20,
                  color: color,
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    menu.title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: selected
                          ? FontWeight.bold
                          : FontWeight.w500,
                      color: const Color(0xFF393347),
                    ),
                  ),
                ),

                if (selected)
                  Icon(
                    Icons.check_circle_rounded,
                    size: 17,
                    color: color,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}