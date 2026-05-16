import 'package:flutter/material.dart';

class S {
  S._();
  static const appName = 'appName';
  static const appNameVoice = 'appNameVoice';
  static const tagline = 'tagline';
  static const devTeam = 'devTeam';
  static const welcomeHeader = 'welcomeHeader';
  static const welcomeSub = 'welcomeSub';
  static const email = 'email';
  static const password = 'password';
  static const fullName = 'fullName';
  static const login = 'login';
  static const signUp = 'signUp';
  static const forgotPassword = 'forgotPassword';
  static const continueGuest = 'continueGuest';
  static const noAccount = 'noAccount';
  static const haveAccount = 'haveAccount';
  static const clickHere = 'clickHere';
  static const dashboard = 'dashboard';
  static const goodMorning = 'goodMorning';
  static const goodAfternoon = 'goodAfternoon';
  static const goodEvening = 'goodEvening';
  static const farmerFriend = 'farmerFriend';
  static const todayInsights = 'todayInsights';
  static const currentLocation = 'currentLocation';
  static const changeLocation = 'changeLocation';
  static const weatherToday = 'weatherToday';
  static const feelsLike = 'feelsLike';
  static const humidity = 'humidity';
  static const rain = 'rain';
  static const wind = 'wind';
  static const sunrise = 'sunrise';
  static const sunset = 'sunset';
  static const forecast = 'forecast';
  static const refreshWeather = 'refreshWeather';
  static const loadingWeather = 'loadingWeather';
  static const weatherError = 'weatherError';
  static const todaySuggestion = 'todaySuggestion';
  static const suggestions = 'suggestions';
  static const cropRisk = 'cropRisk';
  static const highRisk = 'highRisk';
  static const mediumRisk = 'mediumRisk';
  static const lowRisk = 'lowRisk';
  static const noRisk = 'noRisk';
  static const based = 'based';
  static const market = 'market';
  static const marketDemand = 'marketDemand';
  static const highDemand = 'highDemand';
  static const risingPrices = 'risingPrices';
  static const fallingAlerts = 'fallingAlerts';
  static const bestSellers = 'bestSellers';
  static const perQuintal = 'perQuintal';
  static const recommend = 'recommend';
  static const soilType = 'soilType';
  static const season = 'season';
  static const analyze = 'analyze';
  static const results = 'results';
  static const resetAnalyze = 'resetAnalyze';
  static const selectSoil = 'selectSoil';
  static const selectSeason = 'selectSeason';
  static const analyzing = 'analyzing';
  static const selectLocation = 'selectLocation';
  static const selectState = 'selectState';
  static const selectDistrict = 'selectDistrict';
  static const selectMandal = 'selectMandal';
  static const enterVillage = 'enterVillage';
  static const saveLocation = 'saveLocation';
  static const locationSaved = 'locationSaved';
  static const locationSetupTitle = 'locationSetupTitle';
  static const locationSetupSub = 'locationSetupSub';
  static const village = 'village';
  static const settings = 'settings';
  static const profile = 'profile';
  static const language = 'language';
  static const darkMode = 'darkMode';
  static const about = 'about';
  static const appVersion = 'appVersion';
  static const logout = 'logout';
  static const logoutConfirm = 'logoutConfirm';
  static const cancel = 'cancel';
  static const confirm = 'confirm';
  static const loading = 'loading';
  static const retry = 'retry';
  static const noData = 'noData';
  static const save = 'save';
  static const back = 'back';
  static const next = 'next';
  static const done = 'done';
  static const live = 'live';
  static const tracker = 'tracker';
  static const mandi = 'mandi';
  static const msp = 'msp';
  static const schemes = 'schemes';
  static const soil = 'soil';
  static const disease = 'disease';
  static const farmId = 'farmId';
  static const eNam = 'eNam';
  static const aiDailyInsightTitle = 'aiDailyInsightTitle';
  static const aiInsightBadge = 'aiInsightBadge';
  static const readAloud = 'readAloud';
  static const waitingForData = 'waitingForData';
  static const chatHint = 'chatHint';
}

