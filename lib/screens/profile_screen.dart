/// ─────────────────────────────────────────────────────────────────────────────




/// AGROKSHA AI — Profile Screen




/// User profile, settings, dark mode toggle, language switch, logout




/// ─────────────────────────────────────────────────────────────────────────────









import 'package:flutter/material.dart';




import 'package:flutter_animate/flutter_animate.dart';




import 'package:provider/provider.dart';




import '../theme/app_theme.dart';




import '../utils/app_provider.dart';




import 'login_screen.dart';









class ProfileScreen extends StatelessWidget {




  const ProfileScreen({super.key});









  @override




  Widget build(BuildContext context) {




    return Consumer<AppProvider>(




      builder: (context, provider, _) {




        final user = provider.currentUser;




        final isDark = provider.isDarkMode;









        return Scaffold(




          body: CustomScrollView(




            physics: const BouncingScrollPhysics(),




            slivers: [




              // ── Header ──




              SliverToBoxAdapter(




                child: Container(




                  decoration: const BoxDecoration(




                    gradient: AppColors.primaryGradient,




                    borderRadius: BorderRadius.only(




                      bottomLeft: Radius.circular(32),




                      bottomRight: Radius.circular(32),




                    ),




                  ),




                  child: SafeArea(




                    child: Padding(




                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),




                      child: Column(




                        children: [




                          // Avatar




                          Container(




                            width: 88,




                            height: 88,




                            decoration: BoxDecoration(




                              color: Colors.white.withValues(alpha: 0.2),




                              shape: BoxShape.circle,




                              border: Border.all(




                                color: Colors.white.withValues(alpha: 0.4),




                                width: 3,




                              ),




                            ),




                            child: const Center(




                              child: Text('👨‍🌾', style: TextStyle(fontSize: 44)),




                            ),




                          ).animate().scale(delay: 100.ms, curve: Curves.easeOutBack),









                          const SizedBox(height: 14),









                          Text(




                            user?.name ?? 'Agroksha Farmer',




                            style: const TextStyle(




                              color: Colors.white,




                              fontSize: 22,




                              fontWeight: FontWeight.w800,




                            ),




                          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3),









                          const SizedBox(height: 4),









                          Text(




                            user?.email ?? '',




                            style: TextStyle(




                              color: Colors.white.withValues(alpha: 0.75),




                              fontSize: 13,




                            ),




                          ).animate().fadeIn(delay: 300.ms),









                          const SizedBox(height: 8),









                          Container(




                            padding: const EdgeInsets.symmetric(




                                horizontal: 14, vertical: 6),




                            decoration: BoxDecoration(




                              color: Colors.white.withValues(alpha: 0.15),




                              borderRadius: BorderRadius.circular(50),




                            ),




                            child: Row(




                              mainAxisSize: MainAxisSize.min,




                              children: [




                                const Icon(Icons.location_on_rounded,




                                    color: Colors.white70, size: 14),




                                const SizedBox(width: 4),




                                Text(




                                  user?.location ?? 'Location not set',




                                  style: const TextStyle(




                                    color: Colors.white,




                                    fontSize: 12,




                                    fontWeight: FontWeight.w600,




                                  ),




                                ),




                              ],




                            ),




                          ).animate().fadeIn(delay: 400.ms),




                        ],




                      ),




                    ),




                  ),




                ),




              ),









              // ── Settings List ──




              SliverPadding(




                padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),




                sliver: SliverList(




                  delegate: SliverChildListDelegate([




                    // Stats row




                    _StatRow().animate().fadeIn(delay: 200.ms),




                    const SizedBox(height: 24),









                    // Settings group label




                    _sectionLabel('Preferences'),




                    const SizedBox(height: 10),









                    // Dark mode




                    _SettingsTile(




                      icon: isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,




                      iconBg: const Color(0xFF6C63FF),




                      title: 'Dark Mode',




                      subtitle: isDark ? 'Switch to Light mode' : 'Switch to Dark mode',




                      trailing: Switch(




                        value: isDark,




                        onChanged: (_) => provider.toggleTheme(),




                        activeThumbColor: AppColors.primary,




                      ),




                    ),









                    // Language




                    _SettingsTile(




                      icon: Icons.language_rounded,




                      iconBg: const Color(0xFF00897B),




                      title: 'Language',




                      subtitle: provider.isTeluguMode ? 'తెలుగు (Telugu)' : 'English',




                      trailing: Switch(




                        value: provider.isTeluguMode,




                        onChanged: (_) => provider.toggleLanguage(),




                        activeThumbColor: AppColors.primary,




                      ),




                    ),









                    const SizedBox(height: 16),




                    _sectionLabel('App Info'),




                    const SizedBox(height: 10),









                    _SettingsTile(




                      icon: Icons.info_outline_rounded,




                      iconBg: AppColors.primary,




                      title: 'About AGROKSHA AI',




                      subtitle: 'Version 1.0.0 • Build 1',




                      onTap: () => _showAboutDialog(context),




                    ),









                    _SettingsTile(




                      icon: Icons.privacy_tip_outlined,




                      iconBg: const Color(0xFFF57F17),




                      title: 'Privacy Policy',




                      subtitle: 'How we handle your data',




                      onTap: () {},




                    ),









                    _SettingsTile(




                      icon: Icons.support_agent_rounded,




                      iconBg: const Color(0xFF0288D1),




                      title: 'Help & Support',




                      subtitle: 'Contact our farming experts',




                      onTap: () {},




                    ),









                    const SizedBox(height: 24),









                    // Logout button




                    _LogoutButton(),




                  ]),




                ),




              ),




            ],




          ),




        );




      },




    );




  }









  Widget _sectionLabel(String label) {




    return Padding(




      padding: const EdgeInsets.only(left: 4),




      child: Text(




        label.toUpperCase(),




        style: const TextStyle(




          fontSize: 11,




          fontWeight: FontWeight.w700,




          color: AppColors.textLight,




          letterSpacing: 1.2,




        ),




      ),




    );




  }









  void _showAboutDialog(BuildContext context) {




    showDialog(




      context: context,




      builder: (_) => AlertDialog(




        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),




        title: const Text('About AGROKSHA AI'),




        content: const Text(




          'AGROKSHA AI is an intelligent farming assistant that helps Indian farmers with:\n\n'




          '• Real-time weather monitoring\n'




          '• Crop risk analysis\n'




          '• AI-powered crop recommendations\n\n'




          'Version 1.0.0 | Made with ❤️ for Indian Farmers',




        ),




        actions: [




          TextButton(




            onPressed: Navigator.of(context).pop,




            child: const Text('Close'),




          ),




        ],




      ),




    );




  }




}









