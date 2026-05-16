/// ─────────────────────────────────────────────────────────────────────────────




/// AGROKSHA AI — Smart Recommendation Screen




/// Soil type + season input → AI crop recommendations with risk analysis




/// ─────────────────────────────────────────────────────────────────────────────









import 'package:flutter/material.dart';




import 'package:flutter_animate/flutter_animate.dart';




import 'package:provider/provider.dart';




import '../theme/app_theme.dart';




import '../models/models.dart';




import '../utils/app_provider.dart';




import '../widgets/widgets.dart';









class RecommendationScreen extends StatelessWidget {




  const RecommendationScreen({super.key});









  @override




  Widget build(BuildContext context) {




    return Consumer<AppProvider>(




      builder: (context, provider, _) {




        return Scaffold(




          body: CustomScrollView(




            physics: const BouncingScrollPhysics(),




            slivers: [




              // ── App Bar ──




              _buildAppBar(context, provider),




              // ── Content ──




              SliverPadding(




                padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),




                sliver: SliverList(




                  delegate: SliverChildListDelegate([




                    // Input Card




                    _InputCard(),




                    const SizedBox(height: 24),




                    // Results




                    _ResultsSection(),




                  ]),




                ),




              ),




            ],




          ),




        );




      },




    );




  }









  Widget _buildAppBar(BuildContext context, AppProvider provider) {




    return SliverAppBar(




      pinned: true,




      expandedHeight: 130,




      backgroundColor: AppColors.primary,




      flexibleSpace: FlexibleSpaceBar(




        background: Container(




          decoration: const BoxDecoration(




            gradient: LinearGradient(




              begin: Alignment.topLeft,




              end: Alignment.bottomRight,




              colors: [Color(0xFF134D2A), Color(0xFF2E9659)],




            ),




          ),




          child: SafeArea(




            child: Padding(




              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),




              child: Column(




                crossAxisAlignment: CrossAxisAlignment.start,




                children: [




                  const Text(




                    '🌱 Smart Crop',




                    style: TextStyle(




                      color: Colors.white70,




                      fontSize: 14,




                      fontWeight: FontWeight.w500,




                    ),




                  ),




                  const Text(




                    'Recommendation',




                    style: TextStyle(




                      color: Colors.white,




                      fontSize: 26,




                      fontWeight: FontWeight.w800,




                    ),




                  ),




                  const SizedBox(height: 4),




                  Text(




                    provider.isTeluguMode




                        ? 'మట్టి & సీజన్ ఆధారంగా పంట సూచన'




                        : 'AI-powered suggestions based on soil & season',




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




    );




  }




}









// ─────────────────────────────────────────────────────────────────────────────




// Input Card




// ─────────────────────────────────────────────────────────────────────────────




class _InputCard extends StatelessWidget {




  @override




  Widget build(BuildContext context) {




    final provider = context.watch<AppProvider>();




    final isDark = Theme.of(context).brightness == Brightness.dark;









    return Container(




      padding: const EdgeInsets.all(20),




      decoration: BoxDecoration(




        color: isDark ? AppColors.darkCard : Colors.white,




        borderRadius: BorderRadius.circular(22),




        boxShadow: AppTheme.cardShadow,




      ),




      child: Column(




        crossAxisAlignment: CrossAxisAlignment.start,




        children: [




          // Card title




          Row(




            children: [




              Container(




                width: 40,




                height: 40,




                decoration: BoxDecoration(




                  gradient: AppColors.primaryGradient,




                  borderRadius: BorderRadius.circular(12),




                ),




                child: const Icon(Icons.tune_rounded, color: Colors.white, size: 20),




              ),




              const SizedBox(width: 12),




              Column(




                crossAxisAlignment: CrossAxisAlignment.start,




                children: [




                  const Text(




                    'Crop Analyzer',




                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),




                  ),




                  Text(




                    'Fill in your farm details',




                    style: TextStyle(




                      fontSize: 12,




                      color: isDark ? AppColors.darkTextMedium : AppColors.textLight,




                    ),




                  ),




                ],




              ),




            ],




          ),









          const SizedBox(height: 20),




          const Divider(height: 1),




          const SizedBox(height: 20),









          // Soil type dropdown




          AgriDropdown<SoilType>(




            label: 'Soil Type',




            hint: 'Select your soil type',




            prefixIcon: Icons.layers_rounded,




            value: provider.selectedSoil,




            items: SoilType.values




                .map(




                  (s) => DropdownMenuItem(




                    value: s,




                    child: Row(




                      children: [




                        Text(s.emoji, style: const TextStyle(fontSize: 18)),




                        const SizedBox(width: 10),




                        Text(




                          s.displayName,




                          style: const TextStyle(




                            fontSize: 14,




                            fontWeight: FontWeight.w500,




                          ),




                        ),




                      ],




                    ),




                  ),




                )




                .toList(),




            onChanged: (v) {




              if (v != null) provider.selectSoil(v);




            },




          ),









          const SizedBox(height: 16),









          // Season dropdown




          AgriDropdown<Season>(




            label: 'Farming Season',




            hint: 'Select the season',




            prefixIcon: Icons.wb_sunny_rounded,




            value: provider.selectedSeason,




            items: Season.values




                .map(




                  (s) => DropdownMenuItem(




                    value: s,




                    child: Row(




                      children: [




                        Text(s.emoji, style: const TextStyle(fontSize: 18)),




                        const SizedBox(width: 10),




                        Text(




                          s.displayName,




                          style: const TextStyle(




                            fontSize: 14,




                            fontWeight: FontWeight.w500,




                          ),




                        ),




                      ],




                    ),




                  ),




                )




                .toList(),




            onChanged: (v) {




              if (v != null) provider.selectSeason(v);




            },




          ),









          const SizedBox(height: 24),









          // Analyze button




          GradientButton(




            label: provider.isTeluguMode ? '🤖 విశ్లేషించు' : '🤖 Analyze Crops',




            isLoading: provider.isRecommendationLoading,




            onPressed: (provider.selectedSoil != null && provider.selectedSeason != null)




                ? () async {




                    await provider.analyzeRecommendations();




                    if (context.mounted) {




                      ScaffoldMessenger.of(context).showSnackBar(




                        SnackBar(




                          content: Text(




                            '✅ Found ${provider.recommendations.length} crop recommendations!',




                          ),




                        ),




                      );




                    }




                  }




                : null,




          ),









          // Helper text




          if (provider.selectedSoil == null || provider.selectedSeason == null)




            Padding(




              padding: const EdgeInsets.only(top: 10),




              child: Center(




                child: Text(




                  'Select soil type and season to continue',




                  style: TextStyle(




                    fontSize: 12,




                    color: isDark ? AppColors.darkTextMedium : AppColors.textLight,




                  ),




                ),




              ),




            ),




        ],




      ),




    ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.15, curve: Curves.easeOutCubic);




  }




}









// ─────────────────────────────────────────────────────────────────────────────




// Results Section




// ─────────────────────────────────────────────────────────────────────────────




class _ResultsSection extends StatelessWidget {




  @override




  Widget build(BuildContext context) {




    final provider = context.watch<AppProvider>();









    if (provider.isRecommendationLoading) {




      return Column(




        children: [




          const _LoadingAnalysisWidget(),




          const SizedBox(height: 14),




          ...List.generate(3, (i) => const ShimmerCard(height: 130)),




        ],




      );




    }









    if (provider.recommendations.isEmpty) {




      return AgriEmptyState(




        emoji: '🌾',




        title: 'Ready to Analyze',




        subtitle: 'Select your soil type and season above,\nthen tap Analyze Crops',




        action: null,




      );




    }









    return Column(




      crossAxisAlignment: CrossAxisAlignment.start,




      children: [




        SectionHeader(




          title: '🎯 Recommended Crops',




          subtitle:




              '${provider.recommendations.length} crops found for ${provider.selectedSoil?.displayName ?? ""} × ${provider.selectedSeason?.displayName ?? ""}',




        ),




        const SizedBox(height: 14),




        // Risk legend




        _RiskLegend(),




        const SizedBox(height: 16),




        // Recommendation cards




        ...provider.recommendations.asMap().entries.map(




              (e) => RecommendationCard(crop: e.value, index: e.key),




            ),




        // Clear button




        const SizedBox(height: 12),




        OutlinedButton.icon(




          onPressed: provider.clearRecommendations,




          icon: const Icon(Icons.refresh_rounded),




          label: const Text('Reset & Analyze Again'),




          style: OutlinedButton.styleFrom(




            minimumSize: const Size(double.infinity, 50),




          ),




        ),




      ],




    );




  }




}









class _LoadingAnalysisWidget extends StatelessWidget {




  const _LoadingAnalysisWidget();









  @override




  Widget build(BuildContext context) {




    return Container(




      padding: const EdgeInsets.all(20),




      decoration: BoxDecoration(




        gradient: AppColors.primaryGradient,




        borderRadius: BorderRadius.circular(18),




      ),




      child: Row(




        children: [




          const SizedBox(




            width: 28,




            height: 28,




            child: CircularProgressIndicator(




              color: Colors.white,




              strokeWidth: 3,




            ),




          ),




          const SizedBox(width: 14),




          Column(




            crossAxisAlignment: CrossAxisAlignment.start,




            children: const [




              Text(




                '🤖 AI Analysis in progress...',




                style: TextStyle(




                  color: Colors.white,




                  fontSize: 14,




                  fontWeight: FontWeight.w700,




                ),




              ),




              SizedBox(height: 2),




              Text(




                'Matching crops to your soil & season',




                style: TextStyle(color: Colors.white70, fontSize: 12),




              ),




            ],




          ),




        ],




      ),




    ).animate(onPlay: (c) => c.repeat()).shimmer(




          duration: 1500.ms,




          color: Colors.white24,




        );




  }




}









class _RiskLegend extends StatelessWidget {




  @override




  Widget build(BuildContext context) {




    return Container(




      padding: const EdgeInsets.all(14),




      decoration: BoxDecoration(




        color: AppColors.primarySurface,




        borderRadius: BorderRadius.circular(14),




      ),




      child: Row(




        mainAxisAlignment: MainAxisAlignment.spaceAround,




        children: [




          _legendItem('🟢', 'No / Low Risk', AppColors.riskNone),




          _legendItem('🟡', 'Medium Risk', AppColors.riskMedium),




          _legendItem('🔴', 'High Risk', AppColors.riskHigh),




        ],




      ),




    );




  }









  Widget _legendItem(String emoji, String label, Color color) {




    return Column(




      children: [




        Text(emoji, style: const TextStyle(fontSize: 18)),




        const SizedBox(height: 2),




        Text(




          label,




          style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: color),




          textAlign: TextAlign.center,




        ),




      ],




    );




  }




}




