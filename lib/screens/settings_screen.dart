/// ─────────────────────────────────────────────────────────────────────────────









/// AGROKSHA AI  Settings Screen v2









/// Language, Dark Mode, Location, About, Logout









/// ─────────────────────────────────────────────────────────────────────────────



















import 'package:flutter/material.dart';









import 'package:flutter_animate/flutter_animate.dart';









import 'package:provider/provider.dart';









import '../theme/app_theme.dart';









import '../utils/app_provider.dart';
import 'edit_profile_screen.dart';









import '../models/models.dart';









import '../services/voice_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';









import 'location_setup_screen.dart';









import 'login_screen.dart';









import 'about_screen.dart';









import 'privacy_policy_screen.dart';









import 'terms_screen.dart';









import 'tech_partners_screen.dart';









import 'farm_id_screen.dart';









import 'package:qr_flutter/qr_flutter.dart';









import 'dart:convert';









import 'dart:math';



















class SettingsScreen extends StatelessWidget {









  const SettingsScreen({super.key});



















  @override









  Widget build(BuildContext context) {









    final provider = context.watch<AppProvider>();









    final isDark = provider.isDarkMode;









    final lang = provider.langCode;



















    return Scaffold(









      body: CustomScrollView(









        physics: const BouncingScrollPhysics(),









        slivers: [









          // App bar header









          SliverAppBar(









            pinned: true,









            expandedHeight: 140,









            backgroundColor: AppColors.primary,









            flexibleSpace: FlexibleSpaceBar(









              background: Container(









                decoration: const BoxDecoration(gradient: AppColors.heroGradient),









                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),









                alignment: Alignment.bottomLeft,









                child: SafeArea(









                  child: Column(









                    mainAxisAlignment: MainAxisAlignment.end,









                    crossAxisAlignment: CrossAxisAlignment.start,









                    children: [









                      const Text(









                        '⚙️? Settings',









                        style: TextStyle(









                          color: Colors.white,









                          fontSize: 26,









                          fontWeight: FontWeight.w800,









                        ),









                      ),









                      const SizedBox(height: 4),









                      Text(









                        translate(S.tagline, lang),









                        style: TextStyle(









                          color: Colors.white.withValues(alpha: 0.75),









                          fontSize: 13,









                        ),









                      ),









                    ],









                  ),









                ),









              ),









            ),









          ),



















          SliverPadding(









            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),









            sliver: SliverList(









              delegate: SliverChildListDelegate([









                // Profile card









                _ProfileCard(provider: provider),









                const SizedBox(height: 16),



















                // Farm ID QR Card









                _FarmIdQrCard(provider: provider),









                const SizedBox(height: 24),



















                // Location section









                _SectionTitle(title: '�? ${translate(S.currentLocation, lang)}'),









                const SizedBox(height: 10),









                _LocationTile(provider: provider),









                const SizedBox(height: 24),



















                // Language section









                _SectionTitle(title: '�? ${translate(S.language, lang)}'),









                const SizedBox(height: 10),









                _LanguageSelector(provider: provider),









                const SizedBox(height: 24),



















                // Theme section









                _SectionTitle(title: '🎨 Appearance'),









                const SizedBox(height: 10),









                _SettingsTile(









                  icon: provider.isDarkMode









                      ? Icons.light_mode_rounded









                      : Icons.dark_mode_rounded,









                  title: translate(S.darkMode, lang),









                  subtitle: provider.isDarkMode ? 'Dark mode is ON' : 'Light mode is ON',









                  trailing: Switch(









                    value: provider.isDarkMode,









                    onChanged: (_) => provider.toggleTheme(),









                    activeTrackColor: AppColors.primary,









                  ),









                ),









                const SizedBox(height: 24),



















                // Voice Settings Section









                _SectionTitle(title: '🎙️? Voice & Audio'),









                const SizedBox(height: 10),









                _SettingsTile(









                  icon: Icons.volume_off_rounded,









                  title: 'Mute Auto Greetings',









                  subtitle: provider.muteGreetings ? 'Greetings are muted' : 'Will speak on app open',









                  trailing: Switch(









                    value: provider.muteGreetings,









                    onChanged: (_) => provider.toggleMuteGreetings(),









                    activeTrackColor: AppColors.primary,









                  ),









                ),









                const SizedBox(height: 4),









                _SettingsTile(









                  icon: Icons.speed_rounded,









                  title: 'Voice Speed',









                  subtitle: provider.voiceSpeed == 0 ? 'Slow  for clear listening' : provider.voiceSpeed == 1 ? 'Normal  recommended' : 'Fast',









                  trailing: DropdownButton<int>(









                    value: provider.voiceSpeed,









                    underline: const SizedBox(),









                    items: const [









                      DropdownMenuItem(value: 0, child: Text('Slow', style: TextStyle(fontSize: 13))),









                      DropdownMenuItem(value: 1, child: Text('Normal', style: TextStyle(fontSize: 13))),









                      DropdownMenuItem(value: 2, child: Text('Fast', style: TextStyle(fontSize: 13))),









                    ],









                    onChanged: (val) {









                      if (val != null) provider.setVoiceSpeed(val);









                    },









                  ),









                ),









                const SizedBox(height: 4),









                _VoiceSelectorTile(provider: provider),









                const SizedBox(height: 4),









                _TestVoiceButton(provider: provider),









                const SizedBox(height: 24),



















                // About section









                _SectionTitle(title: 'ℹ️? ${translate(S.about, lang)}'),









                const SizedBox(height: 10),









                _SettingsTile(









                  icon: Icons.agriculture_rounded,









                  title: 'About AGROKSHA AI',









                  subtitle: translate(S.tagline, lang),









                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),









                  onTap: () {









                    Navigator.push(









                      context,









                      MaterialPageRoute(builder: (_) => const AboutScreen()),









                    );









                  },









                ),









                const SizedBox(height: 4),









                _SettingsTile(









                  icon: Icons.shield_rounded,









                  title: 'Privacy Policy',









                  subtitle: 'Data security & usage',









                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),









                  onTap: () {









                    Navigator.push(









                      context,









                      MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),









                    );









                  },









                ),









                const SizedBox(height: 4),









                _SettingsTile(









                  icon: Icons.gavel_rounded,









                  title: 'Terms & Conditions',









                  subtitle: 'Usage terms & legal',









                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),









                  onTap: () {









                    Navigator.push(









                      context,









                      MaterialPageRoute(builder: (_) => const TermsScreen()),









                    );









                  },









                ),









                const SizedBox(height: 4),









                _SettingsTile(









                  icon: Icons.hub_rounded,









                  title: 'Technology Partners',









                  subtitle: 'APIs & frameworks used',









                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),









                  onTap: () {









                    Navigator.push(









                      context,









                      MaterialPageRoute(builder: (_) => const TechPartnersScreen()),









                    );









                  },









                ),









                const SizedBox(height: 24),



















                // Logout









                if (provider.isLoggedIn)









                  _LogoutButton(provider: provider),









                const SizedBox(height: 12),



















                // Credits









                Center(









                  child: Text(









                    '${translate(S.devTeam, lang)}  ${translate(S.appVersion, lang)}',









                    style: const TextStyle(









                      fontSize: 11,









                      color: AppColors.textLight,









                    ),









                  ),









                ),









              ]),









            ),









          ),









        ],









      ),









    );









  }









}




















