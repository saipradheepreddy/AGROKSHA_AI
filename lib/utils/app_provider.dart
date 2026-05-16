import '../services/supabase_auth_service.dart';
import '../services/supabase_service.dart';
/// ─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€



/// ——————————————————————————————————————————————————————————————————————————————————————————————————
/// AGROKSHA AI — Main State Management (Provider)
/// Language, Theme, Mute State, User Sessions
/// ——————————————————————————————————————————————————————————————————————————————————————————————————









import 'package:flutter/material.dart';




import '../models/models.dart';




import '../data/mock_data.dart';




import '../data/translations.dart';




import '../services/storage_service.dart';




import '../services/weather_service.dart';




import '../services/market_service.dart';




import '../services/ai_service.dart';









class AppProvider extends ChangeNotifier {





  AppProvider(this._storage) { listenToAuthChanges(); }









  final StorageService _storage;









  // ─€─€ Helper: translate using current language ─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€─€




  String t(String key) => translate(key, _language.code);









  // ══════════════════════════════════════════════════════════════════




  // LANGUAGE




  // ══════════════════════════════════════════════════════════════════




    bool _farmerMode = false;
  bool get farmerMode => _farmerMode;
AppLanguage _language = AppLanguage.english;









  void setLanguage(AppLanguage lang) {




    _language = lang;




    _storage.setLanguage(lang.code);




    notifyListeners();




    // Refresh localized AI insight




    fetchAiDailyInsight();




  }









  // ——— Legacy Telugu toggle (keep for backward compat) ———




  bool get isTeluguMode => _language == AppLanguage.telugu;
  String get langCode => _language.code;

  void toggleLanguage() {




    setLanguage(isTeluguMode ? AppLanguage.english : AppLanguage.telugu);




  }









  // ══════════════════════════════════════════════════════════════════




  // THEME




  // ══════════════════════════════════════════════════════════════════




  ThemeMode _themeMode = ThemeMode.light;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;









  void toggleTheme() {




    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;




    _storage.setDarkMode(isDarkMode);




    notifyListeners();




  }









  // ══════════════════════════════════════════════════════════════════




  // VOICE & AUDIO SETTINGS




  // ══════════════════════════════════════════════════════════════════




  bool _muteGreetings = true;




  int _voiceSpeed = 1; // 0: Slow, 1: Normal, 2: Fast









  void toggleMuteGreetings() {




    _muteGreetings = !_muteGreetings;




    _storage.setMuteGreetings(_muteGreetings);




    notifyListeners();




  }









  void setVoiceSpeed(int speed) {




    if (speed >= 0 && speed <= 2) {




      _voiceSpeed = speed;




      _storage.setVoiceSpeed(speed);




      notifyListeners();




    }




  }









  // ══════════════════════════════════════════════════════════════════




  // USER

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  String? _supabaseUid;
  String? get supabaseUid => _supabaseUid;

  AppLanguage get language => _language;
  bool get muteGreetings => _muteGreetings;
  int get voiceSpeed => _voiceSpeed;

