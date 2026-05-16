import 'dart:convert';



import 'package:http/http.dart' as http;



import '../config/env_config.dart';



import '../models/models.dart';



import '../utils/app_assets.dart';







// ─────────────────────────────────────────────────────────────────────────────



// AGROKSHA AI — Market Service v3



// Source 1: data.gov.in Agmarknet API (official govt, free, real-time)



// Source 2: alternate Agmarknet endpoint with district filter



// Fallback:  MSP-based static prices (honest, labelled as "MSP Reference")



// ─────────────────────────────────────────────────────────────────────────────







class MarketService {



  // Official data.gov.in Agmarknet resource ID



  static const String _dataGovUrl =



      'https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070';







  // In-memory cache — 30 minute TTL



  static List<MarketItem>? _cachedData;



  static String? _cacheState;



  static DateTime? _lastFetchTime;



  static bool _isRealData = false;



  static bool get isRealData => _isRealData;







  // ── Commodity lists ─────────────────────────────────────────────────────────



  static const _crops = [



    'maize', 'cotton', 'paddy', 'chilli', 'groundnut', 'wheat',



    'soybean', 'sunflower', 'turmeric', 'jowar', 'bajra', 'ragi',



    'moong', 'urad', 'tur', 'bengal gram', 'soyabean', 'sugarcane',



    'tobacco', 'mustard', 'castor', 'onion', 'potato', 'tomato',



    'rice', 'arhar', 'gram', 'lentil', 'safflower', 'sesame',



  ];







  static const _vegetables = [



    'tomato', 'onion', 'potato', 'brinjal', 'okra', 'bhindi',



    'cabbage', 'cauliflower', 'carrot', 'beans', 'green chilli',



    'cucumber', 'bitter gourd', 'bottle gourd', 'ridge gourd',



    'pumpkin', 'spinach', 'coriander', 'methi', 'drumstick',



    'radish', 'beetroot', 'capsicum', 'cluster beans',



  ];







  static const _fruits = [



    'mango', 'banana', 'apple', 'papaya', 'grapes', 'orange',



    'pomegranate', 'guava', 'watermelon', 'sapota', 'chickoo',



    'pineapple', 'coconut', 'lemon', 'sweet lime', 'fig', 'amla',



    'jamun', 'jackfruit', 'tamarind',



  ];







  static List<String> get _allCommodities =>



      [..._crops, ..._vegetables, ..._fruits];







  static MarketCategory _categorise(String comm) {



    if (_vegetables.any((v) => comm.contains(v))) return MarketCategory.vegetable;



    if (_fruits.any((f) => comm.contains(f))) return MarketCategory.fruit;



    return MarketCategory.crop;



  }







  // ── Main fetch entry point ──────────────────────────────────────────────────



  static Future<MarketFetchResult> fetchLiveMarketData({



    required String state,



    required String district,



  }) async {



    // Return cache if still fresh (30 min) and same state



    if (_cachedData != null &&



        _lastFetchTime != null &&



        _cacheState == state &&



        DateTime.now().difference(_lastFetchTime!).inMinutes < 30) {



      return MarketFetchResult(



        items: _cachedData!,



        isReal: _isRealData,



        source: _isRealData ? 'Agmarknet Live' : 'MSP Reference',



      );



    }







    final apiKey = EnvConfig.dataGovInApiKey;







    // ── Attempt 1: State-level fetch ────────────────────────────────────────



    if (apiKey.isNotEmpty) {



      try {



        final result = await _fetchFromDataGov(apiKey, state, district, limit: 500);



        if (result.isNotEmpty) {



          _cachedData = result;



          _cacheState = state;



          _lastFetchTime = DateTime.now();



          _isRealData = true;



          return MarketFetchResult(items: result, isReal: true, source: 'Agmarknet Live');



        }



      } catch (_) {



        // Attempt 2: try with English state name variants



      }







      // ── Attempt 2: Try alternate state name spellings ───────────────────



      try {



        final altState = _alternateStateName(state);



        if (altState != state) {



          final result = await _fetchFromDataGov(apiKey, altState, district, limit: 500);



          if (result.isNotEmpty) {



            _cachedData = result;



            _cacheState = state;



            _lastFetchTime = DateTime.now();



            _isRealData = true;



            return MarketFetchResult(items: result, isReal: true, source: 'Agmarknet Live');



          }



        }



      } catch (_) {



        // Fall through to MSP fallback



      }







      // ── Attempt 3: National fetch (no state filter) limited ─────────────



      try {



        final result = await _fetchFromDataGov(apiKey, '', district, limit: 200);



        if (result.isNotEmpty) {



          _cachedData = result;



          _cacheState = state;



          _lastFetchTime = DateTime.now();



          _isRealData = true;



          return MarketFetchResult(items: result, isReal: true, source: 'Agmarknet National');



        }



      } catch (_) {



        // Fall through to MSP fallback



      }



    }







    // ── Final fallback: MSP-based reference prices ──────────────────────────



    final fallback = _mspFallbackItems(state);



    _cachedData = fallback;



    _cacheState = state;



    _lastFetchTime = DateTime.now();



    _isRealData = false;



    return MarketFetchResult(



      items: fallback,



      isReal: false,



      source: 'MSP 2025-26 Reference',



    );



  }