void _showEditProfileDialog(BuildContext context) {
  final provider = context.read<AppProvider>();
  final nameCtrl = TextEditingController(text: provider.currentUser?.name ?? '');
  final cropCtrl = TextEditingController(text: provider.selectedCrop);
  final acresCtrl = TextEditingController(text: provider.currentUser?.farmSize?.replaceAll(' acres', '') ?? '');
  final pastCropsCtrl = TextEditingController(text: provider.currentUser?.pastCrops.join(', ') ?? '');
  
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Row(
        children: [
          Text('🧑‍🌾', style: TextStyle(fontSize: 24)),
          SizedBox(width: 8),
          Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(
                labelText: 'Farmer Name',
                prefixIcon: const Icon(Icons.person_rounded),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: cropCtrl,
              decoration: InputDecoration(
                labelText: 'Primary Crop',
                prefixIcon: const Icon(Icons.grass_rounded),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: acresCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Farm Size (Acres)',
                prefixIcon: const Icon(Icons.landscape_rounded),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: pastCropsCtrl,
              decoration: InputDecoration(
                labelText: 'Past Crops (comma separated)',
                prefixIcon: const Icon(Icons.history_rounded),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            final name = nameCtrl.text.trim();
            final crop = cropCtrl.text.trim();
            final acres = acresCtrl.text.trim();
            final pastCropsStr = pastCropsCtrl.text.trim();
            
            final pastCrops = pastCropsStr.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
            
            provider.updateProfileDetails(
              name: name.isNotEmpty ? name : null,
              crop: crop.isNotEmpty ? crop : null,
              farmSize: acres.isNotEmpty ? '$acres acres' : null,
              pastCrops: pastCrops,
            );
            
            Navigator.pop(ctx);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile updated successfully!'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
          },
          child: const Text('Save Changes'),
        ),
      ],
    ),
  );
}

