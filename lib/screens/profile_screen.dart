import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  final ValueChanged<String> onAction;
  const ProfileScreen({super.key, required this.onAction});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      children: [
        const Text('Profil Saya', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800)),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF292D43), AppColors.surface],
            ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 42,
                    backgroundColor: Color(0xFF454B65),
                    child: Icon(Icons.person_rounded, size: 48),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                      child: const Icon(Icons.edit_rounded, size: 13),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Text('Ajhar Viewer', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              const SizedBox(height: 5),
              const Text('viewer@cineverse.app', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () => onAction('Edit profil masih berupa simulasi.'),
                icon: const Icon(Icons.edit_outlined, size: 17),
                label: const Text('Edit Profil'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: AppColors.border),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text('PENGATURAN AKUN', style: TextStyle(fontSize: 11, letterSpacing: 1.2, fontWeight: FontWeight.w800, color: AppColors.textSecondary)),
        const SizedBox(height: 10),
        _ProfileTile(icon: Icons.workspace_premium_outlined, title: 'Paket langganan', subtitle: 'Standard', onTap: () => onAction('Informasi paket langganan.')),
        _ProfileTile(icon: Icons.language_rounded, title: 'Bahasa aplikasi', subtitle: 'Indonesia', onTap: () => onAction('Bahasa: Indonesia.')),
        _ProfileTile(icon: Icons.notifications_none_rounded, title: 'Notifikasi', subtitle: 'Atur pemberitahuan', onTap: () => onAction('Pengaturan notifikasi.')),
        _ProfileTile(icon: Icons.shield_outlined, title: 'Privasi dan keamanan', subtitle: 'Kelola preferensi akun', onTap: () => onAction('Pengaturan privasi.')),
        _ProfileTile(icon: Icons.help_outline_rounded, title: 'Pusat bantuan', subtitle: 'Kami siap membantu', onTap: () => onAction('Pusat bantuan CineVerse.')),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () => onAction('Simulasi keluar akun.'),
          icon: const Icon(Icons.logout_rounded),
          label: const Text('Keluar'),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFFFF7585),
            side: const BorderSide(color: Color(0xFF57303A)),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
        const SizedBox(height: 16),
        const Center(child: Text('CineVerse • Versi 1.0.0', style: TextStyle(fontSize: 10, color: AppColors.textSecondary))),
      ],
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      leading: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: AppColors.textSecondary),
      ),
      title: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
    );
  }
}