final Map<String, Map<String, String>> appTranslations = {
  'en': {
    S.appName: 'AGROKSHA AI',
    S.appNameVoice: 'Agroksha AI',
    S.tagline: 'Smart Farming. Intelligent Future.',
    S.devTeam: 'Developed by TEAM SARA',
    S.welcomeHeader: 'Welcome to AGROKSHA AI 🌾',
    S.welcomeSub: 'Better farming with AI – More yield, less risk',
    S.email: 'Email / Mobile',
    S.password: 'Password',
    S.fullName: 'Full Name',
    S.login: 'Login to AGROKSHA AI',
    S.signUp: 'Create an Account',
    S.forgotPassword: 'Forgot Password?',
    S.continueGuest: 'Continue as Guest',
    S.noAccount: "Don't have an account? ",
    S.haveAccount: 'Already have an account? ',
    S.clickHere: 'Click here',
    S.dashboard: 'Dashboard',
    S.goodMorning: 'Good morning,',
    S.goodAfternoon: 'Good afternoon,',
    S.goodEvening: 'Good evening,',
    S.farmerFriend: 'Agroksha Farmer',
    S.todayInsights: '🌱 Today\'s Smart Farming Insights',
    S.currentLocation: 'Current Location',
    S.changeLocation: 'Change Location',
    S.weatherToday: 'Weather Today',
    S.feelsLike: 'Feels like',
    S.humidity: 'Humidity',
    S.rain: 'Rain',
    S.wind: 'Wind',
    S.sunrise: 'Sunrise',
    S.sunset: 'Sunset',
    S.forecast: '7-Day Forecast',
    S.refreshWeather: 'Refresh',
    S.loadingWeather: 'Loading weather...',
    S.weatherError: 'Could not load weather. Tap to retry.',
    S.todaySuggestion: "Today's Suggestion",
    S.suggestions: 'Smart Suggestions',
    S.cropRisk: 'Crop Risk Analysis',
    S.highRisk: 'HIGH RISK',
    S.mediumRisk: 'MEDIUM RISK',
    S.lowRisk: 'LOW RISK',
    S.noRisk: 'NO RISK',
    S.based: 'Based on your location',
    S.market: 'Market',
    S.marketDemand: 'Market Demand',
    S.highDemand: 'High Demand',
    S.risingPrices: 'Rising Prices 📈',
    S.fallingAlerts: 'Falling Alerts 📉',
    S.bestSellers: 'Best Sellers This Week',
    S.perQuintal: '/qtl',
    S.recommend: 'Recommend',
    S.soilType: 'Soil Type',
    S.season: 'Season',
    S.analyze: '🤖 Analyze Crops',
    S.results: 'Recommended Crops',
    S.resetAnalyze: 'Reset & Analyze Again',
    S.selectSoil: 'Select your soil type',
    S.selectSeason: 'Select the season',
    S.analyzing: '🤖 AI Analysis in progress...',
    S.selectLocation: 'Select Location',
    S.selectState: 'Select State',
    S.selectDistrict: 'Select District',
    S.selectMandal: 'Select Mandal / Taluka',
    S.enterVillage: 'Enter Village Name',
    S.saveLocation: 'Save Location',
    S.locationSaved: '✅ Location saved!',
    S.locationSetupTitle: 'Set Your Farm Location',
    S.locationSetupSub: 'We use this to show accurate weather,\ncrop risk and market data for your area.',
    S.village: 'Village',
    S.settings: 'Settings',
    S.profile: 'Profile',
    S.language: 'Language',
    S.darkMode: 'Dark Mode',
    S.about: 'About AGROKSHA AI',
    S.appVersion: 'Version 2.0.0',
    S.logout: 'Logout',
    S.logoutConfirm: 'Are you sure you want to logout?',
    S.cancel: 'Cancel',
    S.confirm: 'Confirm',
    S.loading: 'Loading...',
    S.retry: 'Retry',
    S.noData: 'No data available',
    S.save: 'Save',
    S.back: 'Back',
    S.next: 'Next',
    S.done: 'Done',
    S.live: 'Live',
    S.tracker: 'Tracker',
    S.mandi: 'Mandi',
    S.msp: 'MSP',
    S.schemes: 'Schemes',
    S.soil: 'Soil Health',
    S.disease: 'AI Diagnosis',
    S.farmId: 'Digital ID',
    S.eNam: 'e-NAM',
    S.aiDailyInsightTitle: 'AI Daily Insight',
    S.aiInsightBadge: '✨ AI Insights',
    S.readAloud: 'Read Aloud',
    S.waitingForData: 'Waiting for data...',
    S.chatHint: 'Type your farming question...',
  },
  'te': {
    S.appName: 'అగోక్ష AI',
    S.appNameVoice: 'Agroksha AI',
    S.tagline: 'స్మార్ట్ వ్యవసాయం. తెలివైన భవిష్యత్తు.',
    S.devTeam: 'TEAM SARA ద్వారా అభివృద్ధి చేయబడింది',
    S.welcomeHeader: 'అగోక్ష AI కి స్వాగతం 🌾',
    S.welcomeSub: 'AI తో మెరుగైన వ్యవసాయం – ఎక్కువ దిగుబడి, తక్కువ నష్టం',
    S.email: 'ఈమెయిల్ / మొబైల్',
    S.password: 'పాస్‌వర్డ్',
    S.fullName: 'పూర్తి పేరు',
    S.login: 'అగోక్ష AI కి లాగిన్ అవ్వండి',
    S.signUp: 'ఖాతాను సృష్టించండి',
    S.forgotPassword: 'పాస్‌వర్డ్ మర్చిపోయారా?',
    S.continueGuest: 'గెస్ట్ లాగిన్',
    S.noAccount: "ఖాతా లేదా? ",
    S.haveAccount: 'ఇప్పటికే ఖాతా ఉందా? ',
    S.clickHere: 'ఇక్కడ నొక్కండి',
    S.dashboard: 'డాష్‌బోర్డ్',
    S.goodMorning: 'శుభోదయం,',
    S.goodAfternoon: 'శుభ మధ్యాహ్నం,',
    S.goodEvening: 'శుభ సాయంత్రం,',
    S.farmerFriend: 'అగోక్ష రైతు',
    S.todayInsights: '🌱 నేటి స్మార్ట్ వ్యవసాయ సూచనలు',
    S.currentLocation: 'ప్రస్తుత ప్రాంతం',
    S.changeLocation: 'ప్రాంతం మార్చండి',
    S.weatherToday: 'నేటి వాతావరణం',
    S.feelsLike: 'అనిపిస్తుంది',
    S.humidity: 'తేమ',
    S.rain: 'వర్షం',
    S.wind: 'గాలి',
    S.sunrise: 'సూర్యోదయం',
    S.sunset: 'సూర్యాస్తమయం',
    S.forecast: '7 రోజుల వాతావరణ సూచన',
    S.refreshWeather: 'రిఫ్రెష్',
    S.loadingWeather: 'వాతావరణం లోడ్ అవుతోంది...',
    S.weatherError: 'లోడ్ అవ్వలేదు. మళ్ళీ ప్రయత్నించండి.',
    S.todaySuggestion: "నేటి సూచన",
    S.suggestions: 'స్మార్ట్ సూచనలు',
    S.cropRisk: 'పంట రిస్క్ విశ్లేషణ',
    S.highRisk: 'అధిక రిస్క్',
    S.mediumRisk: 'మధ్యస్థ రిస్క్',
    S.lowRisk: 'తక్కువ రిస్క్',
    S.noRisk: 'రిస్క్ లేదు',
    S.based: 'మీ ప్రాంతం ఆధారంగా',
    S.market: 'మార్కెట్',
    S.marketDemand: 'మార్కెట్ డిమాండ్',
    S.highDemand: 'అధిక డిమాండ్',
    S.risingPrices: 'పెరుగుతున్న ధరలు 📈',
    S.fallingAlerts: 'తగ్గుతున్న ధరలు 📉',
    S.bestSellers: 'ఈ వారం ఉత్తమ అమ్మకాలు',
    S.perQuintal: '/క్వింటాల్',
    S.recommend: 'సిఫార్సు',
    S.soilType: 'నేల రకం',
    S.season: 'సీజన్',
    S.analyze: '🤖 పంటల విశ్లేషణ',
    S.results: 'సిఫార్సు చేయబడిన పంటలు',
    S.resetAnalyze: 'మళ్ళీ విశ్లేషించండి',
    S.selectSoil: 'మీ నేల రకాన్ని ఎంచుకోండి',
    S.selectSeason: 'సీజన్ ఎంచుకోండి',
    S.analyzing: '🤖 AI విశ్లేషణ జరుగుతోంది...',
    S.selectLocation: 'ప్రాంతాన్ని ఎంచుకోండి',
    S.selectState: 'రాష్ట్రం ఎంచుకోండి',
    S.selectDistrict: 'జిల్లా ఎంచుకోండి',
    S.selectMandal: 'మండలం ఎంచుకోండి',
    S.enterVillage: 'గ్రామ పేరు ఎంటర్ చేయండి',
    S.saveLocation: 'ప్రాంతం సేవ్ చేయండి',
    S.locationSaved: '✅ ప్రాంతం సేవ్ చేయబడింది!',
    S.locationSetupTitle: 'మీ పొలం ప్రాంతాన్ని సెట్ చేయండి',
    S.locationSetupSub: 'ఖచ్చితమైన వాతావరణం మరియు మార్కెట్ ధరల కోసం ఇది అవసరం.',
    S.village: 'గ్రామం',
    S.settings: 'సెట్టింగ్స్',
    S.profile: 'ప్రొఫైల్',
    S.language: 'భాష',
    S.darkMode: 'డార్క్ మోడ్',
    S.about: 'అగోక్ష AI గురించి',
    S.appVersion: 'వెర్షన్ 2.0.0',
    S.logout: 'లాగ్ అవుట్',
    S.logoutConfirm: 'మీరు లాగ్ అవుట్ అవ్వాలనుకుంటున్నారా?',
    S.cancel: 'రద్దు',
    S.confirm: 'అవును',
    S.loading: 'లోడ్ అవుతోంది...',
    S.retry: 'మళ్ళీ ప్రయత్నించండి',
    S.noData: 'సమాచారం లేదు',
    S.save: 'సేవ్',
    S.back: 'వెనుకకు',
    S.next: 'తరువాత',
    S.done: 'పూర్తయింది',
    S.live: 'లైవ్',
    S.tracker: 'ట్రాకర్',
    S.mandi: 'మండీ',
    S.msp: 'MSP',
    S.schemes: 'పథకాలు',
    S.soil: 'నేల ఆరోగ్యం',
    S.disease: 'AI నిర్ధారణ',
    S.farmId: 'డిజిటల్ ID',
    S.eNam: 'e-NAM',
    S.aiDailyInsightTitle: 'AI రోజువారీ సూచన',
    S.aiInsightBadge: '✨ AI సూచనలు',
    S.readAloud: 'వినిపించు',
    S.waitingForData: 'సమాచారం కోసం వేచి ఉంది...',
    S.chatHint: 'మీ వ్యవసాయ ప్రశ్నను అడగండి...',
  },
};