/// Profile card with user info









class _ProfileCard extends StatefulWidget {









  final AppProvider provider;









  const _ProfileCard({required this.provider});

  @override
  State<_ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<_ProfileCard> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final path = widget.provider.currentUser?.profileImagePath;
    if (path != null && path.isNotEmpty) {
      _profileImage = File(path);
    }
  }

  Future<void> _pickProfileImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 75);
    if (picked != null && mounted) {
      setState(() => _profileImage = File(picked.path));
      widget.provider.updateProfileDetails(imagePath: picked.path);
    }
  }

  void _showEditDialog() {
    _showEditProfileDialog(context);
  }




















  @override









  Widget build(BuildContext context) {









    final provider = widget.provider;
    final isDark = Theme.of(context).brightness == Brightness.dark;









    final name = provider.currentUser?.name ?? 'Agroksha Farmer';









    final location = provider.farmerLocation?.displayShort ?? 'Location not set';



















    return Container(









      padding: const EdgeInsets.all(20),









      decoration: BoxDecoration(









        gradient: AppColors.primaryGradient,









        borderRadius: BorderRadius.circular(20),









        boxShadow: AppTheme.elevatedShadow,









      ),









      child: Row(









        children: [









          Container(









            width: 64,









            height: 64,









            decoration: BoxDecoration(









              color: Colors.white.withValues(alpha: 0.2),









              shape: BoxShape.circle,









            ),









            child: ClipOval(
              child: _profileImage != null
                ? Image.file(_profileImage!, width: 64, height: 64, fit: BoxFit.cover)
                : const Center(child: Text('👨‍🌾', style: TextStyle(fontSize: 32))),
            ),









          ),









          const SizedBox(width: 16),









          Expanded(









            child: Column(









              crossAxisAlignment: CrossAxisAlignment.start,









              children: [









                Text(









                  name,









                  style: const TextStyle(









                    color: Colors.white,









                    fontSize: 18,









                    fontWeight: FontWeight.w700,









                  ),









                ),









                const SizedBox(height: 4),









                Row(









                  children: [









                    const Icon(Icons.location_on, color: Colors.white70, size: 14),









                    const SizedBox(width: 4),









                    Flexible(









                      child: Text(









                        location,









                        style: const TextStyle(









                          color: Colors.white70,









                          fontSize: 13,









                        ),









                        overflow: TextOverflow.ellipsis,









                      ),









                    ),









                  ],









                ),









              

          // ── Edit Profile Button ──
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen())),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.edit_rounded, color: Colors.white, size: 20),
            ),
          ),
],









            ),









          ),









        ],









      ),









    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2);









  }









}



















