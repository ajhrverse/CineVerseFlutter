import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppHeader extends StatelessWidget {
  final VoidCallback onSearchTap;
  final VoidCallback onNotificationTap;
  final VoidCallback onProfileTap;
  final VoidCallback onMenuTap;

  const AppHeader({
    super.key,
    required this.onSearchTap,
    required this.onNotificationTap,
    required this.onProfileTap,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 12),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Buka menu',
            onPressed: onMenuTap,
            icon: const Icon(Icons.menu_rounded),
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 29),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CineVerse',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: -0.5),
                ),
                Text(
                  'Cerita yang tinggal bersamamu',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Cari film',
            onPressed: onSearchTap,
            icon: const Icon(Icons.search_rounded),
          ),
          IconButton(
            tooltip: 'Notifikasi',
            onPressed: onNotificationTap,
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          GestureDetector(
            onTap: onProfileTap,
            child: const CircleAvatar(
              radius: 17,
              backgroundColor: Color(0xFF34394D),
              child: Icon(Icons.person_rounded, size: 20, color: Colors.white),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}
