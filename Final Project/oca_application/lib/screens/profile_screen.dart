import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_theme.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../widgets/confirm_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();
    final user = auth.currentUser;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.accent],
              ),
              borderRadius: BorderRadius.circular(44),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Text(
                (user?.name ?? 'U')[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user?.name ?? 'User',
            style: AppTextStyles.headlineMedium,
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _getRoleLabel(user?.role),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 28),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: AppShadows.card,
            ),
            child: Column(
              children: [
                _ProfileTile(
                  icon: Icons.person_outline_rounded,
                  title: 'Username',
                  value: user?.username ?? '',
                  topBorder: true,
                ),
                const Divider(height: 1, indent: 56),
                _ProfileTile(
                  icon: Icons.shield_outlined,
                  title: 'Role',
                  value: _getRoleLabel(user?.role),
                ),
                if (user?.rpagId != null) ...[
                  const Divider(height: 1, indent: 56),
                  _ProfileTile(
                    icon: Icons.groups_rounded,
                    title: 'Assigned RPAG',
                    value: _getRpagName(user!.rpagId!),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: AppShadows.card,
            ),
              child: Column(
              children: [
                const _ProfileTile(
                  icon: Icons.info_outline_rounded,
                  title: 'App Version',
                  value: '1.0.0',
                  topBorder: true,
                ),
                const Divider(height: 1, indent: 56),
                const _ProfileTile(
                  icon: Icons.palette_outlined,
                  title: 'Application',
                  value: 'OCA Management System',
                ),
                const Divider(height: 1, indent: 56),
                const _ProfileTile(
                  icon: Icons.school_rounded,
                  title: 'Campus',
                  value: 'Alangilan Campus',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton.icon(
              onPressed: () async {
                final confirmed = await ConfirmDialog.show(
                  context,
                  title: 'Sign Out',
                  message: 'Are you sure you want to sign out of your account?',
                  confirmLabel: 'Sign Out',
                  icon: Icons.logout_rounded,
                  confirmColor: AppColors.primary,
                );
                if (confirmed && context.mounted) {
                  auth.logout();
                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
                }
              },
              icon: const Icon(Icons.logout_rounded),
              label: const Text('Sign Out'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  String _getRoleLabel(dynamic role) {
    if (role == null) return '';
    switch (role) {
      case UserRole.admin:
        return 'Administrator';
      case UserRole.trainor:
        return 'Trainor';
      case UserRole.president:
        return 'President';
      default:
        return '';
    }
  }

  String _getRpagName(String rpagId) {
    switch (rpagId) {
      case 'rpag_1':
        return 'Diwayanis Dance Theater';
      case 'rpag_2':
        return 'Indak Yaman Dance Varsity';
      case 'rpag_3':
        return 'Adlibitum Chorus';
      case 'rpag_4':
        return 'Dulaang Batangan';
      case 'rpag_5':
        return 'Sikha';
      default:
        return 'Unknown';
    }
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool topBorder;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.value,
    this.topBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: AppColors.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.caption),
                const SizedBox(height: 2),
                Text(value, style: AppTextStyles.bodyMedium),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.textHint),
        ],
      ),
    );
  }
}
