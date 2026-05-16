/// AGROKSHA AI — MSP Alert + Sell Now / Wait Advisor




/// Uses: MSP 2026 (static) + live market price from AppProvider




library;









import 'package:flutter/material.dart';




import 'package:flutter_animate/flutter_animate.dart';




import 'package:provider/provider.dart';




import '../data/msp_data.dart';




import '../models/models.dart';




import '../theme/app_theme.dart';




import '../utils/app_provider.dart';




import '../services/voice_service.dart';









class MspAdvisorScreen extends StatefulWidget {




  const MspAdvisorScreen({super.key});




  @override




  State<MspAdvisorScreen> createState() => _MspAdvisorScreenState();




}









class _MspAdvisorScreenState extends State<MspAdvisorScreen> {




  String _search = '';




  String _seasonFilter = 'All';









  @override




  Widget build(BuildContext context) {




    final provider = context.watch<AppProvider>();




    final isDark = Theme.of(context).brightness == Brightness.dark;




    final lang = provider.language;




    final isTelugu = lang == AppLanguage.telugu;









    // Filter crops




    final visible = MspData.crops.where((c) {




      final matchSeason = _seasonFilter == 'All' || c['season'] == _seasonFilter;




      final matchSearch = _search.isEmpty ||




          c['name'].toString().toLowerCase().contains(_search.toLowerCase()) ||




          (c['nameTE'] ?? '').toString().contains(_search);




      return matchSeason && matchSearch;




    }).toList();









    return Scaffold(




      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,




      appBar: AppBar(




        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [




          Text(isTelugu ? '💰 MSP సలహా' : '💰 MSP Advisor',




              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),




          Text(isTelugu ? '2026 కనీస మద్దతు ధరలు' : 'Minimum Support Price 2026',




              style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.75))),




        ]),




        backgroundColor: AppColors.primary,




        foregroundColor: Colors.white,




        elevation: 0,




      ),




      body: Column(children: [




        // ── Header info banner ──────────────────────────────────────────────




        Container(




          width: double.infinity,




          padding: const EdgeInsets.all(14),




          color: AppColors.primary,




          child: Text(




            isTelugu




                ? '✅ ఇవి CCEA ద్వారా ప్రకటించిన అధికారిక ధరలు. మీ మండి ధర దీని కంటే తక్కువగా ఉంటే అమ్మవద్దు.'




                : '✅ Official CCEA rates. If mandi price is below MSP, wait or sell to government procurement.',




            style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),




          ),




        ),




        // ── Search + Filter ─────────────────────────────────────────────────




        Padding(




          padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),




          child: Row(children: [




            Expanded(child: TextField(




              onChanged: (v) => setState(() => _search = v),




              decoration: InputDecoration(




                hintText: isTelugu ? 'పంట వెతకండి...' : 'Search crop...',




                prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textLight, size: 20),




                filled: true,




                fillColor: isDark ? AppColors.darkCard : Colors.white,




                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),




                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),




              ),




            )),




            const SizedBox(width: 10),




            _SeasonChip(label: 'All',    active: _seasonFilter == 'All',    onTap: () => setState(() => _seasonFilter = 'All')),




            _SeasonChip(label: 'Kharif', active: _seasonFilter == 'Kharif', onTap: () => setState(() => _seasonFilter = 'Kharif')),




            _SeasonChip(label: 'Rabi',   active: _seasonFilter == 'Rabi',   onTap: () => setState(() => _seasonFilter = 'Rabi')),




          ]),




        ),




        const SizedBox(height: 10),




        // ── Crop list ───────────────────────────────────────────────────────




        Expanded(child: ListView.builder(




          padding: const EdgeInsets.symmetric(horizontal: 12),




          itemCount: visible.length,




          itemBuilder: (_, i) {




            final crop = visible[i];




            // Find live market price from AppProvider




            final marketItem = provider.allMarketItems.cast<MarketItem?>().firstWhere(




              (m) => m != null && m.cropName.toLowerCase().contains(




                  crop['name'].toString().split(' ').first.toLowerCase()),




              orElse: () => null,




            );




            return _MspTile(




              crop: crop,




              marketItem: marketItem,




              isTelugu: isTelugu,




              isDark: isDark,




              onSpeak: () {




                final msp = crop['msp'] as int;




                final name = isTelugu ? crop['nameTE'] : crop['name'];




                final marketPrice = marketItem?.pricePerQuintal;




                String msg;




                if (marketPrice != null) {




                  final diff = marketPrice - msp;




                  if (diff >= 0) {




                    msg = isTelugu




                        ? '$name MSP ₹$msp. నేడు మండి ధర ₹$marketPrice. MSP కంటే ₹$diff ఎక్కువ. ఇప్పుడు అమ్మవచ్చు.'




                        : '$name MSP ₹$msp. Today mandi ₹$marketPrice. ₹$diff above MSP. Good time to sell.';




                  } else {




                    msg = isTelugu




                        ? '$name MSP ₹$msp. నేడు మండి ధర ₹$marketPrice. MSP కంటే ₹${diff.abs()} తక్కువ. వేచి ఉండండి.'




                        : '$name MSP ₹$msp. Today mandi ₹$marketPrice. ₹${diff.abs()} below MSP. Wait before selling.';




                  }




                } else {




                  msg = isTelugu




                      ? '$name కు కనీస మద్దతు ధర ₹$msp ప్రతి క్వింటాల్.'




                      : '$name minimum support price is ₹$msp per quintal.';




                }




                VoiceService().speak(msg, language: lang, speed: provider.voiceSpeed);




              },




            ).animate(delay: Duration(milliseconds: i * 40)).fadeIn(duration: 280.ms).slideX(begin: 0.05);




          },




        )),




      ]),




    );




  }




}