enum AppLanguage { english, telugu, hindi, kannada, tamil }

extension AppLanguageExt on AppLanguage {
  String get code {
    switch (this) {
      case AppLanguage.english: return 'en';
      case AppLanguage.telugu: return 'te';
      case AppLanguage.hindi: return 'hi';
      case AppLanguage.kannada: return 'kn';
      case AppLanguage.tamil: return 'ta';
    }
  }

  String get displayName {
    switch (this) {
      case AppLanguage.english: return 'English';
      case AppLanguage.telugu: return 'తెలుగు (Telugu)';
      case AppLanguage.hindi: return 'हिन्दी (Hindi)';
      case AppLanguage.kannada: return 'ಕನ್ನಡ (Kannada)';
      case AppLanguage.tamil: return 'தமிழ் (Tamil)';
    }
  }

  String get flag {
    switch (this) {
      case AppLanguage.english: return '🇬🇧';
      case AppLanguage.telugu: return '🇮🇳';
      case AppLanguage.hindi: return '🇮🇳';
      case AppLanguage.kannada: return '🇮🇳';
      case AppLanguage.tamil: return '🇮🇳';
    }
  }

  static AppLanguage fromCode(String code) {
    switch (code) {
      case 'te': return AppLanguage.telugu;
      case 'hi': return AppLanguage.hindi;
      case 'kn': return AppLanguage.kannada;
      case 'ta': return AppLanguage.tamil;
      default: return AppLanguage.english;
    }
  }
}

String translate(String key, String langCode) {
  return appTranslations[langCode]?[key] ?? appTranslations['en']?[key] ?? key;
}