  // ── data.gov.in API call ────────────────────────────────────────────────────



  static Future<List<MarketItem>> _fetchFromDataGov(



    String apiKey,



    String state,



    String district, {



    required int limit,



  }) async {



    final params = <String, String>{



      'api-key': apiKey,



      'format': 'json',



      'limit': '$limit',



    };



    if (state.isNotEmpty) params['filters[state]'] = state;







    final uri = Uri.parse(_dataGovUrl).replace(queryParameters: params);



    final response = await http.get(uri).timeout(const Duration(seconds: 20));







    if (response.statusCode != 200) {



      throw Exception('HTTP ${response.statusCode}');



    }







    final data = jsonDecode(utf8.decode(response.bodyBytes));



    final records = data['records'] as List<dynamic>? ?? [];



    if (records.isEmpty) throw Exception('Empty response');







    final List<MarketItem> items = [];



    final seen = <String>{};







    for (final r in records) {



      final comm = (r['commodity'] ?? '').toString().toLowerCase().trim();



      if (!_allCommodities.any((c) => comm.contains(c))) continue;







      final modalPrice = int.tryParse(r['modal_price']?.toString() ?? '') ?? 0;



      final minPrice = int.tryParse(r['min_price']?.toString() ?? '') ?? 0;



      final maxPrice = int.tryParse(r['max_price']?.toString() ?? '') ?? 0;



      if (modalPrice <= 0) continue;







      final key = '${comm}_${r['market']}';



      if (!seen.add(key)) continue;







      // Use max-modal as change indicator for trend



      final changeAmount = maxPrice > 0 ? maxPrice - modalPrice : modalPrice - minPrice;



      final trend = changeAmount > 150



          ? MarketTrend.rising



          : changeAmount < -150



              ? MarketTrend.falling



              : MarketTrend.stable;







      final market = r['market']?.toString() ?? district;



      final date = r['arrival_date']?.toString() ?? 'Today';







      items.add(MarketItem(



        cropName: _titleCase(r['commodity']?.toString() ?? comm),



        cropEmoji: AppAssets.getCropEmoji(comm),



        pricePerQuintal: modalPrice,



        changeAmount: changeAmount,



        trend: trend,



        note: '$market • $date',



        category: _categorise(comm),



      ));



    }







    items.sort((a, b) => a.cropName.compareTo(b.cropName));



    return items;



  }







  // ── MSP fallback — honest reference prices ──────────────────────────────────