// ─────────────────────────────────────────────────────────────────────────────




// Stats Row




// ─────────────────────────────────────────────────────────────────────────────




class _StatRow extends StatelessWidget {




  @override




  Widget build(BuildContext context) {




    final isDark = Theme.of(context).brightness == Brightness.dark;









    return Container(




      padding: const EdgeInsets.all(16),




      decoration: BoxDecoration(




        color: isDark ? AppColors.darkCard : Colors.white,




        borderRadius: BorderRadius.circular(18),




        boxShadow: AppTheme.cardShadow,




      ),




      child: Row(




        mainAxisAlignment: MainAxisAlignment.spaceAround,




        children: [




          _statTile('5', 'Crops Tracked', '🌾'),




          _divider(),




          _statTile('3', 'Analyses Done', '🤖'),




          _divider(),




          _statTile('AP', 'State', '📍'),




        ],




      ),




    );




  }









  Widget _statTile(String value, String label, String emoji) {




    return Column(




      mainAxisSize: MainAxisSize.min,




      children: [




        Text(emoji, style: const TextStyle(fontSize: 22)),




        const SizedBox(height: 4),




        Text(




          value,




          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),




        ),




        Text(




          label,




          style: const TextStyle(




            fontSize: 10,




            color: AppColors.textLight,




            fontWeight: FontWeight.w500,




          ),




          textAlign: TextAlign.center,




        ),




      ],




    );




  }









  Widget _divider() {




    return Container(




      height: 40,




      width: 1,




      color: AppColors.divider,




    );




  }




}









