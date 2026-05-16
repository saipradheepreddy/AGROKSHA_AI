/// ─────────────────────────────────────────────────────────────────────────────



/// AGROKSHA AI — Mock Data Repository v2



/// Weather fallback, crop risks, market demand, smart suggestions



/// Replace API call sections with real backend when ready



/// ─────────────────────────────────────────────────────────────────────────────







import '../models/models.dart';







class MockData {



  MockData._();







  // ── Fallback Weather (used if API fails) ──────────────────────────────────



  static const WeatherModel fallbackWeather = WeatherModel(



    temperature: 33.5,



    apparentTemperature: 36.2,



    humidity: 68,



    rainChance: 40,



    windSpeed: 14,



    condition: 'Partly Cloudy',



    conditionIcon: '⛅',



    locationName: 'Your Location',



    sunrise: '06:12',



    sunset: '18:45',



  );







  static const List<WeatherDay> fallbackForecast = [



    WeatherDay(date: '', dayLabel: 'Mon', emoji: '⛅', condition: 'Partly Cloudy', maxTemp: 34, minTemp: 24, rainChance: 30),



    WeatherDay(date: '', dayLabel: 'Tue', emoji: '🌧️', condition: 'Rain', maxTemp: 29, minTemp: 22, rainChance: 75),



    WeatherDay(date: '', dayLabel: 'Wed', emoji: '🌦️', condition: 'Showers', maxTemp: 31, minTemp: 23, rainChance: 60),



    WeatherDay(date: '', dayLabel: 'Thu', emoji: '☀️', condition: 'Clear Sky', maxTemp: 36, minTemp: 25, rainChance: 10),



    WeatherDay(date: '', dayLabel: 'Fri', emoji: '⛅', condition: 'Partly Cloudy', maxTemp: 35, minTemp: 24, rainChance: 20),



    WeatherDay(date: '', dayLabel: 'Sat', emoji: '⛅', condition: 'Partly Cloudy', maxTemp: 34, minTemp: 23, rainChance: 25),



    WeatherDay(date: '', dayLabel: 'Sun', emoji: '☀️', condition: 'Clear Sky', maxTemp: 37, minTemp: 26, rainChance: 5),



  ];







  // ── Crop Risk by Location ──────────────────────────────────────────────────



  static List<CropRiskModel> locationCropRisks = [



    const CropRiskModel(cropName: 'Rice', cropEmoji: '🌾', riskLevel: RiskLevel.high, riskPercentage: 82, description: 'Blast disease risk high'),



    const CropRiskModel(cropName: 'Cotton', cropEmoji: '🌿', riskLevel: RiskLevel.medium, riskPercentage: 54, description: 'Bollworm pressure moderate'),



    const CropRiskModel(cropName: 'Maize', cropEmoji: '🌽', riskLevel: RiskLevel.none, riskPercentage: 14, description: 'Good growing conditions'),



    const CropRiskModel(cropName: 'Groundnut', cropEmoji: '🥜', riskLevel: RiskLevel.low, riskPercentage: 20, description: 'Minor leaf spot risk'),



    const CropRiskModel(cropName: 'Chilli', cropEmoji: '🌶️', riskLevel: RiskLevel.medium, riskPercentage: 58, description: 'Thrips & viral pressure'),



  ];







  // ── Smart Farmer Suggestions Pool ──────────────────────────────────────────