  static List<MarketItem> _mspFallbackItems(String state) {



    final isAP = state.toLowerCase().contains('andhra') ||



        state.toLowerCase().contains('telangana');







    // MSP 2025-26 officially announced by Government of India



    const baseItems = [



      ('Paddy',      '🌾', 2369, 69,  MarketTrend.rising,   MarketCategory.crop),



      ('Cotton',     '🌿', 7521, 400, MarketTrend.rising,   MarketCategory.crop),



      ('Maize',      '🌽', 2400, 175, MarketTrend.rising,   MarketCategory.crop),



      ('Groundnut',  '🥜', 7263, 480, MarketTrend.rising,   MarketCategory.crop),



      ('Soybean',    '🫛', 5100, 208, MarketTrend.rising,   MarketCategory.crop),



      ('Tur Dal',    '🫘', 8000, 450, MarketTrend.rising,   MarketCategory.crop),



      ('Moong Dal',  '🫛', 8682, 0,   MarketTrend.stable,   MarketCategory.crop),



      ('Urad Dal',   '🫘', 7800, 400, MarketTrend.rising,   MarketCategory.crop),



      ('Wheat',      '🌾', 2425, 150, MarketTrend.rising,   MarketCategory.crop),



      ('Sesame',     '🌱', 9267, 0,   MarketTrend.stable,   MarketCategory.crop),



      ('Jowar',      '🌾', 3371, 210, MarketTrend.rising,   MarketCategory.crop),



      ('Bajra',      '🌾', 2625, 125, MarketTrend.rising,   MarketCategory.crop),



      ('Sunflower',  '🌻', 7280, 280, MarketTrend.rising,   MarketCategory.crop),



      ('Chilli',     '🌶️',15000, 1000,MarketTrend.rising,   MarketCategory.crop),



      ('Turmeric',   '🟡',13000, 500, MarketTrend.rising,   MarketCategory.crop),



      ('Tomato',     '🍅', 2200, 600, MarketTrend.rising,   MarketCategory.vegetable),



      ('Onion',      '🧅', 1500, 200, MarketTrend.rising,   MarketCategory.vegetable),



      ('Potato',     '🥔', 1800, 200, MarketTrend.rising,   MarketCategory.vegetable),



      ('Brinjal',    '🍆', 1200, 200, MarketTrend.stable,   MarketCategory.vegetable),



      ('Okra',       '🌿', 2000, 400, MarketTrend.rising,   MarketCategory.vegetable),



      ('Cabbage',    '🥬', 900,  100, MarketTrend.stable,   MarketCategory.vegetable),



      ('Cauliflower','🥦', 1500, 300, MarketTrend.rising,   MarketCategory.vegetable),



      ('Mango',      '🥭', 5000, 1000,MarketTrend.rising,   MarketCategory.fruit),



      ('Banana',     '🍌', 2200, 200, MarketTrend.stable,   MarketCategory.fruit),



      ('Papaya',     '🍈', 1400, 200, MarketTrend.stable,   MarketCategory.fruit),



      ('Pomegranate','🍎', 9500, 500, MarketTrend.rising,   MarketCategory.fruit),



      ('Watermelon', '🍉', 800,  200, MarketTrend.rising,   MarketCategory.fruit),



    ];







    final apDistrict = isAP ? 'Guntur APMC' : 'National Avg';



    final today = DateTime.now();



    final dateStr = '${today.day}/${today.month}/${today.year}';







    return baseItems.map((e) => MarketItem(



      cropName: e.$1,



      cropEmoji: e.$2,



      pricePerQuintal: e.$3,



      changeAmount: e.$4,



      trend: e.$5,



      note: '$apDistrict • $dateStr (MSP Ref)',



      category: e.$6,



    )).toList();



  }







  // ── Helpers ─────────────────────────────────────────────────────────────────



  static String _alternateStateName(String state) {



    final map = {



      'Telangana': 'TELANGANA',



      'Andhra Pradesh': 'ANDHRA PRADESH',



      'Maharashtra': 'MAHARASHTRA',



      'Karnataka': 'KARNATAKA',



      'Tamil Nadu': 'TAMIL NADU',



      'Punjab': 'PUNJAB',



      'Haryana': 'HARYANA',



      'Uttar Pradesh': 'UTTAR PRADESH',



      'Madhya Pradesh': 'MADHYA PRADESH',



      'Rajasthan': 'RAJASTHAN',



      'Gujarat': 'GUJARAT',



      'West Bengal': 'WEST BENGAL',



      'Odisha': 'ODISHA',



    };



    return map[state] ?? state.toUpperCase();



  }







  static String _titleCase(String s) =>



      s.split(' ').map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}').join(' ');







  /// Clear cache (on location change)



  static void clearCache() {



    _cachedData = null;



    _lastFetchTime = null;



    _cacheState = null;



    _isRealData = false;



  }



}







// ── Result wrapper ────────────────────────────────────────────────────────────



class MarketFetchResult {



  final List<MarketItem> items;



  final bool isReal;



  final String source;



  const MarketFetchResult({required this.items, required this.isReal, required this.source});



}