// ── Season filter chip ────────────────────────────────────────────────────────




class _SeasonChip extends StatelessWidget {




  final String label;




  final bool active;




  final VoidCallback onTap;




  const _SeasonChip({required this.label, required this.active, required this.onTap});




  @override




  Widget build(BuildContext context) => GestureDetector(




    onTap: onTap,




    child: AnimatedContainer(




      duration: const Duration(milliseconds: 180),




      margin: const EdgeInsets.only(left: 6),




      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),




      decoration: BoxDecoration(




        color: active ? AppColors.primary : Colors.grey.shade200,




        borderRadius: BorderRadius.circular(10),




      ),




      child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700,




          color: active ? Colors.white : AppColors.textMedium)),




    ),




  );




}









// ── MSP crop tile ─────────────────────────────────────────────────────────────




class _MspTile extends StatelessWidget {




  final Map<String, dynamic> crop;




  final MarketItem? marketItem;




  final bool isTelugu, isDark;




  final VoidCallback onSpeak;




  const _MspTile({required this.crop, required this.marketItem, required this.isTelugu, required this.isDark, required this.onSpeak});









  @override




  Widget build(BuildContext context) {




    final msp = crop['msp'] as int;




    final marketPrice = marketItem?.pricePerQuintal;




    final diff = marketPrice != null ? marketPrice - msp : null;




    final aboveMsp = diff != null && diff >= 0;




    final noData = diff == null;









    Color adviceColor = noData ? AppColors.textLight : (aboveMsp ? AppColors.riskLow : AppColors.riskHigh);




    String adviceText;




    IconData adviceIcon;









    if (noData) {




      adviceText = isTelugu ? 'నేటి ధర అందుబాటులో లేదు' : 'No live price available';




      adviceIcon = Icons.help_outline_rounded;




    } else if (aboveMsp) {




      adviceText = isTelugu




          ? '✅ అమ్మవచ్చు! MSP కంటే ₹$diff ఎక్కువ'




          : '✅ Good to sell! ₹$diff above MSP';




      adviceIcon = Icons.trending_up_rounded;




    } else {




      adviceText = isTelugu




          ? '⚠️ వేచి ఉండండి! MSP కంటే ₹${diff.abs()} తక్కువ'




          : '⚠️ Wait! ₹${diff!.abs()} below MSP';




      adviceIcon = Icons.trending_down_rounded;




    }









    return Container(




      margin: const EdgeInsets.only(bottom: 10),




      padding: const EdgeInsets.all(14),




      decoration: BoxDecoration(




        color: isDark ? AppColors.darkCard : Colors.white,




        borderRadius: BorderRadius.circular(16),




        border: Border.all(color: noData ? AppColors.divider : adviceColor.withOpacity(0.3)),




        boxShadow: AppTheme.cardShadow,




      ),




      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [




        Row(children: [




          Text(crop['emoji'] ?? '🌾', style: const TextStyle(fontSize: 28)),




          const SizedBox(width: 12),




          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [




            Text(isTelugu ? (crop['nameTE'] ?? crop['name']) : crop['name'],




                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),




            const SizedBox(height: 2),




            Row(children: [




              _badge(crop['season'], _seasonColor(crop['season'])),




              const SizedBox(width: 6),




              Text('MSP: ₹$msp/qtl',




                  style: const TextStyle(fontSize: 12, color: AppColors.textMedium, fontWeight: FontWeight.w600)),




            ]),




          ])),




          IconButton(




            icon: const Icon(Icons.volume_up_rounded, color: AppColors.primary, size: 22),




            onPressed: onSpeak,




            constraints: const BoxConstraints(),




            padding: const EdgeInsets.all(6),




          ),




        ]),




        const SizedBox(height: 10),




        // Price comparison bar




        if (marketPrice != null) ...[




          Row(children: [




            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [




              Text(isTelugu ? 'MSP ధర' : 'MSP Price',




                  style: const TextStyle(fontSize: 10, color: AppColors.textLight, fontWeight: FontWeight.w600)),




              Text('₹$msp', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.primary)),




            ])),




            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [




              Icon(adviceIcon, color: adviceColor, size: 28),




            ])),




            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [




              Text(isTelugu ? 'మండి ధర' : 'Mandi Price',




                  style: const TextStyle(fontSize: 10, color: AppColors.textLight, fontWeight: FontWeight.w600)),




              Text('₹$marketPrice', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: adviceColor)),




            ])),




          ]),




          const SizedBox(height: 8),




        ],




        // Advice banner




        Container(




          width: double.infinity,




          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),




          decoration: BoxDecoration(




            color: adviceColor.withOpacity(0.08),




            borderRadius: BorderRadius.circular(10),




            border: Border.all(color: adviceColor.withOpacity(0.2)),




          ),




          child: Text(adviceText,




              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: adviceColor)),




        ),




        if (crop['note'] != null) ...[




          const SizedBox(height: 6),




          Text('ℹ️ ${crop['note']}',




              style: const TextStyle(fontSize: 10, color: AppColors.textLight, fontStyle: FontStyle.italic)),




        ],




      ]),




    );




  }









  Color _seasonColor(dynamic season) {




    if (season == 'Kharif') return const Color(0xFF1565C0);




    if (season == 'Rabi')   return const Color(0xFF6A1B9A);




    return AppColors.primary;




  }









  Widget _badge(dynamic label, Color color) => Container(




    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),




    decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),




    child: Text(label.toString(), style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.w700)),




  );




}














