/// ─────────────────────────────────────────────────────────────────────────────



/// AGROKSHA AI — Government Schemes Screen (Full Tab)



/// Central + State-specific schemes with direct links



/// ─────────────────────────────────────────────────────────────────────────────







import 'package:flutter/material.dart';



import 'package:flutter_animate/flutter_animate.dart';



import 'package:provider/provider.dart';



import 'package:url_launcher/url_launcher.dart';



import '../theme/app_theme.dart';



import '../utils/app_provider.dart';



import '../data/schemes_data.dart';



import '../services/voice_service.dart';







class SchemesScreen extends StatefulWidget {



  const SchemesScreen({super.key});







  @override



  State<SchemesScreen> createState() => _SchemesScreenState();



}







class _SchemesScreenState extends State<SchemesScreen> with TickerProviderStateMixin {



  late TabController _tabController;



  late String _detectedState;



  late List<Map<String, dynamic>> _stateSchemes;







  @override



  void initState() {



    super.initState();



    // We'll detect state in didChangeDependencies after build context is ready



  }







  @override



  void didChangeDependencies() {



    super.didChangeDependencies();



    final provider = context.read<AppProvider>();



    _detectedState = provider.farmerLocation?.state ?? '';







    // Check if we have state-specific schemes



    _stateSchemes = SchemeData.stateSchemes[_detectedState] ?? [];







    final tabCount = _stateSchemes.isNotEmpty ? 2 : 1;



    _tabController = TabController(length: tabCount, vsync: this);



  }







  @override



  void dispose() {



    _tabController.dispose();



    super.dispose();



  }







  @override



  Widget build(BuildContext context) {



    final isDark = Theme.of(context).brightness == Brightness.dark;



    final hasStateSchemes = _stateSchemes.isNotEmpty;







    return Scaffold(



      body: CustomScrollView(



        physics: const BouncingScrollPhysics(),



        slivers: [



          // Premium App Bar



          SliverAppBar(



            pinned: true,



            expandedHeight: 140,



            backgroundColor: AppColors.primary,



            flexibleSpace: FlexibleSpaceBar(



              background: Container(



                decoration: const BoxDecoration(gradient: AppColors.heroGradient),



                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),



                alignment: Alignment.bottomLeft,



                child: SafeArea(



                  child: Column(



                    mainAxisAlignment: MainAxisAlignment.end,



                    crossAxisAlignment: CrossAxisAlignment.start,



                    children: [



                      const Text(



                        '🏛️ Govt Schemes',



                        style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800),



                      ),



                      const SizedBox(height: 4),



                      Text(



                        hasStateSchemes



                            ? 'Central + $_detectedState state schemes'



                            : 'Central Government farmer schemes',



                        style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 13),



                      ),



                    ],



                  ),



                ),



              ),



            ),



            bottom: PreferredSize(



              preferredSize: const Size.fromHeight(48),



              child: Container(



                color: AppColors.primary,



                child: TabBar(



                  controller: _tabController,



                  labelColor: Colors.white,



                  unselectedLabelColor: Colors.white60,



                  indicatorColor: Colors.white,



                  indicatorWeight: 3,



                  labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),



                  tabs: [



                    if (hasStateSchemes)



                      Tab(text: '📍 $_detectedState'),



                    const Tab(text: '🇮🇳 Central'),



                  ],



                ),



              ),



            ),



          ),







          // Tab Body



          SliverFillRemaining(



            child: TabBarView(



              controller: _tabController,



              children: [



                if (hasStateSchemes)



                  _SchemeList(schemes: _stateSchemes, isDark: isDark, state: _detectedState),



                _SchemeList(schemes: SchemeData.centralSchemes, isDark: isDark, state: 'Central'),



              ],



            ),



          ),



        ],



      ),



    );



  }



}







// ─────────────────────────────────────────────────────────────────────────────



// Scheme list (scrollable cards)



// ─────────────────────────────────────────────────────────────────────────────



class _SchemeList extends StatelessWidget {



  final List<Map<String, dynamic>> schemes;



  final bool isDark;



  final String state;







  const _SchemeList({required this.schemes, required this.isDark, required this.state});







  @override



  Widget build(BuildContext context) {



    return ListView.builder(



      padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),



      physics: const BouncingScrollPhysics(),



      itemCount: schemes.length,



      itemBuilder: (ctx, i) => _SchemeCard(scheme: schemes[i], isDark: isDark, index: i),



    );



  }



}







// ─────────────────────────────────────────────────────────────────────────────



// Scheme card



// ─────────────────────────────────────────────────────────────────────────────