  static const List<FarmerSuggestion> allSuggestions = [



    FarmerSuggestion(



      type: SuggestionType.sowing,



      titleEn: 'Good week for Maize sowing',



      titleTe: 'మొక్కజొన్న విత్తనానికి మంచి వారం',



      titleHi: 'मक्का बोने के लिए अच्छा सप्ताह',



      descriptionEn: 'Soil moisture is ideal. Sow maize in the next 3 days for best germination.',



      descriptionTe: 'నేల తేమ అనుకూలంగా ఉంది. ఉత్తమ మొలకెత్తడానికి రాబోయే 3 రోజుల్లో మొక్కజొన్న విత్తండి.',



      descriptionHi: 'मिट्टी की नमी आदर्श है। सर्वोत्तम अंकुरण के लिए अगले 3 दिनों में मक्का बोएं।',



    ),



    FarmerSuggestion(



      type: SuggestionType.market,



      titleEn: 'Cotton demand rising in your district',



      titleTe: 'మీ జిల్లాలో పత్తి డిమాండ్ పెరుగుతోంది',



      titleHi: 'आपके जिले में कपास की मांग बढ़ रही है',



      descriptionEn: 'Cotton prices up ₹200/qtl this week. Good time to sell if you have stock.',



      descriptionTe: 'ఈ వారం పత్తి ధరలు ₹200/క్వింటాల్ పెరిగాయి. స్టాక్ ఉంటే అమ్మడానికి మంచి సమయం.',



      descriptionHi: 'इस हफ्ते कपास की कीमतें ₹200/क्विंटल बढ़ी हैं। अगर स्टॉक है तो बेचने का अच्छा समय।',



    ),



    FarmerSuggestion(



      type: SuggestionType.pesticide,



      titleEn: 'Delay pesticide spray — rain expected',



      titleTe: 'పురుగుమందు పిచికారీ వాయిదా వేయండి — వర్షం ఆశించబడుతోంది',



      titleHi: 'कीटनाशक छिड़काव में देरी करें — बारिश की संभावना',



      descriptionEn: '45% rain chance tomorrow. Spray after 2 days to save chemicals and maximize effect.',



      descriptionTe: 'రేపు 45% వర్షం అవకాశం. రసాయనాలు ఆదా చేయడానికి 2 రోజుల తర్వాత పిచికారీ చేయండి.',



      descriptionHi: 'कल 45% बारिश की संभावना। रसायन बचाने के लिए 2 दिन बाद छिड़काव करें।',



    ),



    FarmerSuggestion(



      type: SuggestionType.irrigation,



      titleEn: 'Best irrigation time is evening today',



      titleTe: 'నేడు సాయంత్రం నీటిపారుదలకు ఉత్తమ సమయం',



      titleHi: 'आज शाम का सिंचाई का सबसे अच्छा समय है',



      descriptionEn: 'Temperature peaks at 36°C today. Irrigate after 5 PM to reduce evaporation loss.',



      descriptionTe: 'నేడు తాపమాపం 36°C గరిష్ఠానికి చేరుకుంటుంది. ఆవిరి నష్టం తగ్గించడానికి సాయంత్రం 5 తర్వాత నీరు పెట్టండి.',



      descriptionHi: 'आज तापमान 36°C तक पहुंचेगा। वाष्पीकरण नुकसान कम करने के लिए शाम 5 बजे के बाद सिंचाई करें।',



    ),



    FarmerSuggestion(



      type: SuggestionType.market,



      titleEn: 'Tomato prices may fall this week',



      titleTe: 'ఈ వారం టొమాటో ధరలు తగ్గవచ్చు',



      titleHi: 'इस हफ्ते टमाटर की कीमतें गिर सकती हैं',



      descriptionEn: 'Increased supply from Kurnool & Prakasam. Sell tomato stock early in the week.',



      descriptionTe: 'కర్నూల్ & ప్రకాశం నుండి సరఫరా పెరిగింది. వారం ప్రారంభంలో టొమాటో స్టాక్ అమ్మండి.',



      descriptionHi: 'कर्नूल और प्रकाशम से आपूर्ति बढ़ी। हफ्ते की शुरुआत में टमाटर स्टॉक बेचें।',



    ),



    FarmerSuggestion(



      type: SuggestionType.harvest,



      titleEn: 'Groundnut harvest window — 5 days',



      titleTe: 'వేరుశెనగ కోత కిటికీ — 5 రోజులు',



      titleHi: 'मूंगफली की कटाई का समय — 5 दिन',



      descriptionEn: 'Dry spell expected for 5 days. Ideal window to harvest and dry groundnut pods.',



      descriptionTe: '5 రోజులు పొడి వాతావరణం ఆశించబడుతోంది. వేరుశెనగ కోసి ఆరబెట్టడానికి అనువైన సమయం.',



      descriptionHi: '5 दिनों का सूखा मौसम अपेक्षित है। मूंगफली काटने और सुखाने के लिए आदर्श समय।',



    ),



    FarmerSuggestion(



      type: SuggestionType.weather,



      titleEn: 'Heat wave alert — protect seedlings',



      titleTe: 'వేడిగాలుల హెచ్చరిక — మొక్కలను రక్షించండి',



      titleHi: 'लू का अलर्ट — पौधों को बचाएं',



      descriptionEn: 'Temperature above 40°C expected next 2 days. Shade young plants and increase watering.',



      descriptionTe: 'రాబోయే 2 రోజులు ఉష్ణోగ్రత 40°C పైన ఉంటుంది. చిన్న మొక్కలకు నీడ కల్పించి నీరు పెంచండి.',



      descriptionHi: 'अगले 2 दिनों में तापमान 40°C से ऊपर रहेगा। छोटे पौधों को छाया दें और पानी बढ़ाएं।',



    ),



    FarmerSuggestion(



      type: SuggestionType.sowing,



      titleEn: 'Paddy transplanting season starts',



      titleTe: 'వరి నాట్లు సీజన్ ప్రారంభం',



      titleHi: 'धान रोपाई का मौसम शुरू',



      descriptionEn: 'Kharif paddy transplanting ideal in your region. Nursery beds should be ready.',



      descriptionTe: 'మీ ప్రాంతంలో ఖరీఫ్ వరి నాట్లు వేయడానికి అనువైన సమయం. నర్సరీ మడి సిద్ధంగా ఉండాలి.',



      descriptionHi: 'आपके क्षेत्र में खरीफ धान रोपाई आदर्श। नर्सरी क्यारी तैयार होनी चाहिए।',



    ),



  ];







