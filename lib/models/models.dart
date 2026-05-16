/// ─────────────────────────────────────────────────────────────────────────────



/// AGROKSHA AI — Data Models v2



/// All entity models for the app — null-safe, API-ready



/// ─────────────────────────────────────────────────────────────────────────────







// ── Export translations & language enum for convenience ──



export '../data/translations.dart';







// ══════════════════════════════════════════════════════════════════════════════



// RISK LEVEL



// ══════════════════════════════════════════════════════════════════════════════



enum RiskLevel { none, low, medium, high }







extension RiskLevelExtension on RiskLevel {



  String get label {



    switch (this) {



      case RiskLevel.none: return 'NO RISK';



      case RiskLevel.low: return 'LOW RISK';



      case RiskLevel.medium: return 'MEDIUM RISK';



      case RiskLevel.high: return 'HIGH RISK';



    }



  }



}







// ══════════════════════════════════════════════════════════════════════════════



// SOIL TYPE



// ══════════════════════════════════════════════════════════════════════════════



enum SoilType { black, red, sandy, loamy, clay }







extension SoilTypeExtension on SoilType {



  String get displayName {



    switch (this) {



      case SoilType.black: return 'Black Soil';



      case SoilType.red: return 'Red Soil';



      case SoilType.sandy: return 'Sandy Soil';



      case SoilType.loamy: return 'Loamy Soil';



      case SoilType.clay: return 'Clay Soil';



    }



  }







  String get emoji {



    switch (this) {



      case SoilType.black: return '⚫';



      case SoilType.red: return '🔴';



      case SoilType.sandy: return '🟡';



      case SoilType.loamy: return '🟤';



      case SoilType.clay: return '🟠';



    }



  }







  String get key => name;



}







// ══════════════════════════════════════════════════════════════════════════════



// SEASON



// ══════════════════════════════════════════════════════════════════════════════



enum Season { kharif, rabi, summer }







extension SeasonExtension on Season {



  String get displayName {



    switch (this) {



      case Season.kharif: return 'Kharif (June–Oct)';



      case Season.rabi: return 'Rabi (Nov–Mar)';



      case Season.summer: return 'Summer (Apr–Jun)';



    }



  }







  String get emoji {



    switch (this) {



      case Season.kharif: return '🌧️';



      case Season.rabi: return '❄️';



      case Season.summer: return '☀️';



    }



  }







  String get key => name;



}







// ══════════════════════════════════════════════════════════════════════════════



// CURRENT WEATHER MODEL



// ══════════════════════════════════════════════════════════════════════════════



class WeatherModel {



  final double temperature;



  final double apparentTemperature;



  final double humidity;



  final double rainChance;



  final double windSpeed;



  final String condition;



  final String conditionIcon;



  final String locationName;



  final String sunrise;



  final String sunset;







  const WeatherModel({



    required this.temperature,



    required this.apparentTemperature,



    required this.humidity,



    required this.rainChance,



    required this.windSpeed,



    required this.condition,



    required this.conditionIcon,



    required this.locationName,



    required this.sunrise,



    required this.sunset,



  });







  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(



        temperature: (json['temperature'] as num).toDouble(),



        apparentTemperature: (json['apparentTemperature'] as num? ?? json['temperature'] as num).toDouble(),



        humidity: (json['humidity'] as num).toDouble(),



        rainChance: (json['rainChance'] as num).toDouble(),



        windSpeed: (json['windSpeed'] as num).toDouble(),



        condition: json['condition'] as String,



        conditionIcon: json['conditionIcon'] as String,



        locationName: json['locationName'] as String,



        sunrise: json['sunrise'] as String? ?? '06:00',



        sunset: json['sunset'] as String? ?? '18:30',



      );



}







// ══════════════════════════════════════════════════════════════════════════════



// 7-DAY WEATHER FORECAST MODEL



// ══════════════════════════════════════════════════════════════════════════════



