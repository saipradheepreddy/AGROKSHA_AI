// ─────────────────────────────────────────────────────────────────────────────



// AGROKSHA AI — Premium Market Screen v3



// Tabs: Crops | Vegetables | Fruits  •  Search  •  Filter  •  Sort  •  Images



// ─────────────────────────────────────────────────────────────────────────────







import 'package:flutter/material.dart';



import 'package:flutter_animate/flutter_animate.dart';



import 'package:provider/provider.dart';



import '../theme/app_theme.dart';



import '../utils/app_provider.dart';



import '../utils/app_assets.dart';



import '../models/models.dart';







enum _SortMode { nameAsc, priceHigh, priceLow, trending }







class MarketScreen extends StatefulWidget {



  const MarketScreen({super.key});







  @override



  State<MarketScreen> createState() => _MarketScreenState();



}







class _MarketScreenState extends State<MarketScreen>



    with SingleTickerProviderStateMixin {



  late TabController _tabCtrl;



  final TextEditingController _searchCtrl = TextEditingController();



  _SortMode _sortMode = _SortMode.nameAsc;



  String _searchQuery = '';







  @override



  void initState() {



    super.initState();



    _tabCtrl = TabController(length: 3, vsync: this);



    _searchCtrl.addListener(() {



      setState(() => _searchQuery = _searchCtrl.text.toLowerCase());



    });



  }







  @override



  void dispose() {



    _tabCtrl.dispose();



    _searchCtrl.dispose();



    super.dispose();



  }







  List<MarketItem> _filter(List<MarketItem> items) {



    var list = items;



    if (_searchQuery.isNotEmpty) {



      list = list



          .where((m) => m.cropName.toLowerCase().contains(_searchQuery))



          .toList();



    }



    switch (_sortMode) {



      case _SortMode.nameAsc:



        list.sort((a, b) => a.cropName.compareTo(b.cropName));



      case _SortMode.priceHigh:



        list.sort((a, b) => b.pricePerQuintal.compareTo(a.pricePerQuintal));



      case _SortMode.priceLow:



        list.sort((a, b) => a.pricePerQuintal.compareTo(b.pricePerQuintal));



      case _SortMode.trending:



        list.sort((a, b) => b.changeAmount.compareTo(a.changeAmount));



    }



    return list;



  }







  @override



  Widget build(BuildContext context) {



    final provider = context.watch<AppProvider>();



    final isDark = Theme.of(context).brightness == Brightness.dark;







    return Scaffold(



      backgroundColor:



          isDark ? AppColors.darkBackground : AppColors.background,



      body: NestedScrollView(



        headerSliverBuilder: (context, _) => [



          // ── Sticky App Bar ──



          SliverAppBar(



            pinned: true,



            floating: true,



            backgroundColor: AppColors.primary,



            expandedHeight: 130,



            flexibleSpace: FlexibleSpaceBar(



              background: Container(



                decoration:



                    const BoxDecoration(gradient: AppColors.heroGradient),



                alignment: Alignment.bottomLeft,



                padding: const EdgeInsets.fromLTRB(20, 0, 20, 60),



                child: SafeArea(



                  child: Column(



                    mainAxisAlignment: MainAxisAlignment.end,



                    crossAxisAlignment: CrossAxisAlignment.start,



                    children: [



                      const Text(



                        '📊 Live Market Prices',



                        style: TextStyle(



                          color: Colors.white,



                          fontSize: 22,



                          fontWeight: FontWeight.w800,



                        ),



                      ),



                      const SizedBox(height: 3),



                      Text(



                        provider.farmerLocation?.state ?? 'Select location',



                        style: TextStyle(



                          color: Colors.white.withOpacity(0.75),



                          fontSize: 13,



                        ),



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



                  controller: _tabCtrl,



                  indicatorColor: Colors.white,



                  indicatorWeight: 3,



                  labelStyle: const TextStyle(



                      fontWeight: FontWeight.w700, fontSize: 13),



                  unselectedLabelStyle: const TextStyle(



                      fontWeight: FontWeight.w500, fontSize: 13),



                  labelColor: Colors.white,



                  unselectedLabelColor: Colors.white60,



                  tabs: const [



                    Tab(text: '🌾 Crops'),



                    Tab(text: '🥦 Vegetables'),



                    Tab(text: '🍎 Fruits'),



                  ],



                ),



              ),



            ),



          ),



        ],



      body: Column(



          children: [



            _buildSearchSortBar(isDark),



            // ── Data source banner ──────────────────────────────────────────



            if (!provider.isMarketLoading && provider.marketSource.isNotEmpty)



              _DataSourceBanner(



                isReal: provider.isMarketReal,



                source: provider.marketSource,



                onRefresh: () => provider.fetchMarketData(),



              ),



            Expanded(



              child: TabBarView(



                controller: _tabCtrl,



                children: [



                  _MarketList(



                    items: _filter(provider.cropMarket),



                    isLoading: provider.isMarketLoading,



                    emptyMsg: 'No crop price data available.\nPull to refresh.',



                    onRetry: () => provider.fetchMarketData(),



                  ),



                  _MarketList(



                    items: _filter(provider.vegetableMarket),



                    isLoading: provider.isMarketLoading,



                    emptyMsg: 'No vegetable data available.\nPull to refresh.',



                    onRetry: () => provider.fetchMarketData(),



                  ),



                  _MarketList(



                    items: _filter(provider.fruitMarket),



                    isLoading: provider.isMarketLoading,



                    emptyMsg: 'No fruit data available.\nPull to refresh.',



                    onRetry: () => provider.fetchMarketData(),



                  ),



                ],



              ),



            ),



          ],



        ),



      ),



    );



  }







  Widget _buildSearchSortBar(bool isDark) {



    return Container(



      color: isDark ? AppColors.darkSurface : Colors.white,



      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),



      child: Row(



        children: [



          // Search



          Expanded(



            child: Container(



              height: 40,



              decoration: BoxDecoration(



                color: isDark ? AppColors.darkBackground : AppColors.background,



                borderRadius: BorderRadius.circular(20),



                border:



                    Border.all(color: AppColors.primary.withOpacity(0.15)),



              ),



              child: TextField(



                controller: _searchCtrl,



                style: const TextStyle(fontSize: 14),



                decoration: const InputDecoration(



                  hintText: 'Search commodity...',



                  hintStyle:



                      TextStyle(color: AppColors.textLight, fontSize: 13),



                  prefixIcon: Icon(Icons.search_rounded,



                      color: AppColors.textLight, size: 20),



                  border: InputBorder.none,



                  contentPadding: EdgeInsets.symmetric(vertical: 10),



                ),



              ),



            ),



          ),



          const SizedBox(width: 10),



          // Sort button



          GestureDetector(



            onTap: _showSortSheet,



            child: Container(



              height: 40,



              padding: const EdgeInsets.symmetric(horizontal: 12),



              decoration: BoxDecoration(



                color: AppColors.primarySurface,



                borderRadius: BorderRadius.circular(20),



                border: Border.all(color: AppColors.primary.withOpacity(0.3)),



              ),



              child: Row(



                children: [



                  const Icon(Icons.sort_rounded,



                      size: 18, color: AppColors.primary),



                  const SizedBox(width: 4),



                  Text(



                    _sortLabel,



                    style: const TextStyle(



                        fontSize: 11,



                        color: AppColors.primary,



                        fontWeight: FontWeight.w700),



                  ),



                ],



              ),



            ),



          ),



        ],



      ),



    );



  }







  String get _sortLabel {



    switch (_sortMode) {



      case _SortMode.nameAsc: return 'A-Z';



      case _SortMode.priceHigh: return 'High ↓';



      case _SortMode.priceLow: return 'Low ↑';



      case _SortMode.trending: return 'Trending';



    }



  }







  void _showSortSheet() {



    showModalBottomSheet(



      context: context,



      shape:



          const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),



      builder: (_) {



        return SafeArea(



          child: Column(



            mainAxisSize: MainAxisSize.min,



            children: [



              const SizedBox(height: 8),



              Container(



                  width: 40,



                  height: 4,



                  decoration: BoxDecoration(



                      color: Colors.grey.shade300,



                      borderRadius: BorderRadius.circular(2))),



              const SizedBox(height: 16),



              const Text('Sort By',



                  style: TextStyle(



                      fontSize: 16, fontWeight: FontWeight.w800)),



              const SizedBox(height: 8),



              ...[



                ('Name A–Z', _SortMode.nameAsc, Icons.sort_by_alpha_rounded),



                ('Price: High → Low', _SortMode.priceHigh, Icons.arrow_downward_rounded),



                ('Price: Low → High', _SortMode.priceLow, Icons.arrow_upward_rounded),



                ('Trending', _SortMode.trending, Icons.trending_up_rounded),



              ].map((opt) => ListTile(



                    leading: Icon(opt.$3, color: AppColors.primary),



                    title: Text(opt.$1,



                        style:



                            const TextStyle(fontWeight: FontWeight.w600)),



                    selected: _sortMode == opt.$2,



                    selectedColor: AppColors.primary,



                    onTap: () {



                      setState(() => _sortMode = opt.$2);



                      Navigator.pop(context);



                    },



                  )),



              const SizedBox(height: 8),



            ],



          ),



        );



      },



    );



  }



}







// ── Market list (reused across tabs) ─────────────────────────────────────────



class _MarketList extends StatelessWidget {



  final List<MarketItem> items;



  final bool isLoading;



  final String emptyMsg;



  final VoidCallback? onRetry;







  const _MarketList({



    required this.items,



    required this.isLoading,



    required this.emptyMsg,



    this.onRetry,



  });







  @override



  Widget build(BuildContext context) {



    if (isLoading) {



      return ListView.builder(



        padding: const EdgeInsets.all(16),



        itemCount: 6,



        itemBuilder: (_, __) => Container(



          height: 84,



          margin: const EdgeInsets.only(bottom: 12),



          decoration: BoxDecoration(



            color: Colors.grey.shade200,



            borderRadius: BorderRadius.circular(18),



          ),



        ),



      );



    }







    if (items.isEmpty) {



      return Center(



        child: Column(



          mainAxisAlignment: MainAxisAlignment.center,



          children: [



            const Text('📭', style: TextStyle(fontSize: 48)),



            const SizedBox(height: 12),



            Text(emptyMsg,



                textAlign: TextAlign.center,



                style: const TextStyle(



                    color: AppColors.textLight,



                    fontSize: 14,



                    fontWeight: FontWeight.w500)),



            const SizedBox(height: 16),



            if (onRetry != null)



              ElevatedButton.icon(



                onPressed: onRetry,



                icon: const Icon(Icons.refresh_rounded, size: 16),



                label: const Text('Refresh Prices'),



                style: ElevatedButton.styleFrom(



                  backgroundColor: AppColors.primary,



                  foregroundColor: Colors.white,



                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),



                ),



              ),



          ],



        ),



      );



    }







    return ListView.builder(



      padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),



      itemCount: items.length + 1,



      itemBuilder: (context, index) {



        if (index == items.length) {



          // Footer disclaimer



          return Padding(



            padding: const EdgeInsets.only(top: 8, bottom: 12),



            child: Row(



              children: [



                const Icon(Icons.info_outline,



                    color: AppColors.primary, size: 14),



                const SizedBox(width: 6),



                const Expanded(



                  child: Text(



                    'Live Agmarknet data. Verify at your local APMC mandi before selling.',



                    style: TextStyle(



                        fontSize: 11, color: AppColors.textLight, height: 1.4),



                  ),



                ),



              ],



            ),



          );



        }



        return MarketItemCard(item: items[index], index: index);



      },



    );



  }



}







