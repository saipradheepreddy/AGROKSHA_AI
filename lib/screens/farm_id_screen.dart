import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

class FarmIdScreen extends StatefulWidget {
  const FarmIdScreen({super.key});

  @override
  State<FarmIdScreen> createState() => _FarmIdScreenState();
}

class _FarmIdScreenState extends State<FarmIdScreen> with SingleTickerProviderStateMixin {
  final FlutterTts _tts = FlutterTts();
  bool _isPlaying = false;
  late AnimationController _glowCtrl;
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    _glowCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _tts.stop();
    _glowCtrl.dispose();
    super.dispose();
  }

  String _buildAiSummary(UserModel? user, String crop) {
    if (user == null) return "Profile incomplete. Please edit your profile to see your AI Summary.";
    
    final dist = user.district != null && user.district!.isNotEmpty ? user.district! : 'your district';
    final acres = user.farmSize != null && user.farmSize!.isNotEmpty ? user.farmSize! : 'some land';
    final irrigation = user.irrigationType != null && user.irrigationType!.isNotEmpty ? user.irrigationType! : 'standard';
    
    return "You are a $crop farmer from $dist, cultivating $acres using $irrigation irrigation. Current market and weather conditions are stable for your crop.";
  }

  String _generateRealisticId(UserModel? user) {
    if (user == null) return 'AGS-IND-2026-0000';
    final dist = user.district != null && user.district!.length >= 3 
        ? user.district!.substring(0, 3).toUpperCase() 
        : 'IND';
    final shortId = user.id.length >= 4 ? user.id.substring(0, 4).toUpperCase() : '0142';
    return 'AGS-$dist-2026-$shortId';
  }

  int _calculateStabilityScore(UserModel? user) {
    if (user == null) return 40;
    int score = 50; // Base score
    if (user.district != null && user.district!.isNotEmpty) score += 10;
    if (user.farmSize != null && user.farmSize!.isNotEmpty) score += 10;
    if (user.irrigationType != null && user.irrigationType!.isNotEmpty) score += 10;
    if (user.experienceYears != null && user.experienceYears! > 5) score += 10;
    if (user.profileImagePath != null) score += 5;
    return score.clamp(0, 98); // Max out at 98 for realism
  }

  
  Future<void> _shareId() async {
    try {
      final directory = await getTemporaryDirectory();
      final imageFile = await _screenshotController.captureAndSave(directory.path, fileName: 'FarmID_${DateTime.now().millisecondsSinceEpoch}.png');
      if (imageFile != null) {
        await Share.shareXFiles([XFile(imageFile)], text: 'Check out my verified AGROKSHA AI Digi Farm ID!');
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to share ID: $e')));
    }
  }

  Future<void> _readProfile(UserModel? user, String summary) async {
    if (_isPlaying) {
      await _tts.stop();
      setState(() => _isPlaying = false);
      return;
    }
    
    setState(() => _isPlaying = true);
    await _tts.setLanguage('en-IN');
    
    String text = "Farm Profile. ${user?.name ?? 'Unknown Farmer'}. $summary";
    await _tts.speak(text);
    
    _tts.setCompletionHandler(() {
      if (mounted) setState(() => _isPlaying = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final user = provider.currentUser;
    final crop = provider.selectedCrop;
    final summary = _buildAiSummary(user, crop);
    final realisticId = _generateRealisticId(user);
    final isTe = provider.language == AppLanguage.telugu;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F4),
      appBar: AppBar(
        title: Text(isTe ? 'నా ప్రొఫైల్' : 'My Profile', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF1B5E20),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 1. Premium Digi Farm ID Card
            Screenshot(controller: _screenshotController, child: _buildPremiumCard(user, crop, realisticId)),
            
            const SizedBox(height: 20),
            
            // 2. Farm Stability Score & AI Summary
            _buildStabilityAndSummary(summary, _calculateStabilityScore(user)),
            
            const SizedBox(height: 20),
            
            // 3. Health Insight Chips
            _buildInsightChips(),
            
            const SizedBox(height: 20),
            
            // 4. Quick Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionBtn(Icons.mic, 'Voice Fill', () => Navigator.pop(context)),
                _buildActionBtn(_isPlaying ? Icons.stop : Icons.volume_up, 'Read Profile', () => _readProfile(user, summary), color: _isPlaying ? Colors.red : null),
                _buildActionBtn(Icons.edit, 'Edit', () => Navigator.pop(context)),
                _buildActionBtn(Icons.share, 'Share ID', _shareId),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // 5. Crop Timeline
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Past 3 Years Crop History', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20))),
            ),
            const SizedBox(height: 12),
            _buildTimeline(user),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumCard(UserModel? user, String crop, String realisticId) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: const Color(0xFF1B5E20).withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 8))],
        image: const DecorationImage(
          image: AssetImage('assets/images/leaf_texture.png'), // Will add fallback if missing
          fit: BoxFit.cover,
          opacity: 0.05,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.eco, color: Colors.greenAccent, size: 24),
              const SizedBox(width: 8),
              const Text('AGROKSHA AI', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 2)),
            ],
          ),
          const SizedBox(height: 4),
          const Text('Smart Farming. Intelligent Future.', style: TextStyle(color: Colors.white70, fontSize: 10)),
          const SizedBox(height: 20),
          
          Container(
            width: 100, height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              image: user?.profileImagePath != null ? DecorationImage(image: FileImage(File(user!.profileImagePath!)), fit: BoxFit.cover) : null,
              color: Colors.white24,
            ),
            child: user?.profileImagePath == null ? const Center(child: Text('👨‍🌾', style: TextStyle(fontSize: 40))) : null,
          ),
          
          const SizedBox(height: 16),
          Text(user?.name ?? 'Farmer Name', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          
          // Mini Info Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🌾 $crop', style: const TextStyle(color: Colors.white, fontSize: 12)),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('|', style: TextStyle(color: Colors.white54))),
                Text('📍 ${user?.district ?? 'Unknown'}', style: const TextStyle(color: Colors.white, fontSize: 12)),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('|', style: TextStyle(color: Colors.white54))),
                Text('🚜 ${user?.farmSize?.replaceAll('acres', 'Ac') ?? '0 Ac'}', style: const TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          Text('Digi Farm ID: $realisticId', style: const TextStyle(color: Colors.white70, fontSize: 12, letterSpacing: 1)),
          
          const SizedBox(height: 16),
          // Animated QR Glow
          AnimatedBuilder(
            animation: _glowCtrl,
            builder: (context, child) {
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.greenAccent.withOpacity(0.3 * _glowCtrl.value), blurRadius: 15 * _glowCtrl.value, spreadRadius: 5 * _glowCtrl.value)
                  ],
                ),
                child: QrImageView(data: 'AGROKSHA_$realisticId', size: 100, backgroundColor: Colors.white),
              );
            },
          ),
          
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: Colors.greenAccent.withOpacity(0.2), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.greenAccent.withOpacity(0.5))),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified_user, color: Colors.greenAccent, size: 16),
                SizedBox(width: 6),
                Text('VERIFIED FARMER', style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1)),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStabilityAndSummary(String summary, int score) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF1B5E20).withOpacity(0.2))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circular Progress Score
          SizedBox(
            width: 70, height: 70,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(value: score / 100, strokeWidth: 6, backgroundColor: Colors.grey.shade200, valueColor: AlwaysStoppedAnimation(score > 70 ? Colors.green : Colors.orange)),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('$score%', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const Text('Score', style: TextStyle(fontSize: 8, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Summary Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.auto_awesome, color: Color(0xFF1B5E20), size: 16),
                    SizedBox(width: 6),
                    Text('AI Farmer Summary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1B5E20))),
                  ],
                ),
                const SizedBox(height: 6),
                Text(summary, style: const TextStyle(fontSize: 12, color: Colors.black87, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightChips() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildChip('Farm Health', 'Good', Colors.green),
        _buildChip('Weather Risk', 'Low', Colors.green),
        _buildChip('Market Trend', 'Stable', Colors.green),
        _buildChip('Irrigation', 'Optimum', Colors.green),
      ],
    );
  }

  Widget _buildChip(String title, String value, Color color) {
    return Container(
      width: 75,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 5)]),
      child: Column(
        children: [
          Icon(Icons.analytics, color: Colors.grey.shade400, size: 18),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 9, color: Colors.grey), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildActionBtn(IconData icon, String label, VoidCallback onTap, {Color? color}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
            child: Icon(icon, color: color ?? const Color(0xFF1B5E20), size: 22),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildTimeline(UserModel? user) {
    // If no real CropHistoryList, fallback to pastCrops strings for backward compatibility
    if (user == null || (user.cropHistoryList.isEmpty && user.pastCrops.isEmpty)) {
      return const Text('No crop history added.', style: TextStyle(color: Colors.grey));
    }
    
    int count = user.cropHistoryList.isNotEmpty ? user.cropHistoryList.length : user.pastCrops.length;

    return Column(
      children: List.generate(count, (i) {
        final year = user.cropHistoryList.isNotEmpty ? user.cropHistoryList[i].year : '${DateTime.now().year - i - 1}';
        final cropName = user.cropHistoryList.isNotEmpty ? user.cropHistoryList[i].cropName : user.pastCrops[i];
        final season = user.cropHistoryList.isNotEmpty ? (user.cropHistoryList[i].season ?? 'Kharif') : 'Kharif';
        final secondary = user.cropHistoryList.isNotEmpty ? user.cropHistoryList[i].secondaryCrop : null;
        final yieldStr = user.cropHistoryList.isNotEmpty ? user.cropHistoryList[i].yieldStr : '25 Qtl/Ac';
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: const Color(0xFF1B5E20), borderRadius: BorderRadius.circular(20)),
                    child: Text(year, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                  if (i != count - 1)
                    Container(width: 2, height: 50, color: const Color(0xFF1B5E20).withOpacity(0.3), margin: const EdgeInsets.symmetric(vertical: 4)),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(cropName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.orange.shade200)),
                                  child: Text(season, style: TextStyle(color: Colors.orange.shade800, fontSize: 10, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            if (secondary != null && secondary.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text('Intercrop: $secondary', style: const TextStyle(fontSize: 11, color: Colors.blueGrey)),
                              ),
                            Text('Yield: $yieldStr', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                          ],
                        ),
                      ),
                      Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.grass, color: Colors.green, size: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