  void listenToAuthChanges() {
    SupabaseAuthService.authStateChanges.listen((state) async {
      final user = state.session?.user;
      debugPrint("AppProvider: Supabase Auth state changed: ${state.event}. User: ${user?.email}");
      
      if (user != null) {
        _supabaseUid = user.id;
        // Fetch real profile from Supabase
        final cloudUser = await SupabaseService.fetchUserProfile(user.id);
        if (cloudUser != null) {
          // If the name looks like a hex code or is empty, fallback to metadata name
          if (cloudUser.name.isEmpty || cloudUser.name.contains(RegExp(r'[0-9]{5,}'))) {
            _currentUser = cloudUser.copyWith(name: user.userMetadata?['full_name'] ?? 'Agroksha Farmer');
          } else {
            _currentUser = cloudUser;
          }
        } else {
          // If no profile in Supabase but user exists in Auth
          _currentUser = UserModel(
            id: user.id,
            name: user.userMetadata?['full_name'] ?? 'Agroksha Farmer',
            email: user.email ?? '',
            profileImagePath: user.userMetadata?['avatar_url'],
            role: 'farmer',
          );
          // Sync new profile to DB
          await SupabaseService.syncUserProfile(_currentUser!);
        }
      } else {
        _supabaseUid = null;
        _currentUser = null;
        _storage.clearUser();
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    });
  }

  Future<bool> signInWithGoogle() async {
    try {
      final success = await SupabaseAuthService.signInWithGoogle();
      if (success) {
        // user state is handled by listenToAuthChanges stream
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Google Sign In Error in Provider: $e");
      rethrow;
    }
  }

  Future<bool> signInAnonymously() async {
    try {
      final response = await SupabaseAuthService.signInAnonymously();
      if (response.user != null) {
        // Profile creation handled by stream
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Anonymous Sign In Error in Provider: $e");
      rethrow;
    }
  }

  Future<void> logout() async {
    await SupabaseAuthService.logout();
    _currentUser = null;
    _supabaseUid = null;
    _storage.clearUser();
    notifyListeners();
  }

  Future<void> updateProfile(UserModel user) async {
    try {
      _currentUser = user;
      await SupabaseService.syncUserProfile(user);
      notifyListeners();
    } catch (e) {
      debugPrint("Error updating profile: $e");
      rethrow;
    }
  }

  // FARMER LOCATION




  // ══════════════════════════════════════════════════════════════════




  FarmerLocation? _farmerLocation;
  FarmerLocation? get farmerLocation => _farmerLocation;
  bool get hasLocation => _farmerLocation != null;









  Future<void> saveLocation(FarmerLocation loc) async {




    _farmerLocation = loc;




    await _storage.saveLocation(




      state: loc.state,




      district: loc.district,




      mandal: loc.mandal,




      village: loc.village,         // nullable — storage accepts String?




      lat: loc.lat,




      lon: loc.lon,




    );




    notifyListeners();




    // Re-fetch weather for new location




    await fetchWeather();




    await fetchCropRisks();




  }









  void _loadLocationFromStorage() {




    final state = _storage.getState();




    final district = _storage.getDistrict();




    if (state != null && district != null) {




      _farmerLocation = FarmerLocation(




        state: state,




        district: district,




        mandal: _storage.getMandal() ?? '',




        village: _storage.getVillage(), // nullable — optional




        lat: _storage.getLat() ?? 17.38,




        lon: _storage.getLon() ?? 78.48,




      );




    }




  }









  // ══════════════════════════════════════════════════════════════════




  // WEATHER




  // ══════════════════════════════════════════════════════════════════




  WeatherModel? _weather;
  WeatherModel? get weather => _weather;
  List<WeatherDay> get forecast => _forecast;
  bool get isWeatherLoading => _isWeatherLoading;
  String? get weatherError => _weatherError;




  List<WeatherDay> _forecast = [];




  bool _isWeatherLoading = false;




  String? _weatherError;









  Future<void> fetchWeather() async {




    _isWeatherLoading = true;




    _weatherError = null;




    notifyListeners();









    try {




      final loc = _farmerLocation;




      if (loc == null) {




        // Use fallback mock data




        await Future.delayed(const Duration(milliseconds: 800));




        _weather = MockData.fallbackWeather;




        _forecast = MockData.fallbackForecast;




      } else {




        // Real Open-Meteo API call




        final result = await WeatherService.fetchWeather(




          lat: loc.lat,




          lon: loc.lon,




          locationName: loc.displayShort,




        );




        _weather = result.current;




        _forecast = result.forecast;




      }




    } catch (e) {




      // Fallback to mock on error




      _weather = MockData.fallbackWeather.copyWith(




        locationName: _farmerLocation?.displayShort ?? 'Your Location',




      );




      _forecast = MockData.fallbackForecast;




      _weatherError = t(S.weatherError);




    }









    _isWeatherLoading = false;




    notifyListeners();




  }









  // ══════════════════════════════════════════════════════════════════




  // CROP RISKS




  // ══════════════════════════════════════════════════════════════════




  List<CropRiskModel> _cropRisks = [];




  bool _isCropRiskLoading = false;









  List<CropRiskModel> get cropRisks => _cropRisks;
  bool get isCropRiskLoading => _isCropRiskLoading;









  Future<void> fetchCropRisks() async {




    _isCropRiskLoading = true;




    notifyListeners();




    // TODO: Replace with real AgriSense backend API




    await Future.delayed(const Duration(milliseconds: 600));




    _cropRisks = MockData.locationCropRisks;




    _isCropRiskLoading = false;




    notifyListeners();




  }









  // ══════════════════════════════════════════════════════════════════




  // SUGGESTIONS




  // ══════════════════════════════════════════════════════════════════




  FarmerSuggestion? _todaySuggestion;
  FarmerSuggestion? get todaySuggestion => _todaySuggestion;




  String _selectedCrop = 'Paddy';
  String get selectedCrop => _selectedCrop;


  void updateProfileDetails({
    String? name, String? crop, String? farmSize, List<String>? pastCrops, String? imagePath,
    String? gender, String? dob, String? aadhaar, String? state, String? district, 
    String? mandal, String? village, String? soilType, String? irrigationType, 
    String? cropStage, int? experienceYears, List<CropHistory>? cropHistoryList
  }) {
    if (_currentUser != null) {
      _currentUser = UserModel(
        id: _currentUser!.id,
        name: name ?? _currentUser!.name,
        email: _currentUser!.email,
        mobile: _currentUser!.mobile,
        location: _currentUser!.location,
        age: _currentUser!.age,
        farmSize: farmSize ?? _currentUser!.farmSize,
        preferredCrops: _currentUser!.preferredCrops,
        profileImagePath: imagePath ?? _currentUser!.profileImagePath,
        pastCrops: pastCrops ?? _currentUser!.pastCrops,
        gender: gender ?? _currentUser!.gender,
        dob: dob ?? _currentUser!.dob,
        aadhaar: aadhaar ?? _currentUser!.aadhaar,
        state: state ?? _currentUser!.state,
        district: district ?? _currentUser!.district,
        mandal: mandal ?? _currentUser!.mandal,
        village: village ?? _currentUser!.village,
        soilType: soilType ?? _currentUser!.soilType,
        irrigationType: irrigationType ?? _currentUser!.irrigationType,
        cropStage: cropStage ?? _currentUser!.cropStage,
        experienceYears: experienceYears ?? _currentUser!.experienceYears,
        cropHistoryList: cropHistoryList ?? _currentUser!.cropHistoryList,
      );
    }
    if (crop != null && crop.isNotEmpty) {
      _selectedCrop = crop;
    }
    notifyListeners();
    // Persist to local storage (if needed) and Supabase
    SupabaseService.syncUserProfile(_currentUser!);
  }


  void updateUserName(String name) {
    if (_currentUser != null) {
      _currentUser = UserModel(
        id: _currentUser!.id,
        name: name,
        email: _currentUser!.email,
      );
      notifyListeners();
    }
  }




  // Alias used by settings dialog
  void updateSelectedCrop(String crop) => setSelectedCrop(crop);

  void setSelectedCrop(String crop) {




    _selectedCrop = crop;




    notifyListeners();




  }









  // ══════════════════════════════════════════════════════════════════




  // AI DAILY INSIGHT




  // ══════════════════════════════════════════════════════════════════




  String? _aiDailyInsight;
  String? get aiDailyInsight => _aiDailyInsight;
  bool get isAiInsightLoading => _isAiInsightLoading;




  bool _isAiInsightLoading = false;









  void _loadSuggestion() {




    _todaySuggestion = MockData.todaySuggestion();




  }









  // ══════════════════════════════════════════════════════════════════




  // MARKET DATA — Live via MarketService (3-attempt + MSP fallback)




  // ══════════════════════════════════════════════════════════════════




  List<MarketItem> _allMarketItems = [];
  List<MarketItem> get allMarketItems => _allMarketItems;
  bool get isMarketLoading => _isMarketLoading;
  bool get isMarketReal => _isMarketReal;
  String get marketSource => _marketSource;

  List<MarketItem> get cropMarket => _allMarketItems.where((e) => e.category == MarketCategory.crop).toList();
  List<MarketItem> get vegetableMarket => _allMarketItems.where((e) => e.category == MarketCategory.vegetable).toList();
  List<MarketItem> get fruitMarket => _allMarketItems.where((e) => e.category == MarketCategory.fruit).toList();
  List<MarketItem> get highDemandMarket => _allMarketItems.where((e) => e.trend == MarketTrend.highDemand).toList();
  List<MarketItem> get risingMarket => _allMarketItems.where((e) => e.trend == MarketTrend.rising).toList();




  bool _isMarketLoading = false;




  bool _isMarketReal = false;




  String _marketSource = '';



  Future<void> initialize() async {
    // Restore preferences
    final langCode = _storage.getLanguage();
    _language = AppLanguageExt.fromCode(langCode);
    _themeMode = _storage.getDarkMode() ? ThemeMode.dark : ThemeMode.light;

    // Restore voice settings
    _muteGreetings = _storage.getMuteGreetings();
    _voiceSpeed = _storage.getVoiceSpeed();

    // Restore basic user session instantly from Auth
    final user = SupabaseAuthService.currentUser;
    if (user != null) {
      _supabaseUid = user.id;
      SupabaseService.fetchUserProfile(user.id).then((cloudUser) {
        if (cloudUser != null) {
          _currentUser = cloudUser;
          notifyListeners();
        }
      });
      
      _currentUser = UserModel(
        id: user.uid,
        name: user.displayName ?? 'Agroksha Farmer',
        email: user.email ?? '',
        profileImagePath: user.photoURL,
        role: 'farmer',
      );
    }

    // Restore location
    _loadLocationFromStorage();

    // Load suggestion + daily tip
    _loadSuggestion();
    _loadDailyTip();

    notifyListeners();

    // Fetch live data in background
    fetchWeather();
    fetchCropRisks();
    fetchMarketData();
    fetchAiDailyInsight();
  }

  Future<void> initializeDashboard() async {
    if (_weather == null || _cropRisks.isEmpty) {
      await Future.wait([fetchWeather(), fetchCropRisks()]);
    }
  }



  void removeCropEntry(String id) {
    _cropEntries.removeWhere((e) => e.id == id);
    notifyListeners();
  }
  Future<void> fetchMarketData() async {
    _isMarketLoading = true;
    notifyListeners();
    try {
      final state = _farmerLocation?.state ?? 'Telangana';
      final district = _farmerLocation?.district ?? 'Hyderabad';
      final result = await MarketService.fetchLiveMarketData(state: state, district: district);
      _allMarketItems = result.items;
      _isMarketReal = result.isReal;
      _marketSource = result.source;
    } catch (_) {
      _allMarketItems = [];
      _isMarketReal = false;
      _marketSource = 'Unavailable';
    }
    _isMarketLoading = false;
    notifyListeners();
  }

  final List<CropTrackerEntry> _cropEntries = [];
  List<CropTrackerEntry> get cropEntries => List.unmodifiable(_cropEntries);

  void addCropEntry(CropTrackerEntry entry) {
    _cropEntries.insert(0, entry);
    notifyListeners();
  }



  DailyCareTip? _dailyCareTip;
  DailyCareTip? get dailyCareTip => _dailyCareTip;
  bool get isRecommendationLoading => _isRecommendationLoading;
  SoilType? get selectedSoil => _selectedSoil;
  Season? get selectedSeason => _selectedSeason;









  bool _isRecommendationLoading = false;




  SoilType? _selectedSoil;




  Season? _selectedSeason;









  List<CropRecommendation> _recommendations = [];
  List<CropRecommendation> get recommendations => _recommendations;

  void _loadDailyTip() {
    _dailyCareTip = MockData.todayCareTip();
  }

  Future<void> fetchAiDailyInsight() async {
    if (_isAiInsightLoading) return;
    _isAiInsightLoading = true;
    notifyListeners();
    try {
      _aiDailyInsight = await AIService.generateDailySuggestion(
        language: _language,
        weather: _weather,
        location: _farmerLocation,
        currentCrop: _selectedCrop,
        marketData: _allMarketItems,
      );
    } catch (_) {
      _aiDailyInsight = null;
    }
    _isAiInsightLoading = false;
    notifyListeners();
  }

  Future<void> refreshDashboard() async {
    await Future.wait([fetchWeather(), fetchCropRisks(), fetchMarketData()]);
    _loadSuggestion();
    _loadDailyTip();
    fetchAiDailyInsight();
  }









  void selectSoil(SoilType soil) { _selectedSoil = soil; notifyListeners(); }




  void selectSeason(Season season) { _selectedSeason = season; notifyListeners(); }









  Future<void> analyzeRecommendations() async {




    if (_selectedSoil == null || _selectedSeason == null) return;




    _isRecommendationLoading = true;




    _recommendations = [];




    notifyListeners();




    // TODO: Replace with ML backend API




    await Future.delayed(const Duration(milliseconds: 1800));




    _recommendations = MockData.getRecommendations(_selectedSoil!, _selectedSeason!);




    _isRecommendationLoading = false;




    notifyListeners();




  }









  void clearRecommendations() {




    _recommendations = [];




    _selectedSoil = null;




    _selectedSeason = null;




    notifyListeners();




  }









  // ══════════════════════════════════════════════════════════════════




  // PULL-TO-REFRESH




  // ══════════════════════════════════════════════════════════════════


}

/// Extension to add copyWith to WeatherModel
extension WeatherModelCopyWith on WeatherModel {
  WeatherModel copyWith({
    double? temperature,
    double? apparentTemperature,
    double? humidity,
    double? rainChance,
    double? windSpeed,
    String? condition,
    String? conditionIcon,
    String? locationName,
    String? sunrise,
    String? sunset,
  }) {
    return WeatherModel(
      temperature: temperature ?? this.temperature,
      apparentTemperature: apparentTemperature ?? this.apparentTemperature,
      humidity: humidity ?? this.humidity,
      rainChance: rainChance ?? this.rainChance,
      windSpeed: windSpeed ?? this.windSpeed,
      condition: condition ?? this.condition,
      conditionIcon: conditionIcon ?? this.conditionIcon,
      locationName: locationName ?? this.locationName,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
    );
  }
}