/// Location tile with change button









class _LocationTile extends StatelessWidget {









  final AppProvider provider;









  const _LocationTile({required this.provider});



















  @override









  Widget build(BuildContext context) {









    final isDark = Theme.of(context).brightness == Brightness.dark;









    final loc = provider.farmerLocation;



















    return Container(









      padding: const EdgeInsets.all(16),









      decoration: BoxDecoration(









        color: isDark ? AppColors.darkCard : Colors.white,









        borderRadius: BorderRadius.circular(16),









        boxShadow: AppTheme.cardShadow,









      ),









      child: Column(









        crossAxisAlignment: CrossAxisAlignment.start,









        children: [









          if (loc != null) ...[









            Row(









              children: [









                const Icon(Icons.location_on, color: AppColors.primary, size: 18),









                const SizedBox(width: 8),









                Expanded(









                  child: Text(









                    loc.displayFull,









                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),









                  ),









                ),









              ],









            ),









            const SizedBox(height: 12),









          ] else









            const Text(









              'No location set. Set your farm location for accurate data.',









              style: TextStyle(fontSize: 13, color: AppColors.textLight),









            ),









          SizedBox(









            width: double.infinity,









            child: OutlinedButton.icon(









              onPressed: () {









                Navigator.push(









                  context,









                  MaterialPageRoute(









                    builder: (_) => const LocationSetupScreen(isFirstLaunch: false),









                  ),









                );









              },









              icon: const Icon(Icons.edit_location_rounded, size: 18),









              label: Text(loc != null ? 'Change Location' : 'Set Location'),









            ),









          ),









        ],









      ),









    );









  }









}



















/// Language selector (EN / TE / HI chips)









class _LanguageSelector extends StatelessWidget {









  final AppProvider provider;









  const _LanguageSelector({required this.provider});



















  @override









  Widget build(BuildContext context) {









    final isDark = Theme.of(context).brightness == Brightness.dark;



















    return Container(









      padding: const EdgeInsets.all(16),









      decoration: BoxDecoration(









        color: isDark ? AppColors.darkCard : Colors.white,









        borderRadius: BorderRadius.circular(16),









        boxShadow: AppTheme.cardShadow,









      ),









      child: Column(









        crossAxisAlignment: CrossAxisAlignment.start,









        children: [









          const Text(









            'Choose your preferred language',









            style: TextStyle(fontSize: 13, color: AppColors.textLight),









          ),









          const SizedBox(height: 14),









          Row(









            children: AppLanguage.values.map((lang) {









              final isSelected = provider.language == lang;









              return Expanded(









                child: Padding(









                  padding: const EdgeInsets.symmetric(horizontal: 4),









                  child: InkWell(









                    onTap: () => provider.setLanguage(lang),









                    borderRadius: BorderRadius.circular(12),









                    child: AnimatedContainer(









                      duration: const Duration(milliseconds: 250),









                      padding: const EdgeInsets.symmetric(vertical: 12),









                      decoration: BoxDecoration(









                        color: isSelected ? AppColors.primary : AppColors.primarySurface,









                        borderRadius: BorderRadius.circular(12),









                        border: Border.all(









                          color: isSelected









                              ? AppColors.primary









                              : AppColors.primary.withValues(alpha: 0.15),









                        ),









                      ),









                      child: Column(









                        children: [









                          Text(lang.flag, style: const TextStyle(fontSize: 20)),









                          const SizedBox(height: 4),









                          Text(









                            lang.displayName,









                            style: TextStyle(









                              fontSize: 12,









                              fontWeight: FontWeight.w600,









                              color: isSelected ? Colors.white : AppColors.primary,









                            ),









                          ),









                        ],









                      ),









                    ),









                  ),









                ),









              );









            }).toList(),









          ),









        ],









      ),









    );









  }









}



















/// Generic settings tile









class _SettingsTile extends StatelessWidget {









  final IconData icon;