// ── Single market item card ───────────────────────────────────────────────────



class MarketItemCard extends StatelessWidget {



  final MarketItem item;



  final int index;







  const MarketItemCard({super.key, required this.item, required this.index});







  Color _trendColor(MarketTrend trend) {



    switch (trend) {



      case MarketTrend.rising: return AppColors.riskLow;



      case MarketTrend.falling: return AppColors.riskHigh;



      case MarketTrend.highDemand: return Colors.orange;



      case MarketTrend.stable: return AppColors.textLight;



    }



  }







  @override



  Widget build(BuildContext context) {



    final isDark = Theme.of(context).brightness == Brightness.dark;



    final accentColor = _trendColor(item.trend);



    final changeStr = item.changeAmount >= 0



        ? '+₹${item.changeAmount}'



        : '-₹${item.changeAmount.abs()}';







    return Container(



      margin: const EdgeInsets.only(bottom: 12),



      decoration: BoxDecoration(



        color: isDark ? AppColors.darkCard : Colors.white,



        borderRadius: BorderRadius.circular(18),



        boxShadow: AppTheme.cardShadow,



        border: Border.all(color: accentColor.withOpacity(0.12)),



      ),



      child: Row(



        children: [



          // Crop image



          ClipRRect(



            borderRadius: const BorderRadius.only(



              topLeft: Radius.circular(18),



              bottomLeft: Radius.circular(18),



            ),



            child: Image.network(



              AppAssets.getCropImage(item.cropName),



              width: 72,



              height: 80,



              fit: BoxFit.cover,



              errorBuilder: (_, __, ___) => Container(



                width: 72,



                height: 80,



                color: accentColor.withOpacity(0.1),



                child: Center(



                  child: Text(item.cropEmoji,



                      style: const TextStyle(fontSize: 28)),



                ),



              ),



            ),



          ),



          const SizedBox(width: 14),



          // Name + market note



          Expanded(



            child: Padding(



              padding: const EdgeInsets.symmetric(vertical: 12),



              child: Column(



                crossAxisAlignment: CrossAxisAlignment.start,



                children: [



                  Text(



                    item.cropName,



                    style: const TextStyle(



                        fontSize: 15, fontWeight: FontWeight.w700),



                    overflow: TextOverflow.ellipsis,



                  ),



                  const SizedBox(height: 3),



                  Text(



                    item.note,



                    style: const TextStyle(



                        fontSize: 11, color: AppColors.textLight),



                    overflow: TextOverflow.ellipsis,



                  ),



                ],



              ),



            ),



          ),



          // Price column



          Padding(



            padding: const EdgeInsets.only(right: 14),



            child: Column(



              crossAxisAlignment: CrossAxisAlignment.end,



              mainAxisAlignment: MainAxisAlignment.center,



              children: [



                Text(



                  '₹${item.pricePerQuintal}',



                  style: TextStyle(



                    fontSize: 17,



                    fontWeight: FontWeight.w800,



                    color: isDark ? AppColors.darkText : AppColors.textDark,



                  ),



                ),



                const Text('/qtl',



                    style: TextStyle(



                        fontSize: 10, color: AppColors.textLight)),



                const SizedBox(height: 4),



                Container(



                  padding:



                      const EdgeInsets.symmetric(horizontal: 7, vertical: 3),



                  decoration: BoxDecoration(



                    color: accentColor.withOpacity(0.12),



                    borderRadius: BorderRadius.circular(50),



                  ),



                  child: Text(



                    '$changeStr ${item.trend.emoji}',



                    style: TextStyle(



                        fontSize: 10,



                        fontWeight: FontWeight.w700,



                        color: accentColor),



                  ),



                ),



              ],



            ),



          ),



        ],



      ),



    )



        .animate(delay: Duration(milliseconds: index * 60))



        .fadeIn(duration: 400.ms)



        .slideX(begin: 0.15, end: 0, curve: Curves.easeOutCubic);



  }



}







// ── Data source banner ────────────────────────────────────────────────────────



class _DataSourceBanner extends StatelessWidget {



  final bool isReal;



  final String source;



  final VoidCallback onRefresh;



  const _DataSourceBanner({



    required this.isReal, required this.source, required this.onRefresh,



  });







  @override



  Widget build(BuildContext context) {



    final color = isReal ? AppColors.riskLow : AppColors.riskMedium;



    final icon  = isReal ? Icons.wifi_rounded : Icons.info_outline_rounded;



    final label = isReal



        ? '🟢 Live: $source'



        : '🟡 Reference: $source (Live unavailable today)';







    return Container(



      width: double.infinity,



      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),



      color: color.withOpacity(0.08),



      child: Row(children: [



        Icon(icon, size: 14, color: color),



        const SizedBox(width: 6),



        Expanded(child: Text(label,



            style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600))),



        GestureDetector(



          onTap: onRefresh,



          child: Icon(Icons.refresh_rounded, size: 18, color: color),



        ),



      ]),



    );



  }



}