// ─────────────────────────────────────────────────────────────────────────────




// Settings Tile




// ─────────────────────────────────────────────────────────────────────────────




class _SettingsTile extends StatelessWidget {




  final IconData icon;




  final Color iconBg;




  final String title;




  final String subtitle;




  final Widget? trailing;




  final VoidCallback? onTap;









  const _SettingsTile({




    required this.icon,




    required this.iconBg,




    required this.title,




    required this.subtitle,




    this.trailing,




    this.onTap,




  });









  @override




  Widget build(BuildContext context) {




    final isDark = Theme.of(context).brightness == Brightness.dark;









    return Container(




      margin: const EdgeInsets.only(bottom: 8),




      decoration: BoxDecoration(




        color: isDark ? AppColors.darkCard : Colors.white,




        borderRadius: BorderRadius.circular(16),




        boxShadow: AppTheme.cardShadow,




      ),




      child: ListTile(




        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),




        onTap: onTap,




        leading: Container(




          width: 44,




          height: 44,




          decoration: BoxDecoration(




            color: iconBg.withValues(alpha: 0.12),




            borderRadius: BorderRadius.circular(12),




          ),




          child: Icon(icon, color: iconBg, size: 22),




        ),




        title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),




        subtitle: Text(




          subtitle,




          style: TextStyle(




            fontSize: 12,




            color: isDark ? AppColors.darkTextMedium : AppColors.textLight,




          ),




        ),




        trailing: trailing ??




            const Icon(Icons.arrow_forward_ios_rounded,




                size: 14, color: AppColors.textLight),




      ),




    );




  }




}









// ─────────────────────────────────────────────────────────────────────────────




// Logout Button




// ─────────────────────────────────────────────────────────────────────────────




class _LogoutButton extends StatelessWidget {




  @override




  Widget build(BuildContext context) {




    return Container(




      decoration: BoxDecoration(




        color: AppColors.riskHigh.withValues(alpha: 0.08),




        borderRadius: BorderRadius.circular(16),




        border: Border.all(color: AppColors.riskHigh.withValues(alpha: 0.2)),




      ),




      child: ListTile(




        onTap: () {




          showDialog(




            context: context,




            builder: (_) => AlertDialog(




              shape: RoundedRectangleBorder(




                  borderRadius: BorderRadius.circular(20)),




              title: const Text('Logout?'),




              content: const Text('Are you sure you want to logout from AGROKSHA AI AI?'),




              actions: [




                TextButton(




                  onPressed: Navigator.of(context).pop,




                  child: const Text('Cancel'),




                ),




                ElevatedButton(




                  onPressed: () {




                    context.read<AppProvider>().logout();




                    Navigator.of(context).pushAndRemoveUntil(




                      MaterialPageRoute(




                        builder: (_) => const LoginScreen(),




                      ),




                      (route) => false,




                    );




                  },




                  style: ElevatedButton.styleFrom(




                    backgroundColor: AppColors.riskHigh,




                  ),




                  child: const Text('Logout'),




                ),




              ],




            ),




          );




        },




        leading: Container(




          width: 44,




          height: 44,




          decoration: BoxDecoration(




            color: AppColors.riskHigh.withValues(alpha: 0.1),




            borderRadius: BorderRadius.circular(12),




          ),




          child: const Icon(Icons.logout_rounded, color: AppColors.riskHigh, size: 22),




        ),




        title: const Text(




          'Logout',




          style: TextStyle(




            color: AppColors.riskHigh,




            fontWeight: FontWeight.w700,




            fontSize: 14,




          ),




        ),




        subtitle: const Text(




          'Sign out from your account',




          style: TextStyle(fontSize: 12, color: AppColors.textLight),




        ),




      ),




    );




  }




}