  final String title;









  final String subtitle;









  final Widget? trailing;









  final VoidCallback? onTap;



















  const _SettingsTile({









    required this.icon,









    required this.title,









    required this.subtitle,









    this.trailing,









    this.onTap,









  });



















  @override









  Widget build(BuildContext context) {









    final isDark = Theme.of(context).brightness == Brightness.dark;



















    return Container(









      margin: const EdgeInsets.only(bottom: 4),









      decoration: BoxDecoration(









        color: isDark ? AppColors.darkCard : Colors.white,









        borderRadius: BorderRadius.circular(14),









        boxShadow: AppTheme.cardShadow,









      ),









      child: ListTile(









        onTap: onTap,









        leading: Container(









          width: 40,









          height: 40,









          decoration: BoxDecoration(









            color: AppColors.primarySurface,









            borderRadius: BorderRadius.circular(10),









          ),









          child: Icon(icon, color: AppColors.primary, size: 20),









        ),









        title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),









        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textLight)),









        trailing: trailing,









        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),









        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),









      ),









    );









  }









}



















/// Section title helper









class _SectionTitle extends StatelessWidget {









  final String title;









  const _SectionTitle({required this.title});



















  @override









  Widget build(BuildContext context) {









    return Text(









      title,









      style: const TextStyle(









        fontSize: 15,









        fontWeight: FontWeight.w700,









        color: AppColors.textMedium,









      ),









    );









  }









}



















/// Logout button









class _LogoutButton extends StatelessWidget {









  final AppProvider provider;









  const _LogoutButton({required this.provider});



















  @override









  Widget build(BuildContext context) {









    return SizedBox(









      width: double.infinity,









      child: OutlinedButton.icon(









        onPressed: () async {









          final confirm = await showDialog<bool>(









            context: context,









            builder: (ctx) => AlertDialog(









              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),









              title: const Text('Logout'),









              content: const Text('Are you sure you want to logout?'),









              actions: [









                TextButton(









                  onPressed: () => Navigator.pop(ctx, false),









                  child: const Text('Cancel'),









                ),









                ElevatedButton(









                  onPressed: () => Navigator.pop(ctx, true),









                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.riskHigh),









                  child: const Text('Logout'),









                ),









              ],









            ),









          );









          if (confirm == true && context.mounted) {









            provider.logout();









            Navigator.of(context).pushAndRemoveUntil(









              MaterialPageRoute(builder: (_) => const LoginScreen()),









              (route) => false,









            );









          }









        },









        icon: const Icon(Icons.logout_rounded, color: AppColors.riskHigh),









        label: const Text('Logout', style: TextStyle(color: AppColors.riskHigh)),









        style: OutlinedButton.styleFrom(









          side: const BorderSide(color: AppColors.riskHigh),









          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),









        ),









      ),









    );









  }









}



















// ─────────────────────────────────────────────────────────────────────────────









// Voice Selector  shows available Telugu voices from device









// ─────────────────────────────────────────────────────────────────────────────









class _VoiceSelectorTile extends StatefulWidget {









  final AppProvider provider;









  const _VoiceSelectorTile({required this.provider});



















  @override









  State<_VoiceSelectorTile> createState() => _VoiceSelectorTileState();









}



















class _VoiceSelectorTileState extends State<_VoiceSelectorTile> {









  List<Map<String, String>> _voices = [];









  String? _selectedVoice;









  bool _loading = true;



















  @override









  void initState() {









    super.initState();









    _loadVoices();









  }



















  Future<void> _loadVoices() async {









    final voice = VoiceService();









    // Force init to discover voices









    await voice.speak('', language: AppLanguage.telugu);









    await voice.stop();









    if (mounted) {









      setState(() {









        _voices = voice.teluguVoices;









        _selectedVoice = voice.currentTeluguVoice;









        _loading = false;









      });









    }









  }



















  @override