class _SchemeCard extends StatefulWidget {



  final Map<String, dynamic> scheme;



  final bool isDark;



  final int index;







  const _SchemeCard({required this.scheme, required this.isDark, required this.index});







  @override



  State<_SchemeCard> createState() => _SchemeCardState();



}







class _SchemeCardState extends State<_SchemeCard> {



  bool _expanded = false;







  Future<void> _launchUrl() async {



    final uri = Uri.parse(widget.scheme['link'] as String);



    if (await canLaunchUrl(uri)) {



      await launchUrl(uri, mode: LaunchMode.externalApplication);



    } else {



      if (mounted) {



        ScaffoldMessenger.of(context).showSnackBar(



          const SnackBar(content: Text('Could not open link')),



        );



      }



    }



  }







  @override



  Widget build(BuildContext context) {



    final s = widget.scheme;



    final tags = (s['tags'] as List<dynamic>).cast<String>();



    final isDark = widget.isDark;







    return Container(



      margin: const EdgeInsets.only(bottom: 16),



      decoration: BoxDecoration(



        color: isDark ? AppColors.darkCard : Colors.white,



        borderRadius: BorderRadius.circular(20),



        boxShadow: AppTheme.cardShadow,



        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),



      ),



      child: Column(



        crossAxisAlignment: CrossAxisAlignment.start,



        children: [



          // Header — always visible



          InkWell(



            onTap: () => setState(() => _expanded = !_expanded),



            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),



            child: Container(



              padding: const EdgeInsets.all(16),



              decoration: BoxDecoration(



                color: AppColors.primarySurface,



                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),



              ),



              child: Row(



                children: [



                  Text(s['icon'] as String, style: const TextStyle(fontSize: 32)),



                  const SizedBox(width: 14),



                  Expanded(



                    child: Column(



                      crossAxisAlignment: CrossAxisAlignment.start,



                      children: [



                        Text(



                          s['title'] as String,



                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary),



                        ),



                        const SizedBox(height: 4),



                        Text(



                          s['subtitle'] as String,



                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark),



                        ),



                      ],



                    ),



                  ),



                  IconButton(



                    icon: const Icon(Icons.volume_up_rounded, color: AppColors.primary),



                    onPressed: () {



                      final provider = context.read<AppProvider>();



                      final title = s['title'] as String;



                      final desc = s['description'] as String;



                      VoiceService().speak('$title. $desc', language: provider.language, speed: provider.voiceSpeed);



                    },



                  ),



                  Icon(



                    _expanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,



                    color: AppColors.primary,



                  ),



                ],



              ),



            ),



          ),







          // Expandable body



          AnimatedSize(



            duration: const Duration(milliseconds: 320),



            curve: Curves.easeOutCubic,



            child: _expanded



                ? Padding(



                    padding: const EdgeInsets.all(16),



                    child: Column(



                      crossAxisAlignment: CrossAxisAlignment.start,



                      children: [



                        // Description



                        Text(



                          s['description'] as String,



                          style: TextStyle(



                            fontSize: 14,



                            height: 1.6,



                            color: isDark ? Colors.white70 : AppColors.textMedium,



                          ),



                        ),



                        const SizedBox(height: 14),







                        // Tags



                        Wrap(



                          spacing: 8,



                          runSpacing: 8,



                          children: tags.map((tag) {



                            return Container(



                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),



                              decoration: BoxDecoration(



                                color: AppColors.riskLow.withValues(alpha: 0.1),



                                borderRadius: BorderRadius.circular(8),



                                border: Border.all(color: AppColors.riskLow.withValues(alpha: 0.3)),



                              ),



                              child: Text(



                                tag,



                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.riskLow),



                              ),



                            );



                          }).toList(),



                        ),



                        const SizedBox(height: 16),







                        // Action button



                        SizedBox(



                          width: double.infinity,



                          child: ElevatedButton.icon(



                            onPressed: _launchUrl,



                            icon: const Icon(Icons.open_in_new_rounded, size: 16),



                            label: const Text('Apply / Official Website'),



                            style: ElevatedButton.styleFrom(



                              backgroundColor: AppColors.primary,



                              foregroundColor: Colors.white,



                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),



                              padding: const EdgeInsets.symmetric(vertical: 13),



                              textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),



                            ),



                          ),



                        ),



                      ],



                    ),



                  )



                : const SizedBox.shrink(),



          ),



        ],



      ),



    ).animate(delay: (80 * widget.index).ms).fadeIn().slideY(begin: 0.15, end: 0);



  }



}