class WeatherDay {



  final String date;



  final String dayLabel;



  final String emoji;



  final String condition;



  final double maxTemp;



  final double minTemp;



  final double rainChance;







  const WeatherDay({



    required this.date,



    required this.dayLabel,



    required this.emoji,



    required this.condition,



    required this.maxTemp,



    required this.minTemp,



    required this.rainChance,



  });



}







// ══════════════════════════════════════════════════════════════════════════════



// CROP RISK MODEL



// ══════════════════════════════════════════════════════════════════════════════



class CropRiskModel {



  final String cropName;



  final String cropEmoji;



  final RiskLevel riskLevel;



  final double riskPercentage;



  final String? description;







  const CropRiskModel({



    required this.cropName,



    required this.cropEmoji,



    required this.riskLevel,



    required this.riskPercentage,



    this.description,



  });







  factory CropRiskModel.fromJson(Map<String, dynamic> json) => CropRiskModel(



        cropName: json['cropName'] as String,



        cropEmoji: json['cropEmoji'] as String,



        riskLevel: RiskLevel.values.firstWhere(



          (e) => e.name == json['riskLevel'],



          orElse: () => RiskLevel.none,



        ),



        riskPercentage: (json['riskPercentage'] as num).toDouble(),



        description: json['description'] as String?,



      );



}







// ══════════════════════════════════════════════════════════════════════════════



// CROP RECOMMENDATION MODEL



// ══════════════════════════════════════════════════════════════════════════════



class CropRecommendation {



  final String cropName;



  final String cropEmoji;



  final RiskLevel riskLevel;



  final double riskPercentage;



  final String suitabilityNote;



  final List<String> benefits;







  const CropRecommendation({



    required this.cropName,



    required this.cropEmoji,



    required this.riskLevel,



    required this.riskPercentage,



    required this.suitabilityNote,



    required this.benefits,



  });



}







// ══════════════════════════════════════════════════════════════════════════════



// FARMER LOCATION MODEL



// ══════════════════════════════════════════════════════════════════════════════



class FarmerLocation {



  final String state;



  final String district;



  final String mandal;



  final String? village;   // optional — farmer can skip



  final double lat;



  final double lon;







  const FarmerLocation({



    required this.state,



    required this.district,



    required this.mandal,



    this.village,



    required this.lat,



    required this.lon,



  });







  String get displayShort => village != null ? '$village, $district' : '$mandal, $district';



  String get displayFull {



    final parts = [if (village != null) village!, mandal, district, state];



    return parts.join(', ');



  }



}







// ══════════════════════════════════════════════════════════════════════════════



// FARMER SUGGESTION MODEL



// ══════════════════════════════════════════════════════════════════════════════



enum SuggestionType { irrigation, pesticide, market, weather, sowing, harvest }







extension SuggestionTypeExt on SuggestionType {



  String get emoji {



    switch (this) {



      case SuggestionType.irrigation: return '💧';



      case SuggestionType.pesticide: return '🌿';



      case SuggestionType.market: return '📊';



      case SuggestionType.weather: return '🌦️';



      case SuggestionType.sowing: return '🌱';



      case SuggestionType.harvest: return '🌾';



    }



  }



}







class FarmerSuggestion {



  final String titleEn;



  final String titleTe;



  final String titleHi;



  final String descriptionEn;



  final String descriptionTe;



  final String descriptionHi;



  final SuggestionType type;







  const FarmerSuggestion({



    required this.titleEn,



    required this.titleTe,



    required this.titleHi,



    required this.descriptionEn,



    required this.descriptionTe,



    required this.descriptionHi,



    required this.type,



  });







  String title(String langCode) {



    switch (langCode) {



      case 'te': return titleTe;



      case 'hi': return titleHi;



      default: return titleEn;



    }



  }







  String description(String langCode) {



    switch (langCode) {



      case 'te': return descriptionTe;



      case 'hi': return descriptionHi;



      default: return descriptionEn;



    }



  }



}







