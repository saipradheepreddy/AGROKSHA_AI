/// ─────────────────────────────────────────────────────────────────────────────
/// AGROKSHA AI  Home Dashboard v2
/// Full dashboard: Weather (live), Location banner, Suggestion card,
/// Crop Risk analysis, Market snapshot, Bottom nav (Dashboard/Market/Recommend/Settings)
/// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../utils/app_provider.dart';
import '../models/models.dart';
import '../utils/app_assets.dart';
import '../widgets/widgets.dart';
import '../widgets/weather_forecast_card.dart';
import 'recommendation_screen.dart';
import 'market_screen.dart';
import 'settings_screen.dart';
import 'location_setup_screen.dart';
import 'crop_tracker_screen.dart';
import '../services/voice_service.dart';
import 'nearby_markets_screen.dart';
import 'schemes_screen.dart';
import 'chat_assistant_screen.dart';
import 'msp_screen.dart';
import 'soil_health_screen.dart';
import 'disease_diagnosis_screen.dart';
import 'agroksha_sangam_screen.dart';
import 'farm_id_screen.dart';
import 'enam_screen.dart';
import 'expense_tracker_screen.dart';
import 'insurance_screen.dart';
import 'stock_management_screen.dart';
import '../services/connectivity_service.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;
  bool _hasAutoSpoken = false;
  late final List<Widget> _pages;
  @override
  void initState() {
    super.initState();
    _pages = [
      _DashboardBody(onSwitchTab: (i) => setState(() => _currentTab = i)),
      MarketScreen(),
      CropTrackerScreen(),
      SchemesScreen(),
      SettingsScreen(),
    ];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<AppProvider>();
      provider.refreshDashboard();
      // Listen for when weather first loads → auto-speak greeting
      provider.addListener(_onProviderChange);
    });
  }
  void _onProviderChange() {
    if (_hasAutoSpoken) return;
    final provider = context.read<AppProvider>();
    if (provider.weather != null) {
      _hasAutoSpoken = true;
      /* 
      if (!provider.muteGreetings) {
        final voice = VoiceService();
        final msg = voice.getRandomGreeting(provider.language);
        Future.delayed(Duration(milliseconds: 1200), () {
          if (mounted) voice.speak(msg, language: provider.language, speed: provider.voiceSpeed);
        });
      }
      */
    }
  }
  @override
  void dispose() {
    // Safe removal: provider might already be gone during hot reload
    try {
      context.read<AppProvider>().removeListener(_onProviderChange);
    } catch (_) {}
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(index: _currentTab, children: _pages),
          // Offline mode banner
          StreamBuilder<bool>(
            stream: ConnectivityService.instance.onStatusChange,
            builder: (ctx, snap) {
              final online = snap.data ?? ConnectivityService.instance.isOnline;
              if (online) return SizedBox.shrink();
              return Positioned(
                top: 0, left: 0, right: 0,
                child: SafeArea(
                  bottom: false,
                  child: Material(
                    color: Color(0xFFF57F17),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      child: Row(children: [
                        Icon(Icons.signal_wifi_off_rounded, color: Colors.white, size: 16),
                        SizedBox(width: 8),
                        Expanded(child: Text('📡 Offline Mode  Using cached data',
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700))),
                      ]),
                    ),
                  ),
                ),
              );
            },
          ),
          // Draggable Floating Voice Avatar
          _FloatingVoiceAssistant(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }
  Widget _buildBottomNav() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(0, Icons.dashboard_rounded, Icons.dashboard_outlined, 'Home'),
              _navItem(1, Icons.bar_chart_rounded, Icons.bar_chart_outlined, 'Market'),
              _navItem(2, Icons.grass_rounded, Icons.grass_outlined, 'Tracker'),
              _navItemBadge(3, Icons.account_balance_rounded, Icons.account_balance_outlined, 'Schemes', Colors.orange),
              _navItem(4, Icons.settings_rounded, Icons.settings_outlined, 'Settings'),
            ],
          ),
        ),
      ),
    );
  }
  Widget _navItem(int index, IconData activeIcon, IconData inactiveIcon, String label) {
    final isActive = _currentTab == index;
    return GestureDetector(
      onTap: () => setState(() => _currentTab = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primarySurface : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : inactiveIcon,
              color: isActive ? AppColors.primary : AppColors.textLight,
              size: 24,
            ),
            AnimatedSize(
              duration: Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              child: isActive
                  ? Row(children: [
                      SizedBox(width: 6),
                      Text(label,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          )),
                    ])
                  : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
  /// Nav item with glowing badge highlight (for Schemes & Voice)
  Widget _navItemBadge(
      int index, IconData activeIcon, IconData inactiveIcon, String label, Color badgeColor) {
    final isActive = _currentTab == index;
    return GestureDetector(
      onTap: () => setState(() => _currentTab = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? badgeColor.withValues(alpha: 0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  isActive ? activeIcon : inactiveIcon,
                  color: isActive ? badgeColor : AppColors.textLight,
                  size: 24,
                ),
                // Glow dot badge
                if (!isActive)
                  Positioned(
                    top: -3,
                    right: -3,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: badgeColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: badgeColor.withValues(alpha: 0.5), blurRadius: 4),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            AnimatedSize(
              duration: Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              child: isActive
                  ? Row(children: [
                      SizedBox(width: 6),
                      Text(label,
                          style: TextStyle(
                            color: badgeColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          )),
                    ])
                  : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
// ─────────────────────────────────────────────────────────────────────────────
// Dashboard body
// ─────────────────────────────────────────────────────────────────────────────
class _DashboardBody extends StatelessWidget {
  final void Function(int) onSwitchTab;
  _DashboardBody({required this.onSwitchTab});
  String _greet() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good Morning,';
    if (h < 17) return 'Good Afternoon,';
    return 'Good Evening,';
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        final lang = provider.langCode;
        return RefreshIndicator(
          onRefresh: provider.refreshDashboard,
          color: AppColors.primary,
          child: CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              // ── Sticky header ──
              SliverAppBar(
                pinned: true,
                expandedHeight: 180,
                backgroundColor: AppColors.primary,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.heroGradient,
                      image: DecorationImage(
                        image: AssetImage('assets/images/crop_placeholder.png'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.5), BlendMode.darken),
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Branding row
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Row(
                                   children: [
                                     Container(
                                       width: 40,
                                       height: 40,
                                       decoration: BoxDecoration(
                                         color: Colors.white,
                                         borderRadius: BorderRadius.circular(10),
                                         boxShadow: [
                                           BoxShadow(
                                             color: Colors.black.withValues(alpha: 0.1),
                                             blurRadius: 8,
                                           ),
                                         ],
                                       ),
                                       child: ClipRRect(
                                         borderRadius: BorderRadius.circular(10),
                                         child: Image.asset(
                                           'assets/images/agroksha_logo.png',
                                           fit: BoxFit.cover,
                                           errorBuilder: (_, __, ___) => const Icon(Icons.agriculture_rounded, color: Colors.green, size: 24),
                                         ),
                                       ),
                                     ),
                                     const SizedBox(width: 12),
                                     Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(
                                           translate(S.appName, lang),
                                           style: TextStyle(
                                             color: Colors.white,
                                             fontSize: 18,
                                             fontWeight: FontWeight.w900,
                                             letterSpacing: 2,
                                           ),
                                         ),
                                         Text(
                                           translate(S.devTeam, lang),
                                           style: TextStyle(
                                             color: Colors.white.withValues(alpha: 0.6),
                                             fontSize: 10,
                                             letterSpacing: 0.5,
                                           ),
                                         ),
                                       ],
                                     ),
                                   ],
                                 ),
                                Row(
                                  children: [
                                    _appBarBtn(
                                      provider.isDarkMode
                                          ? Icons.light_mode_rounded
                                          : Icons.dark_mode_rounded,
                                      provider.toggleTheme,
                                    ),
                                    SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () {
                                        // Cycle languages
                                        final idx =
                                            AppLanguage.values.indexOf(provider.language);
                                        provider.setLanguage(
                                          AppLanguage
                                              .values[(idx + 1) % AppLanguage.values.length],
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(alpha: 0.15),
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        child: Text(
                                          provider.language.displayName,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 14),
                            // Greeting + name
                            Text(
                              _greet(),
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.75),
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              provider.currentUser?.name ??
                                  translate(S.farmerFriend, lang),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              translate(S.todayInsights, lang),
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // ── Body content ──
              SliverPadding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 100),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(height: 20),
                    // Weather card
                    SectionHeader(
                      title: '🌤 ${translate(S.weatherToday, lang)}',
                      subtitle: provider.farmerLocation != null
                          ? provider.farmerLocation!.displayShort
                          : translate(S.loadingWeather, lang),
                    ),
                    SizedBox(height: 12),
                    // Rain Alert Banner
                    if (provider.weather != null && provider.weather!.rainChance > 50) ...[
                      _RainAlertBanner(chance: provider.weather!.rainChance.toInt()),
                      SizedBox(height: 12),
                    ],
                    if (provider.isWeatherLoading)
                      ShimmerCard(height: 260)
                    else if (provider.weather != null)
                      WeatherForecastCard(
                        weather: provider.weather!,
                        forecast: provider.forecast,
                        onRefresh: provider.fetchWeather,
                      )
                    else
                      ShimmerCard(height: 260),
                    // Weather error banner
                    if (provider.weatherError != null) ...[
                      SizedBox(height: 8),
                      _ErrorBanner(message: provider.weatherError!),
                    ],
                    SizedBox(height: 24),
                    // Location banner
                    _LocationBanner(provider: provider),
                    SizedBox(height: 20),
                    // Quick Access Row
                    _QuickAccessRow(provider: provider, lang: lang),
                    SizedBox(height: 20),
                    // Daily care tip
                    if (provider.dailyCareTip != null)
                      _DailyCareTipCard(tip: provider.dailyCareTip!),
                    if (provider.dailyCareTip != null) SizedBox(height: 16),
                    // Today's suggestion card
                    if (provider.todaySuggestion != null) ...[
                      _SuggestionCard(
                        suggestion: provider.todaySuggestion!,
                        lang: provider.langCode,
                      ),
                      SizedBox(height: 16),
                    ],
                    // Daily Summary Card (computed from real data, no extra API)
                    _DailySummaryCard(provider: provider),
                    SizedBox(height: 16),
                    // AI Daily Insight Card
                    _AiInsightCard(provider: provider),
                    SizedBox(height: 20),
                    SectionHeader(
                      title: '📊 ${translate(S.marketDemand, lang)}',
                      subtitle: 'Top movers today',
                      trailing: TextButton(
                        onPressed: () => onSwitchTab(1),
                        child: Text('See All'),
                      ),
                    ),
                    SizedBox(height: 12),
                    _MarketSnapshot(provider: provider),
                    SizedBox(height: 24),
                    // Crop risk section
                    SectionHeader(
                      title: '⚠️? ${translate(S.cropRisk, lang)}',
                      subtitle: translate(S.based, lang),
                      trailing: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primarySurface,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          '📡 Live',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 14),
                    if (provider.isCropRiskLoading)
                      ...List.generate(4, (_) => ShimmerCard(height: 84))
                    else if (provider.cropRisks.isEmpty)
                      AgriEmptyState(
                        emoji: '🌾',
                        title: 'No crop data',
                        subtitle: 'Pull down to refresh',
                      )
                    else
                      ...provider.cropRisks.asMap().entries
                          .map((e) => CropRiskCard(crop: e.value, index: e.key)),
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _appBarBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
// ─────────────────────────────────────────────────────────────────────────────
// AI Daily Insight Card
// ─────────────────────────────────────────────────────────────────────────────
class _AiInsightCard extends StatelessWidget {
  final AppProvider provider;
  _AiInsightCard({required this.provider});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final insight = provider.aiDailyInsight;
    final isLoading = provider.isAiInsightLoading;
    if (!isLoading && insight == null) return SizedBox.shrink();
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ChatAssistantScreen()),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF134D2A), Color(0xFF1B6E3D)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.25),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('🤖', style: TextStyle(fontSize: 16)),
                ),
                SizedBox(width: 10),
                Text(
                  provider.t(S.aiDailyInsightTitle),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    letterSpacing: 0.5,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    provider.t(S.aiInsightBadge),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            if (isLoading)
              Column(
                children: [
                  Container(
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 14,
                    width: double.infinity * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ],
              )
            else
              Text(
                insight!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            SizedBox(height: 12),
            Row(
              children: [
                if (insight != null)
                  GestureDetector(
                    onTap: () => VoiceService().speak(insight, language: provider.language),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.volume_up_rounded, color: Colors.white, size: 14),
                          SizedBox(width: 4),
                          Text(provider.t(S.readAloud), style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Ask AI', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600)),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward_ios_rounded, color: Colors.white70, size: 10),
                  ],
                ),
              ],
            ),
          ],
        ),
      ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),
    );
  }
}
// ─────────────────────────────────────────────────────────────────────────────
// Location Banner
// ─────────────────────────────────────────────────────────────────────────────
class _LocationBanner extends StatelessWidget {
  final AppProvider provider;
  _LocationBanner({required this.provider});
  @override
  Widget build(BuildContext context) {
    final loc = provider.farmerLocation;
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LocationSetupScreen(isFirstLaunch: false),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.primarySurface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Icon(Icons.location_on, color: AppColors.primary, size: 20),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                loc != null ? loc.displayFull : 'Tap to set your location',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.edit_location_rounded, color: AppColors.primaryLight, size: 18),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.3);
  }
}
// ─────────────────────────────────────────────────────────────────────────────
// Quick Access Row
// ─────────────────────────────────────────────────────────────────────────────
class _QuickAccessRow extends StatelessWidget {
  final AppProvider provider;
  final String lang;
  _QuickAccessRow({required this.provider, required this.lang});
  void _triggerVoice(BuildContext context) async {
    final voice = VoiceService();
    if (voice.isPlaying) {
      await voice.stop();
      return;
    }
    // Use smart Telugu/English weather greeting
    if (provider.weather != null) {
      final msg = voice.buildWeatherGreeting(provider.weather!, provider.language);
      await voice.speak(msg, language: provider.language);
    } else {
      await voice.speak(provider.t(S.waitingForData), language: provider.language);
    }
  }
  @override
  Widget build(BuildContext context) {
    final isTe = provider.language == AppLanguage.telugu;
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _QuickAccessBtn(
            icon: Icons.track_changes_rounded,
            label: provider.t(S.tracker),
            color: Colors.green,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CropTrackerScreen())),
          ),
          _QuickAccessBtn(
            icon: Icons.storefront_rounded,
            label: provider.t(S.mandi),
            color: Colors.orange,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NearbyMarketsScreen())),
          ),
          _QuickAccessBtn(
            icon: Icons.currency_rupee_rounded,
            label: provider.t(S.msp),
            color: Color(0xFF1B5E20),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MspAdvisorScreen())),
          ),
          _QuickAccessBtn(
            icon: Icons.account_balance_rounded,
            label: provider.t(S.schemes),
            color: Colors.purple,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SchemesScreen())),
          ),
        ],
      ),
      SizedBox(height: 12),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _QuickAccessBtn(
            icon: Icons.science_rounded,
            label: provider.t(S.soil),
            color: Color(0xFF795548),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SoilHealthScreen())),
          ),
          _QuickAccessBtn(
            icon: Icons.camera_alt_rounded,
            label: provider.t(S.disease),
            color: Color(0xFFB71C1C),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DiseaseDiagnosisScreen())),
          ),
          _QuickAccessBtn(
            icon: Icons.badge_rounded,
            label: provider.t(S.farmId),
            color: Color(0xFF4A148C),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FarmIdScreen())),
          ),
          _QuickAccessBtn(
            icon: Icons.account_balance_outlined,
            label: 'e-NAM',
            color: Color(0xFF006064),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EnamScreen())),
          ),
        ],
      ),
      SizedBox(height: 12),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _QuickAccessBtn(
            icon: Icons.receipt_long_rounded,
            label: 'Expenses',
            color: Colors.blueGrey,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ExpenseTrackerScreen())),
          ),
          _QuickAccessBtn(
            icon: Icons.shield_rounded,
            label: 'Insurance',
            color: Colors.teal,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => InsuranceScreen())),
          ),
          _QuickAccessBtn(
            icon: Icons.inventory_2_rounded,
            label: 'Stock',
            color: Colors.indigo,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StockManagementScreen())),
          ),
          _QuickAccessBtn(
            icon: Icons.handshake_rounded,
            label: isTe ? 'అగోక్ష సంఘం' : 'Community',
            color: Colors.deepOrange,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AgrokshaSangamScreen())),
          ),
        ],
      ),
    ]).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2);
  }
}
class _QuickAccessBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  _QuickAccessBtn({required this.icon, required this.label, required this.color, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: color.withValues(alpha: 0.15), blurRadius: 15, offset: Offset(0, 5)),
              ],
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textMedium)),
        ],
      ),
    );
  }
}
// ─────────────────────────────────────────────────────────────────────────────
// Today's Suggestion Card
// ─────────────────────────────────────────────────────────────────────────────
class _SuggestionCard extends StatelessWidget {
  final FarmerSuggestion suggestion;
  final String lang;
  _SuggestionCard({required this.suggestion, required this.lang});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accentAmber.withValues(alpha: 0.15),
            AppColors.accentAmber.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.accentAmber.withValues(alpha: 0.3)),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            suggestion.type.emoji,
            style: TextStyle(fontSize: 32),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.accentAmber.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Today's Suggestion",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.accentAmber,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final provider = context.read<AppProvider>();
                        VoiceService().speak('Suggestion. ${suggestion.title(lang)}. ${suggestion.description(lang)}', speed: provider.voiceSpeed, language: provider.language);
                      },
                      child: Icon(Icons.volume_up_rounded, color: AppColors.accentAmber, size: 20),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  suggestion.title(lang),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  suggestion.description(lang),
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textMedium,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: 200.ms, duration: 500.ms)
        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic);
  }
}
// ─────────────────────────────────────────────────────────────────────────────
// Market Snapshot (3 items preview)
// ─────────────────────────────────────────────────────────────────────────────
class _MarketSnapshot extends StatelessWidget {
  final AppProvider provider;
  _MarketSnapshot({required this.provider});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final items = [
      ...provider.highDemandMarket.take(1),
      ...provider.risingMarket.take(2),
    ];
    return Column(
      children: items.asMap().entries.map((e) {
        final item = e.value;
        final isRising = item.changeAmount >= 0;
        final color = isRising ? AppColors.riskLow : AppColors.riskHigh;
        final changeStr = isRising
            ? '+₹${item.changeAmount}'
            : '-₹${item.changeAmount.abs()}';
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: AppTheme.cardShadow,
          ),
          child: Row(
            children: [
              ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                AppAssets.getCropImage(item.cropName),
                width: 36, height: 36, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Text(item.cropEmoji, style: TextStyle(fontSize: 26)),
              ),
            ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.cropName,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                '₹${item.pricePerQuintal}/qtl',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  '$changeStr ${item.trend.emoji}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ).animate(delay: Duration(milliseconds: e.key * 80)).fadeIn().slideX(begin: 0.2);
      }).toList(),
    );
  }
}
// ─────────────────────────────────────────────────────────────────────────────
// Error Banner
// ─────────────────────────────────────────────────────────────────────────────
class _ErrorBanner extends StatelessWidget {
  final String message;
  _ErrorBanner({required this.message});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.riskMedium.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.riskMedium.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.wifi_off_rounded, color: AppColors.riskMedium, size: 18),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(fontSize: 12, color: AppColors.riskMedium),
            ),
          ),
        ],
      ),
    );
  }
}
// ─────────────────────────────────────────────────────────────────────────────
// Daily Care Tip Card
// ─────────────────────────────────────────────────────────────────────────────
class _DailyCareTipCard extends StatelessWidget {
  final DailyCareTip tip;
  _DailyCareTipCard({required this.tip});
  Color get _accentColor {
    switch (tip.category) {
      case 'watering': return AppColors.accentSky;
      case 'fertilizer': return AppColors.riskLow;
      case 'pest': return AppColors.riskMedium;
      case 'harvest': return AppColors.accentAmber;
      default: return AppColors.primary;
    }
  }
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _accentColor.withValues(alpha: 0.3)),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              color: _accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(child: Text(tip.emoji, style: TextStyle(fontSize: 26))),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: _accentColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Today's Tip",
                        style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: _accentColor),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final provider = context.read<AppProvider>();
                        VoiceService().speak('Tip. ${tip.title}. ${tip.message}', speed: provider.voiceSpeed, language: provider.language);
                      },
                      child: Icon(Icons.volume_up_rounded, color: _accentColor, size: 20),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(tip.title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                SizedBox(height: 3),
                Text(tip.message, style: TextStyle(fontSize: 12, color: AppColors.textMedium, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 150.ms, duration: 400.ms).slideX(begin: -0.2, end: 0, curve: Curves.easeOutCubic);
  }
}
// ─────────────────────────────────────────────────────────────────────────────
// Floating Voice Assistant
// ─────────────────────────────────────────────────────────────────────────────
class _FloatingVoiceAssistant extends StatefulWidget {
  _FloatingVoiceAssistant();
  @override
  State<_FloatingVoiceAssistant> createState() => _FloatingVoiceAssistantState();
}
class _FloatingVoiceAssistantState extends State<_FloatingVoiceAssistant>
    with TickerProviderStateMixin {
  Offset position = Offset(20, 100);
  late AnimationController _pulseCtrl;
  late AnimationController _glowCtrl;
  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _glowCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      setState(() {
        position = Offset(size.width - 80, size.height - 180);
      });
    });
  }
  @override
  void dispose() {
    _pulseCtrl.dispose();
    _glowCtrl.dispose();
    super.dispose();
  }
  void _openChat({bool autoListen = false}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatAssistantScreen(autoListen: autoListen),
      ),
    );
  }
  void _onLongPress() {
    _glowCtrl.repeat(reverse: true);
    HapticFeedback.heavyImpact();
    _openChat(autoListen: true);
    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) _glowCtrl.stop();
    });
  }
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final isListening = VoiceService().isListening;
    final isPlaying = VoiceService().isPlaying;
    final hasInsight = provider.aiDailyInsight != null;
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        feedback: Material(
          color: Colors.transparent,
          child: _buildAvatar(isListening, isPlaying, hasInsight),
        ),
        childWhenDragging: SizedBox.shrink(),
        onDragEnd: (details) {
          setState(() {
            position = details.offset;
          });
        },
        child: GestureDetector(
          onTap: () => _openChat(),
          // onLongPress: _onLongPress, // Paused as per user request
          child: _buildAvatar(isListening, isPlaying, hasInsight),
        ),
      ),
    );
  }
  Widget _buildAvatar(bool isListening, bool isPlaying, bool hasInsight) {
    return AnimatedBuilder(
      animation: Listenable.merge([_pulseCtrl, _glowCtrl]),
      builder: (_, __) {
        final active = isListening || isPlaying;
        final scale = active ? 1.0 + (_pulseCtrl.value * 0.12) : 1.0;
        final glowRadius = active
            ? 24.0 + (_glowCtrl.value * 12)
            : 10.0;
        return Transform.scale(
          scale: scale,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(active ? 0.55 : 0.3),
                      blurRadius: glowRadius,
                      spreadRadius: active ? 4 : 0,
                    )
                  ],
                  border: Border.all(color: Colors.white, width: 2.5),
                ),
                child: Center(
                  child: Text('👨‍🌾', style: TextStyle(fontSize: 32)),
                ),
              ),
              // AI badge when insight is loaded
              if (hasInsight)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withOpacity(0.5),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    child: Center(
                      child: Text('✨', style: TextStyle(fontSize: 8)),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
// ─────────────────────────────────────────────────────────────────────────────
// Rain Alert Banner
// ─────────────────────────────────────────────────────────────────────────────
class _RainAlertBanner extends StatelessWidget {
  final int chance;
  _RainAlertBanner({required this.chance});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.red.shade700, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rain Expected ($chance%)', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.red.shade800, fontSize: 13)),
                Text('Heavy rain warning. Avoid spraying today.', style: TextStyle(color: Colors.red.shade800, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.2);
  }
}
// ─────────────────────────────────────────────────────────────────────────────
// Daily Summary Card  computed from real live app data, no extra API call
// ─────────────────────────────────────────────────────────────────────────────
class _DailySummaryCard extends StatelessWidget {
  final AppProvider provider;
  _DailySummaryCard({required this.provider});
    String _weatherCell(WeatherModel? w, AppLanguage lang) {
    if (w == null) {
      switch (lang) {
        case AppLanguage.telugu: return 'వాతావరణం లోడ్ అవుతోంది...';
        case AppLanguage.hindi: return 'मौसम लोड हो रहा है...';
        case AppLanguage.kannada: return 'ಹವಾಮಾನ ಲೋಡ್ ಆಗುತ್ತಿದೆ...';
        case AppLanguage.tamil: return 'வானிலை ஏற்றுகிறது...';
        default: return 'Loading weather...';
      }
    }
    final rain = w.rainChance.toInt();
    final temp = w.temperature.toInt();
    switch (lang) {
      case AppLanguage.telugu:
        if (rain > 70) return '🌧️ వర్షం వస్తుందా?\nఅవును, ఈరోజు వర్షం రావచ్చు. $temp°C';
        if (rain > 40) return '🌦️ వర్షం వస్తుందా?\nవర్షం వచ్చే అవకాశం ఉంది. $temp°C';
        return '☀️ వర్షం వస్తుందా?\nఈరోజు వర్షం రాదు. $temp°C';
      case AppLanguage.hindi:
        if (rain > 70) return '🌧️ क्या बारिश होगी?\nहाँ, आज भारी बारिश हो सकती है। $temp°C';
        if (rain > 40) return '🌦️ क्या बारिश होगी?\nहाँ, बारिश की संभावना है। $temp°C';
        return '☀️ क्या बारिश होगी?\nआज बारिश नहीं होगी। $temp°C';
      case AppLanguage.kannada:
        if (rain > 70) return '🌧️ ಮಳೆ ಬರುತ್ತದೆಯೇ?\nಹೌದು, ಇಂದು ಮಳೆಯಾಗಬಹುದು. $temp°C';
        if (rain > 40) return '🌦️ ಮಳೆ ಬರುತ್ತದೆಯೇ?\nಮಳೆಯಾಗುವ ಸಾಧ್ಯತೆ ಇದೆ. $temp°C';
        return '☀️ ಮಳೆ ಬರುತ್ತದೆಯೇ?\nಇಂದು ಮಳೆ ಬರುವುದಿಲ್ಲ. $temp°C';
      case AppLanguage.tamil:
        if (rain > 70) return '🌧️ மழை பெய்யுமா?\nஆம், இன்று மழை பெய்யலாம். $temp°C';
        if (rain > 40) return '🌦️ மழை பெய்யுமா?\nமழை பெய்ய வாய்ப்புள்ளது. $temp°C';
        return '☀️ மழை பெய்யுமா?\nஇன்று மழை பெய்யாது. $temp°C';
      default:
        if (rain > 70) return '🌧️ WILL IT RAIN?\nYes, rain expected today. $temp°C';
        if (rain > 40) return '🌦️ WILL IT RAIN?\nYes, rain is possible. $temp°C';
        return '☀️ WILL IT RAIN?\nNo rain expected today. $temp°C';
    }
  }
  String _actionCell(WeatherModel? w, AppLanguage lang) {
    if (w == null) return '';
    final rain = w.rainChance;
    final temp = w.temperature;
    switch (lang) {
      case AppLanguage.telugu:
        if (rain > 60) return '🚫 మందుల పిచికారీ చేయవద్దు';
        if (temp > 40) return '💧 పొద్దున నీళ్ళు పెట్టండి';
        if (rain < 20 && temp < 35) return '✅ మందుల పిచికారీ మంచిది';
        return '🌱 సాధారణ వ్యవసాయ పనులు';
      case AppLanguage.hindi:
        if (rain > 60) return '🚫 कीटनाशक न छिड़कें';
        if (temp > 40) return '💧 सुबह पानी दें';
        if (rain < 20 && temp < 35) return '✅ छिड़काव के लिए सही दिन';
        return '🌱 सामान्य कृषि कार्य';
      case AppLanguage.kannada:
        if (rain > 60) return '🚫 ಕೀಟನಾಶಕ ಸಿಂಪಡಿಸಬೇಡಿ';
        if (temp > 40) return '💧 ಬೆಳಿಗ್ಗೆ ನೀರು ಹಾಕಿ';
        if (rain < 20 && temp < 35) return '✅ ಸಿಂಪಡಿಸಲು ಉತ್ತಮ ದಿನ';
        return '🌱 ಸಾಮಾನ್ಯ ಕೃಷಿ ಕೆಲಸ';
      case AppLanguage.tamil:
        if (rain > 60) return '🚫 பூச்சிக்கொல்லி தெளிக்க வேண்டாம்';
        if (temp > 40) return '💧 காலை தண்ணீர் பாய்ச்சவும்';
        if (rain < 20 && temp < 35) return '✅ தெளிக்க ஏற்ற நாள்';
        return '🌱 வழக்கமான விவசாய வேலைகள்';
      default:
        if (rain > 60) return '🚫 Avoid spraying today';
        if (temp > 40) return '💧 Irrigate early morning';
        if (rain < 20 && temp < 35) return '✅ Good day for spraying';
        return '🌱 Normal farm activities';
    }
  }
  String _marketCell(List<MarketItem> items, AppLanguage lang) {
    final rising = items.where((m) => m.trend == MarketTrend.rising).toList();
    if (rising.isEmpty) {
      switch (lang) {
        case AppLanguage.telugu: return '📊 ధరలు స్థిరంగా ఉన్నాయి';
        case AppLanguage.hindi: return '📊 कीमतें स्थिर हैं';
        case AppLanguage.kannada: return '📊 ಬೆಲೆಗಳು ಸ್ಥಿರವಾಗಿವೆ';
        case AppLanguage.tamil: return '📊 విలైகள్ నిలయాకา ఉళ్ళన';
        default: return '📊 Prices stable today';
      }
    }
    final top = rising.first;
    return '📈 ${top.cropName}\n₹${top.pricePerQuintal}/Qtl ↑';
  }
  String _warningCell(WeatherModel? w, List<MarketItem> items, AppLanguage lang) {
    if (w != null && w.rainChance > 60) {
      switch (lang) {
        case AppLanguage.telugu: return '⚠️ వర్షం అవకాశం ${w.rainChance.toInt()}%\nపంటను కాపాడండి';
        case AppLanguage.hindi: return '⚠️ बारिश की संभावना ${w.rainChance.toInt()}%\nफसल सुरक्षित रखें';
        case AppLanguage.kannada: return '⚠️ ಮಳೆಯ ಸಾಧ್ಯತೆ ${w.rainChance.toInt()}%\nಬೆಳೆ ರಕ್ಷಿಸಿ';
        case AppLanguage.tamil: return '⚠️ மழை வாய்ப்பு ${w.rainChance.toInt()}%\nபயிரைப் பாதுகாக்கவும்';
        default: return '⚠️ Rain chance ${w.rainChance.toInt()}%\nProtect your crop';
      }
    }
    final falling = items.where((m) => m.trend == MarketTrend.falling).toList();
    if (falling.isNotEmpty) {
      switch (lang) {
        case AppLanguage.telugu: return '📉 ${falling.first.cropName} ధర తగ్గింది\nనిపుణుని సంప్రదించండి';
        case AppLanguage.hindi: return '📉 ${falling.first.cropName} की कीमत घटी\nसलाह लें';
        case AppLanguage.kannada: return '📉 ${falling.first.cropName} ಬೆಲೆ ಕಡಿಮೆಯಾಗಿದೆ\nಸಲಹೆ ಪಡೆಯಿರಿ';
        case AppLanguage.tamil: return '📉 ${falling.first.cropName} விலை குறைந்தது\nஆலோசனை பெறவும்';
        default: return '📉 ${falling.first.cropName} price down\nConsider waiting';
      }
    }
    switch (lang) {
      case AppLanguage.telugu: return '✅ అన్నీ బాగున్నాయి';
      case AppLanguage.hindi: return '✅ सब ठीक है';
      case AppLanguage.kannada: return '✅ ಎಲ್ಲವೂ ಸರಿಯಾಗಿದೆ';
      case AppLanguage.tamil: return '✅ எல்லாம் நன்றாக உள்ளது';
      default: return '✅ All looks good today';
    }
  }
  String _getLabel(String type, AppLanguage lang) {
    switch (type) {
      case 'weather':
        switch (lang) {
          case AppLanguage.telugu: return 'వాతావరణం';
          case AppLanguage.hindi: return 'मौसम';
          case AppLanguage.kannada: return 'ಹವಾಮಾನ';
          case AppLanguage.tamil: return 'வானிலை';
          default: return 'Weather';
        }
      case 'action':
        switch (lang) {
          case AppLanguage.telugu: return 'ఈరోజు చర్య';
          case AppLanguage.hindi: return 'आज का कार्य';
          case AppLanguage.kannada: return 'ಇಂದಿನ ಕಾರ್ಯ';
          case AppLanguage.tamil: return 'இன்றைய செயல்';
          default: return 'Today\'s Action';
        }
      case 'market':
        switch (lang) {
          case AppLanguage.telugu: return 'మార్కెట్';
          case AppLanguage.hindi: return 'मंडी';
          case AppLanguage.kannada: return 'ಮಾರುಕಟ್ಟೆ';
          case AppLanguage.tamil: return 'சந்தை';
          default: return 'Market';
        }
      case 'alert':
        switch (lang) {
          case AppLanguage.telugu: return 'హెచ్చరిక';
          case AppLanguage.hindi: return 'चेतावनी';
          case AppLanguage.kannada: return 'ಎಚ್ಚರಿಕೆ';
          case AppLanguage.tamil: return 'எச்சரிக்கை';
          default: return 'Alert';
        }
      case 'summary':
        switch (lang) {
          case AppLanguage.telugu: return '📋 ఈరోజు సారాంశం';
          case AppLanguage.hindi: return '📋 आज का सारांश';
          case AppLanguage.kannada: return '📋 ಇಂದಿನ ಸಾರಾಂಶ';
          case AppLanguage.tamil: return '📋 இன்றைய சுருக்கம்';
          default: return '📋 Today\'s Summary';
        }
      default: return '';
    }
  }
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lang = provider.language;
    final w = provider.weather;
    final market = provider.allMarketItems;
    final cells = [
      (
        label: _getLabel('weather', lang),
        content: _weatherCell(w, lang),
        color: Color(0xFF1565C0),
        icon: Icons.wb_sunny_rounded,
      ),
      (
        label: _getLabel('action', lang),
        content: _actionCell(w, lang),
        color: AppColors.primary,
        icon: Icons.agriculture_rounded,
      ),
      (
        label: _getLabel('market', lang),
        content: _marketCell(market, lang),
        color: Color(0xFF6A1B9A),
        icon: Icons.show_chart_rounded,
      ),
      (
        label: _getLabel('alert', lang),
        content: _warningCell(w, market, lang),
        color: Color(0xFFB71C1C),
        icon: Icons.notification_important_rounded,
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.today_rounded, color: AppColors.primary, size: 18),
            SizedBox(width: 6),
            Text(
              lang == AppLanguage.telugu ? '📋 ఈరోజు సారాంశం' : '📋 Today\'s Summary',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.5,
          children: cells.asMap().entries.map((e) {
            final cell = e.value;
            return Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cell.color.withOpacity(0.07),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: cell.color.withOpacity(0.18)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(cell.icon, color: cell.color, size: 15),
                      SizedBox(width: 4),
                      Text(
                        cell.label,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: cell.color,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Expanded(
                    child: Text(
                      cell.content,
                      style: TextStyle(
                        fontSize: 11.5,
                        height: 1.4,
                        color: isDark ? AppColors.darkText : AppColors.textDark,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ).animate(delay: Duration(milliseconds: e.key * 80))
              .fadeIn(duration: 350.ms)
              .slideY(begin: 0.1);
          }).toList(),
        ),
      ],
    );
  }
}