  /// Get today's suggestion (rotates by day of year)



  static FarmerSuggestion todaySuggestion() {



    final day = DateTime.now().dayOfYear;



    return allSuggestions[day % allSuggestions.length];



  }







  // ── Market Demand Data ─────────────────────────────────────────────────────



  static const List<MarketItem> marketItems = [



    // High demand / rising



    MarketItem(cropName: 'Cotton', cropEmoji: '🌿', pricePerQuintal: 6800, changeAmount: 200, trend: MarketTrend.rising, note: 'Export demand high'),



    MarketItem(cropName: 'Maize', cropEmoji: '🌽', pricePerQuintal: 2100, changeAmount: 120, trend: MarketTrend.rising, note: 'Poultry feed demand'),



    MarketItem(cropName: 'Groundnut', cropEmoji: '🥜', pricePerQuintal: 5400, changeAmount: 80, trend: MarketTrend.highDemand, note: 'Oil mills active'),



    MarketItem(cropName: 'Soybean', cropEmoji: '🫘', pricePerQuintal: 3900, changeAmount: 150, trend: MarketTrend.rising, note: 'MSP increased'),



    // Stable



    MarketItem(cropName: 'Wheat', cropEmoji: '🌾', pricePerQuintal: 2275, changeAmount: 0, trend: MarketTrend.stable, note: 'Gov MSP stable'),



    MarketItem(cropName: 'Paddy', cropEmoji: '🌾', pricePerQuintal: 2183, changeAmount: 0, trend: MarketTrend.stable, note: 'MSP guaranteed'),



    // Falling alerts



    MarketItem(cropName: 'Tomato', cropEmoji: '🍅', pricePerQuintal: 800, changeAmount: -300, trend: MarketTrend.falling, note: 'Oversupply from AP'),



    MarketItem(cropName: 'Onion', cropEmoji: '🧅', pricePerQuintal: 1200, changeAmount: -200, trend: MarketTrend.falling, note: 'Import pressure low'),



    MarketItem(cropName: 'Chilli', cropEmoji: '🌶️', pricePerQuintal: 9500, changeAmount: -400, trend: MarketTrend.falling, note: 'Guntur surplus'),



    // Best sellers



    MarketItem(cropName: 'Sunflower', cropEmoji: '🌻', pricePerQuintal: 5800, changeAmount: 100, trend: MarketTrend.rising, note: 'Good oil demand'),



    MarketItem(cropName: 'Turmeric', cropEmoji: '🟡', pricePerQuintal: 12000, changeAmount: 500, trend: MarketTrend.highDemand, note: 'Export booming'),



  ];