  Widget build(BuildContext context) {









    final isDark = Theme.of(context).brightness == Brightness.dark;









    return Container(









      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),









      decoration: BoxDecoration(









        color: isDark ? AppColors.darkCard : Colors.white,









        borderRadius: BorderRadius.circular(16),









        boxShadow: AppTheme.cardShadow,









      ),









      child: Row(









        children: [









          const Icon(Icons.record_voice_over_rounded, color: AppColors.primary, size: 22),









          const SizedBox(width: 14),









          Expanded(









            child: Column(









              crossAxisAlignment: CrossAxisAlignment.start,









              children: [









                const Text('Telugu Voice',









                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),









                Text(









                  _loading ? 'Detecting voices...' : (_voices.isEmpty ? 'No Telugu voice found. Install Google TTS' : 'Select preferred voice'),









                  style: const TextStyle(fontSize: 12, color: AppColors.textLight),









                ),









              ],









            ),









          ),









          if (!_loading && _voices.isNotEmpty)









            DropdownButton<String>(









              value: _selectedVoice,









              hint: const Text('Auto', style: TextStyle(fontSize: 12)),









              underline: const SizedBox(),









              isDense: true,









              items: _voices.map((v) {









                final name = v['name'] ?? '';









                final locale = v['locale'] ?? '';









                return DropdownMenuItem<String>(









                  value: name,









                  child: Text(









                    name.length > 22 ? '${name.substring(0, 22)}' : name,









                    style: const TextStyle(fontSize: 11),









                  ),









                );









              }).toList(),









              onChanged: (val) async {









                if (val != null) {









                  await VoiceService().setTeluguVoice(val);









                  setState(() => _selectedVoice = val);









                }









              },









            ),









        ],









      ),









    );









  }









}



















// ─────────────────────────────────────────────────────────────────────────────









// Test Voice Button









// ─────────────────────────────────────────────────────────────────────────────









class _TestVoiceButton extends StatefulWidget {









  final AppProvider provider;









  const _TestVoiceButton({required this.provider});



















  @override









  State<_TestVoiceButton> createState() => _TestVoiceButtonState();









}



















class _TestVoiceButtonState extends State<_TestVoiceButton> {









  bool _testing = false;



















  @override









  Widget build(BuildContext context) {









    return GestureDetector(









      onTap: _testing









          ? null









          : () async {









              setState(() => _testing = true);









              await VoiceService()









                  .testVoice(widget.provider.language)









                  .timeout(const Duration(seconds: 8), onTimeout: () {});









              if (mounted) setState(() => _testing = false);









            },









      child: Container(









        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),









        decoration: BoxDecoration(









          color: AppColors.primarySurface,









          borderRadius: BorderRadius.circular(16),









          border: Border.all(color: AppColors.primary.withOpacity(0.25)),









        ),









        child: Row(









          children: [









            Icon(









              _testing ? Icons.volume_up_rounded : Icons.play_circle_outline_rounded,









              color: AppColors.primary,









              size: 22,









            ),









            const SizedBox(width: 14),









            Expanded(









              child: Column(









                crossAxisAlignment: CrossAxisAlignment.start,









                children: [









                  const Text('Test Voice',









                      style: TextStyle(









                          fontSize: 14,









                          fontWeight: FontWeight.w700,









                          color: AppColors.primary)),









                  Text(









                    _testing ? 'Speaking...' : 'Tap to hear a sample greeting',









                    style: const TextStyle(









                        fontSize: 12, color: AppColors.textLight),









                  ),









                ],









              ),









            ),









            if (_testing)









              const SizedBox(









                width: 18,









                height: 18,









                child: CircularProgressIndicator(









                  strokeWidth: 2,









                  color: AppColors.primary,









                ),









              ),









          ],









        ),









      ),









    );









  }









}



















// ─────────────────────────────────────────────────────────────────────────────









// Farm ID QR Card  shown in Settings









// ─────────────────────────────────────────────────────────────────────────────









class _FarmIdQrCard extends StatelessWidget {









  final AppProvider provider;