// ══════════════════════════════════════════════════════════════════════════════



// MARKET ITEM MODEL



// ══════════════════════════════════════════════════════════════════════════════



enum MarketTrend { rising, falling, stable, highDemand }



enum MarketCategory { crop, vegetable, fruit }







extension MarketTrendExt on MarketTrend {



  String get emoji {



    switch (this) {



      case MarketTrend.rising: return '📈';



      case MarketTrend.falling: return '📉';



      case MarketTrend.stable: return '➡️';



      case MarketTrend.highDemand: return '🔥';



    }



  }



}







class MarketItem {



  final String cropName;



  final String cropEmoji;



  final int pricePerQuintal;



  final int changeAmount;



  final MarketTrend trend;



  final String note;



  final MarketCategory category;







  const MarketItem({



    required this.cropName,



    required this.cropEmoji,



    required this.pricePerQuintal,



    required this.changeAmount,



    required this.trend,



    required this.note,



    this.category = MarketCategory.crop,



  });







  bool get isRising => changeAmount > 0;



}







// ══════════════════════════════════════════════════════════════════════════════



// USER MODEL



// ══════════════════════════════════════════════════════════════════════════════




class CropHistory {
  final String year;
  final String cropName;
  final String? yieldStr;
  final String? season;
  final String? secondaryCrop;

  const CropHistory({
    required this.year,
    required this.cropName,
    this.yieldStr,
    this.season,
    this.secondaryCrop,
  });

  factory CropHistory.fromJson(Map<String, dynamic> json) => CropHistory(
        year: json['year'] as String,
        cropName: json['cropName'] as String,
        yieldStr: json['yieldStr'] as String?,
        season: json['season'] as String?,
        secondaryCrop: json['secondaryCrop'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'year': year,
        'cropName': cropName,
        'yieldStr': yieldStr,
        'season': season,
        'secondaryCrop': secondaryCrop,
      };
}

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? mobile;
  final String? location; // Keep for legacy
  final int? age; // Keep for legacy
  final String? farmSize; // e.g. '2 acres'
  final List<String> preferredCrops;
  final String? profileImagePath;
  final List<String> pastCrops; // Legacy string list