  static List<MarketItem> get risingItems => marketItems.where((m) => m.trend == MarketTrend.rising || m.trend == MarketTrend.highDemand).toList();



  static List<MarketItem> get fallingItems => marketItems.where((m) => m.trend == MarketTrend.falling).toList();



  static List<MarketItem> get highDemandItems => marketItems.where((m) => m.trend == MarketTrend.highDemand).toList();



  static List<MarketItem> get bestSellers => marketItems.where((m) => m.changeAmount > 0).take(5).toList();







  // ── Crop Recommendations (Soil × Season) ──────────────────────────────────



  static const Map<String, List<CropRecommendation>> _recommendations = {



    'black_kharif': [



      CropRecommendation(cropName: 'Cotton', cropEmoji: '🌿', riskLevel: RiskLevel.low, riskPercentage: 18, suitabilityNote: 'Excellent — black soil retains moisture', benefits: ['High market value', 'Deep root suits clay', 'Good rainfall use']),



      CropRecommendation(cropName: 'Soybean', cropEmoji: '🫘', riskLevel: RiskLevel.none, riskPercentage: 10, suitabilityNote: 'Ideal, nitrogen-fixing crop', benefits: ['Soil enrichment', 'Short duration', 'Good export demand']),



      CropRecommendation(cropName: 'Paddy', cropEmoji: '🌾', riskLevel: RiskLevel.high, riskPercentage: 79, suitabilityNote: 'High water demand may strain resources', benefits: ['Staple crop', 'MSP support']),



    ],



    'black_rabi': [



      CropRecommendation(cropName: 'Wheat', cropEmoji: '🌾', riskLevel: RiskLevel.none, riskPercentage: 8, suitabilityNote: 'Best Rabi crop for black soil', benefits: ['High yield', 'MSP guaranteed', 'Cool season']),



      CropRecommendation(cropName: 'Chickpea', cropEmoji: '🫘', riskLevel: RiskLevel.low, riskPercentage: 22, suitabilityNote: 'Excellent protein crop for Rabi', benefits: ['Drought tolerant', 'Nitrogen fixer', 'Good price']),



    ],



    'black_summer': [



      CropRecommendation(cropName: 'Sunflower', cropEmoji: '🌻', riskLevel: RiskLevel.medium, riskPercentage: 48, suitabilityNote: 'Heat tolerant, good for summer', benefits: ['Oil crop', 'Short duration', 'Decent MSP']),



      CropRecommendation(cropName: 'Watermelon', cropEmoji: '🍉', riskLevel: RiskLevel.low, riskPercentage: 28, suitabilityNote: 'Profitable summer cash crop', benefits: ['High market price', 'Short duration']),



    ],



    'red_kharif': [



      CropRecommendation(cropName: 'Groundnut', cropEmoji: '🥜', riskLevel: RiskLevel.none, riskPercentage: 12, suitabilityNote: 'Thrives in well-drained red soil', benefits: ['Oil & protein crop', 'Nitrogen fixing']),



      CropRecommendation(cropName: 'Sunflower', cropEmoji: '🌻', riskLevel: RiskLevel.medium, riskPercentage: 48, suitabilityNote: 'Moderate risk due to drought spells', benefits: ['Oil crop', 'Good price support']),



      CropRecommendation(cropName: 'Paddy', cropEmoji: '🌾', riskLevel: RiskLevel.high, riskPercentage: 79, suitabilityNote: 'Not ideal — red soil drains too fast', benefits: ['Familiar crop']),



    ],



    'red_rabi': [



      CropRecommendation(cropName: 'Ragi', cropEmoji: '🌾', riskLevel: RiskLevel.none, riskPercentage: 9, suitabilityNote: 'Highly adapted to red soil', benefits: ['Nutritious', 'Drought tolerant', 'Low input cost']),



      CropRecommendation(cropName: 'Mustard', cropEmoji: '🌼', riskLevel: RiskLevel.low, riskPercentage: 25, suitabilityNote: 'Cool weather suits mustard in Rabi', benefits: ['Oil crop', 'Short duration']),



    ],



    'red_summer': [



      CropRecommendation(cropName: 'Watermelon', cropEmoji: '🍉', riskLevel: RiskLevel.low, riskPercentage: 18, suitabilityNote: 'Sandy red soil is ideal for watermelon', benefits: ['Premium prices', 'Water efficient']),



    ],



    'sandy_kharif': [



      CropRecommendation(cropName: 'Pearl Millet', cropEmoji: '🌾', riskLevel: RiskLevel.none, riskPercentage: 7, suitabilityNote: 'Best crop for sandy, arid conditions', benefits: ['Extreme drought tolerance', 'Low water need']),



      CropRecommendation(cropName: 'Moong Dal', cropEmoji: '🫘', riskLevel: RiskLevel.low, riskPercentage: 20, suitabilityNote: 'Short duration, good for sandy soils', benefits: ['Protein crop', 'Quick income']),



    ],



    'sandy_rabi': [



      CropRecommendation(cropName: 'Mustard', cropEmoji: '🌼', riskLevel: RiskLevel.none, riskPercentage: 15, suitabilityNote: 'Sandy soil + cool climate = ideal', benefits: ['Low input', 'Good price']),



    ],



    'sandy_summer': [



      CropRecommendation(cropName: 'Watermelon', cropEmoji: '🍉', riskLevel: RiskLevel.none, riskPercentage: 11, suitabilityNote: 'Sandy soil is perfect for melons', benefits: ['High profit', 'Summer demand']),



    ],



    'loamy_kharif': [



      CropRecommendation(cropName: 'Paddy', cropEmoji: '🌾', riskLevel: RiskLevel.none, riskPercentage: 10, suitabilityNote: 'Loamy soil = perfect moisture for paddy', benefits: ['High yield', 'MSP support']),



      CropRecommendation(cropName: 'Maize', cropEmoji: '🌽', riskLevel: RiskLevel.low, riskPercentage: 19, suitabilityNote: 'Excellent in well-drained loamy soil', benefits: ['Fodder & grain', 'Good market']),



    ],



    'loamy_rabi': [



      CropRecommendation(cropName: 'Wheat', cropEmoji: '🌾', riskLevel: RiskLevel.none, riskPercentage: 6, suitabilityNote: 'Best combination — loamy + Rabi', benefits: ['Maximum yield', 'MSP solid']),



      CropRecommendation(cropName: 'Potato', cropEmoji: '🥔', riskLevel: RiskLevel.low, riskPercentage: 25, suitabilityNote: 'Deep loamy soil suits tuber crops', benefits: ['Profitable', 'High demand']),



    ],



    'loamy_summer': [



      CropRecommendation(cropName: 'Vegetables (Mixed)', cropEmoji: '🥦', riskLevel: RiskLevel.low, riskPercentage: 22, suitabilityNote: 'Loamy soil = perfect vegetable garden', benefits: ['Quick income', 'Multiple crops']),



    ],



    'clay_kharif': [



      CropRecommendation(cropName: 'Paddy', cropEmoji: '🌾', riskLevel: RiskLevel.low, riskPercentage: 20, suitabilityNote: 'Clay holds water — perfect for paddy', benefits: ['Ideal match', 'High yield']),



      CropRecommendation(cropName: 'Jute', cropEmoji: '🌿', riskLevel: RiskLevel.none, riskPercentage: 12, suitabilityNote: 'Clay + humid = excellent jute growth', benefits: ['Cash crop', 'Eco-friendly']),



    ],



    'clay_rabi': [



      CropRecommendation(cropName: 'Chickpea', cropEmoji: '🫘', riskLevel: RiskLevel.medium, riskPercentage: 40, suitabilityNote: 'Clay can waterlog — drainage needed', benefits: ['Protein crop', 'Manageable risk']),



    ],



    'clay_summer': [



      CropRecommendation(cropName: 'Sugarcane', cropEmoji: '🎋', riskLevel: RiskLevel.low, riskPercentage: 25, suitabilityNote: 'Clay retains moisture for long crop', benefits: ['High value', 'Long-term income']),



    ],



  };