  const _FarmIdQrCard({required this.provider});



















  String _farmerId(String name, String district) {









    final seed = '${name.toUpperCase()}${district.toUpperCase()}';









    final hash = seed.codeUnits.fold(0, (a, b) => a + b);









    return 'AGS-${1000000 + Random(hash).nextInt(8999999)}';









  }



















  String _buildQr() {









    final loc = provider.farmerLocation;









    final name = provider.currentUser?.name ?? 'Agroksha Farmer';









    final fid = _farmerId(name, loc?.district ?? 'IN');









        return jsonEncode({




      'app': 'AGROKSHA AI',




      'app_info': 'Smart Farming Assistant for Indian Farmers by TEAM SARA',




      'features': 'Weather, AI Disease Detection, Live Market Prices, MSP, Government Schemes',




      'farmer_id': fid,




      'name': name,




      'location': '${loc?.district ?? ""}, ${loc?.state ?? ""}',




      'app_download': 'https://play.google.com/store/apps/details?id=com.teamsara.agroksha',




      'note': 'Scan to download AGROKSHA AI from Play Store'




    });









  }



















  @override









  Widget build(BuildContext context) {









    final isDark = Theme.of(context).brightness == Brightness.dark;









    final qrData = _buildQr();









    final loc = provider.farmerLocation;









    final name = provider.currentUser?.name ?? 'Agroksha Farmer';









    final fid = _farmerId(name, loc?.district ?? 'IN');



















    return Container(









      padding: const EdgeInsets.all(16),









      decoration: BoxDecoration(









        gradient: const LinearGradient(









          colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],









          begin: Alignment.topLeft, end: Alignment.bottomRight,









        ),









        borderRadius: BorderRadius.circular(18),









        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 16, offset: const Offset(0, 6))],









      ),









      child: Column(children: [









        Row(children: [









          const Text('🌾', style: TextStyle(fontSize: 28)),









          const SizedBox(width: 12),









          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [









            Text('DIGITAL FARM ID', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1.2)),









            Text('AGROKSHA AI  TEAM SARA', style: TextStyle(color: Colors.white70, fontSize: 10)),









          ])),









          Container(









            padding: const EdgeInsets.all(8),









            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),









            child: QrImageView(









              data: qrData, version: QrVersions.auto, size: 70,









              backgroundColor: Colors.white,









              eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: Color(0xFF1B5E20)),









              dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: Color(0xFF2E7D32)),









            ),









          ),









        ]),









        const SizedBox(height: 12),









        const Divider(color: Colors.white24),









        const SizedBox(height: 8),









        // Compact farmer details









        Row(children: [









          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [









            _QrDetail('Name', name),









            const SizedBox(height: 4),









            _QrDetail('ID', fid),









            if (loc != null) ...[









              const SizedBox(height: 4),









              _QrDetail('Location', '${loc.district}, ${loc.state}'),









            ],









          ])),









        ]),









        const SizedBox(height: 10),









        Container(









          padding: const EdgeInsets.all(8),









          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),









          child: const Row(children: [









            Icon(Icons.qr_code_scanner_rounded, color: Colors.white60, size: 14),









            SizedBox(width: 6),









            Expanded(child: Text('Scan QR for full details + app download link',









                style: TextStyle(color: Colors.white60, fontSize: 10, height: 1.3))),









          ]),









        ),









        const SizedBox(height: 10),









        SizedBox(width: double.infinity, child: TextButton(









          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FarmIdScreen())),









          style: TextButton.styleFrom(









            backgroundColor: Colors.white.withValues(alpha: 0.15),









            foregroundColor: Colors.white,









            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),









          ),









          child: const Text('View Full Farm ID Card →', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),









        )),









      ]),









    );









  }









}



















class _QrDetail extends StatelessWidget {









  final String label, value;









  const _QrDetail(this.label, this.value);









  @override









  Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [









    Text('$label: ', style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.w600)),









    Expanded(child: Text(value, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700))),









  ]);









}







