  // New Premium Fields
  final String? gender;
  final String? dob;
  final String? aadhaar;
  final String? state;
  final String? district;
  final String? mandal;
  final String? village;
  final String? soilType;
  final String? irrigationType;
  final String? cropStage;
  final int? experienceYears;
  final List<CropHistory> cropHistoryList;
  final String role; // 'farmer', 'field_assistant', 'admin'
  final String? sessionToken;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.mobile,
    this.location,
    this.age,
    this.farmSize,
    this.preferredCrops = const [],
    this.profileImagePath,
    this.pastCrops = const [],
    this.gender,
    this.dob,
    this.aadhaar,
    this.state,
    this.district,
    this.mandal,
    this.village,
    this.soilType,
    this.irrigationType,
    this.cropStage,
    this.experienceYears,
    this.cropHistoryList = const [],
    this.role = 'farmer',
    this.sessionToken,
  });

  bool get isProfileComplete => mobile != null && mobile!.isNotEmpty && age != null;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String?,
      location: json['location'] as String?,
      age: json['age'] as int?,
      farmSize: json['farmSize'] as String?,
      preferredCrops: List<String>.from(json['preferredCrops'] as List? ?? []),
      profileImagePath: json['profileImagePath'] as String?,
      pastCrops: List<String>.from(json['pastCrops'] as List? ?? []),
      gender: json['gender'] as String?,
      dob: json['dob'] as String?,
      aadhaar: json['aadhaar'] as String?,
      state: json['state'] as String?,
      district: json['district'] as String?,
      mandal: json['mandal'] as String?,
      village: json['village'] as String?,
      soilType: json['soilType'] as String?,
      irrigationType: json['irrigationType'] as String?,
      cropStage: json['cropStage'] as String?,
      experienceYears: json['experienceYears'] as int?,
      cropHistoryList: json['cropHistoryList'] != null
          ? (json['cropHistoryList'] as List).map((i) => CropHistory.fromJson(i as Map<String, dynamic>)).toList()
          : [],
      role: json['role'] as String? ?? 'farmer',
      sessionToken: json['sessionToken'] as String?,
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? mobile,
    String? location,
    int? age,
    String? farmSize,
    List<String>? preferredCrops,
    String? profileImagePath,
    List<String>? pastCrops,
    String? gender,
    String? dob,
    String? aadhaar,
    String? state,
    String? district,
    String? mandal,
    String? village,
    String? soilType,
    String? irrigationType,
    String? cropStage,
    int? experienceYears,
    List<CropHistory>? cropHistoryList,
    String? role,
    String? sessionToken,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      location: location ?? this.location,
      age: age ?? this.age,
      farmSize: farmSize ?? this.farmSize,
      preferredCrops: preferredCrops ?? this.preferredCrops,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      pastCrops: pastCrops ?? this.pastCrops,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      aadhaar: aadhaar ?? this.aadhaar,
      state: state ?? this.state,
      district: district ?? this.district,
      mandal: mandal ?? this.mandal,
      village: village ?? this.village,
      soilType: soilType ?? this.soilType,
      irrigationType: irrigationType ?? this.irrigationType,
      cropStage: cropStage ?? this.cropStage,
      experienceYears: experienceYears ?? this.experienceYears,
      cropHistoryList: cropHistoryList ?? this.cropHistoryList,
      role: role ?? this.role,
      sessionToken: sessionToken ?? this.sessionToken,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'mobile': mobile,
        'location': location,
        'age': age,
        'farmSize': farmSize,
        'preferredCrops': preferredCrops,
        'profileImagePath': profileImagePath,
        'pastCrops': pastCrops,
        'gender': gender,
        'dob': dob,
        'aadhaar': aadhaar,
        'state': state,
        'district': district,
        'mandal': mandal,
        'village': village,
        'soilType': soilType,
        'irrigationType': irrigationType,
        'cropStage': cropStage,
        'experienceYears': experienceYears,
        'cropHistoryList': cropHistoryList.map((e) => e.toJson()).toList(),
      };
}

// ══════════════════════════════════════════════════════════════════════════════
// ═════════════════════════



class CropTrackerEntry {



  final String id;



  final String cropName;



  final String cropEmoji;



  final DateTime sowingDate;



  final String? fieldNote;







  const CropTrackerEntry({



    required this.id,



    required this.cropName,



    required this.cropEmoji,



    required this.sowingDate,



    this.fieldNote,



  });







  /// Age in days from sowing to today



  int get ageInDays => DateTime.now().difference(sowingDate).inDays;







  Map<String, dynamic> toJson() => {



        'id': id,



        'cropName': cropName,



        'cropEmoji': cropEmoji,



        'sowingDate': sowingDate.toIso8601String(),



        'fieldNote': fieldNote,



      };







  factory CropTrackerEntry.fromJson(Map<String, dynamic> json) => CropTrackerEntry(



        id: json['id'] as String,



        cropName: json['cropName'] as String,



        cropEmoji: json['cropEmoji'] as String,



        sowingDate: DateTime.parse(json['sowingDate'] as String),



        fieldNote: json['fieldNote'] as String?,



      );



}







// ══════════════════════════════════════════════════════════════════════════════



// DAILY CARE TIP



// ══════════════════════════════════════════════════════════════════════════════



class DailyCareTip {



  final String emoji;



  final String title;



  final String message;



  final String category; // 'watering', 'fertilizer', 'pest', 'weather', 'harvest'







  const DailyCareTip({



    required this.emoji,



    required this.title,



    required this.message,



    required this.category,



  });



}