  static List<CropRecommendation> getRecommendations(SoilType soil, Season season) {



    final key = '${soil.key}_${season.key}';



    return _recommendations[key] ?? const [



      CropRecommendation(



        cropName: 'General Advisory',



        cropEmoji: '🌱',



        riskLevel: RiskLevel.none,



        riskPercentage: 15,



        suitabilityNote: 'Consult your local Krishi Vigyan Kendra',



        benefits: ['Professional guidance', 'Location-specific data', 'Free service'],



      ),



    ];



  }







  // ── Daily Care Tips (rotate by day of year) ───────────────────────────────



  static const _careTips = [



    DailyCareTip(



      emoji: '🌅', title: 'Best Watering Time',



      message: 'Water your crops early morning (6–8 AM) to reduce evaporation and maximise absorption.',



      category: 'watering',



    ),



    DailyCareTip(



      emoji: '⚠️', title: 'Avoid Spraying Today',



      message: 'Rain is expected today. Avoid spraying fertilizers or pesticides — wait for a dry day.',



      category: 'weather',



    ),



    DailyCareTip(



      emoji: '🧪', title: 'Good Day for Fertilizer',



      message: 'Clear skies today! Apply nitrogen fertilizer in the morning for best absorption.',



      category: 'fertilizer',



    ),



    DailyCareTip(



      emoji: '🐛', title: 'Pest Watch Alert',



      message: 'High humidity today. Inspect leaf undersides for aphids, whiteflies and leaf miners.',



      category: 'pest',



    ),



    DailyCareTip(



      emoji: '💧', title: 'Irrigation Reminder',



      message: 'Check soil moisture by digging 2 inches. If dry, irrigate in the evening to prevent wilting.',



      category: 'watering',



    ),



    DailyCareTip(



      emoji: '🌿', title: 'Weed Control',



      message: 'Remove weeds around the base of plants to reduce nutrient competition and disease risk.',



      category: 'pest',



    ),



    DailyCareTip(



      emoji: '🌾', title: 'Harvest Check',



      message: 'Check grain colour and moisture. Harvest at 14–16% moisture for best quality storage.',



      category: 'harvest',



    ),



    DailyCareTip(



      emoji: '☀️', title: 'Hot Day Alert',



      message: 'Temperature above 38°C today. Provide shade netting for vegetable crops and increase irrigation.',



      category: 'weather',



    ),



  ];







  static DailyCareTip todayCareTip() {



    final idx = DateTime.now().dayOfYear % _careTips.length;



    return _careTips[idx];



  }



}







extension on DateTime {



  int get dayOfYear {



    final start = DateTime(year, 1, 1);



    return difference(start).inDays;



  }



}



