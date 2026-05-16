library;







/// Crop growth stages, fertilizer days, irrigation, pest watch for 10 major crops



class CropStageData {



  CropStageData._();







  static const Map<String, Map<String, dynamic>> crops = {



    'Rice': {



      'emoji': '🌾', 'durationDays': 120,



      'stages': [



        {'name': 'Germination', 'startDay': 0, 'endDay': 7, 'emoji': '🌱'},



        {'name': 'Seedling', 'startDay': 8, 'endDay': 25, 'emoji': '🌿'},



        {'name': 'Tillering', 'startDay': 26, 'endDay': 50, 'emoji': '🌾'},



        {'name': 'Panicle Init', 'startDay': 51, 'endDay': 75, 'emoji': '🌼'},



        {'name': 'Flowering', 'startDay': 76, 'endDay': 90, 'emoji': '🌸'},



        {'name': 'Grain Fill', 'startDay': 91, 'endDay': 110, 'emoji': '🌾'},



        {'name': 'Harvest Ready', 'startDay': 111, 'endDay': 120, 'emoji': '🏆'},



      ],



      'fertilizerDays': [14, 35, 60],



      'irrigationIntervalDays': 3,



      'pestWatchDays': [30, 60, 85],



    },



    'Cotton': {



      'emoji': '🌿', 'durationDays': 180,



      'stages': [



        {'name': 'Germination', 'startDay': 0, 'endDay': 10, 'emoji': '🌱'},



        {'name': 'Seedling', 'startDay': 11, 'endDay': 30, 'emoji': '🌿'},



        {'name': 'Vegetative', 'startDay': 31, 'endDay': 70, 'emoji': '🍃'},



        {'name': 'Squaring', 'startDay': 71, 'endDay': 100, 'emoji': '🌼'},



        {'name': 'Flowering', 'startDay': 101, 'endDay': 130, 'emoji': '🌸'},



        {'name': 'Boll Dev', 'startDay': 131, 'endDay': 160, 'emoji': '☁️'},



        {'name': 'Harvest Ready', 'startDay': 161, 'endDay': 180, 'emoji': '🏆'},



      ],



      'fertilizerDays': [20, 45, 90],



      'irrigationIntervalDays': 7,



      'pestWatchDays': [40, 80, 120],



    },



    'Maize': {



      'emoji': '🌽', 'durationDays': 100,



      'stages': [



        {'name': 'Germination', 'startDay': 0, 'endDay': 7, 'emoji': '🌱'},



        {'name': 'Seedling', 'startDay': 8, 'endDay': 20, 'emoji': '🌿'},



        {'name': 'Vegetative', 'startDay': 21, 'endDay': 50, 'emoji': '🍃'},



        {'name': 'Tasseling', 'startDay': 51, 'endDay': 65, 'emoji': '🌼'},



        {'name': 'Silking', 'startDay': 66, 'endDay': 75, 'emoji': '🌸'},



        {'name': 'Grain Fill', 'startDay': 76, 'endDay': 90, 'emoji': '🌽'},



        {'name': 'Harvest Ready', 'startDay': 91, 'endDay': 100, 'emoji': '🏆'},



      ],



      'fertilizerDays': [15, 30, 55],



      'irrigationIntervalDays': 5,



      'pestWatchDays': [25, 55, 70],



    },



    'Groundnut': {



      'emoji': '🥜', 'durationDays': 130,



      'stages': [



        {'name': 'Germination', 'startDay': 0, 'endDay': 10, 'emoji': '🌱'},



        {'name': 'Vegetative', 'startDay': 11, 'endDay': 35, 'emoji': '🌿'},



        {'name': 'Flowering', 'startDay': 36, 'endDay': 60, 'emoji': '🌸'},



        {'name': 'Pegging', 'startDay': 61, 'endDay': 80, 'emoji': '⬇️'},



        {'name': 'Pod Dev', 'startDay': 81, 'endDay': 110, 'emoji': '🥜'},



        {'name': 'Maturity', 'startDay': 111, 'endDay': 125, 'emoji': '🟤'},



        {'name': 'Harvest Ready', 'startDay': 126, 'endDay': 130, 'emoji': '🏆'},



      ],



      'fertilizerDays': [20, 45],



      'irrigationIntervalDays': 6,



      'pestWatchDays': [30, 65, 90],



    },



    'Chilli': {



      'emoji': '🌶️', 'durationDays': 150,



      'stages': [



        {'name': 'Nursery', 'startDay': 0, 'endDay': 30, 'emoji': '🌱'},



        {'name': 'Transplant', 'startDay': 31, 'endDay': 45, 'emoji': '🌿'},



        {'name': 'Vegetative', 'startDay': 46, 'endDay': 75, 'emoji': '🍃'},



        {'name': 'Flowering', 'startDay': 76, 'endDay': 100, 'emoji': '🌸'},



        {'name': 'Fruit Set', 'startDay': 101, 'endDay': 130, 'emoji': '🌶️'},



        {'name': 'Harvest Ready', 'startDay': 131, 'endDay': 150, 'emoji': '🏆'},



      ],



      'fertilizerDays': [15, 40, 70, 100],



      'irrigationIntervalDays': 4,



      'pestWatchDays': [40, 80, 110],



    },



    'Tomato': {



      'emoji': '🍅', 'durationDays': 120,



      'stages': [



        {'name': 'Nursery', 'startDay': 0, 'endDay': 25, 'emoji': '🌱'},



        {'name': 'Transplant', 'startDay': 26, 'endDay': 40, 'emoji': '🌿'},



        {'name': 'Vegetative', 'startDay': 41, 'endDay': 65, 'emoji': '🍃'},



        {'name': 'Flowering', 'startDay': 66, 'endDay': 85, 'emoji': '🌸'},



        {'name': 'Fruit Dev', 'startDay': 86, 'endDay': 110, 'emoji': '🍅'},



        {'name': 'Harvest Ready', 'startDay': 111, 'endDay': 120, 'emoji': '🏆'},



      ],



      'fertilizerDays': [14, 35, 65, 90],



      'irrigationIntervalDays': 3,



      'pestWatchDays': [30, 65, 90],



    },



    'Wheat': {



      'emoji': '🌾', 'durationDays': 130,



      'stages': [



        {'name': 'Germination', 'startDay': 0, 'endDay': 7, 'emoji': '🌱'},



        {'name': 'Tillering', 'startDay': 8, 'endDay': 40, 'emoji': '🌿'},



        {'name': 'Jointing', 'startDay': 41, 'endDay': 65, 'emoji': '🍃'},



        {'name': 'Heading', 'startDay': 66, 'endDay': 85, 'emoji': '🌼'},



        {'name': 'Flowering', 'startDay': 86, 'endDay': 100, 'emoji': '🌸'},



        {'name': 'Grain Fill', 'startDay': 101, 'endDay': 120, 'emoji': '🌾'},



        {'name': 'Harvest Ready', 'startDay': 121, 'endDay': 130, 'emoji': '🏆'},



      ],



      'fertilizerDays': [21, 45, 80],



      'irrigationIntervalDays': 10,



      'pestWatchDays': [30, 60, 90],



    },



    'Sunflower': {



      'emoji': '🌻', 'durationDays': 100,



      'stages': [



        {'name': 'Germination', 'startDay': 0, 'endDay': 7, 'emoji': '🌱'},



        {'name': 'Vegetative', 'startDay': 8, 'endDay': 55, 'emoji': '🍃'},



        {'name': 'Bud Stage', 'startDay': 56, 'endDay': 70, 'emoji': '🌼'},



        {'name': 'Flowering', 'startDay': 71, 'endDay': 85, 'emoji': '🌻'},



        {'name': 'Seed Fill', 'startDay': 86, 'endDay': 95, 'emoji': '🟤'},



        {'name': 'Harvest Ready', 'startDay': 96, 'endDay': 100, 'emoji': '🏆'},



      ],



      'fertilizerDays': [20, 45],



      'irrigationIntervalDays': 7,



      'pestWatchDays': [35, 65],



    },



    'Soybean': {



      'emoji': '🫘', 'durationDays': 100,



      'stages': [



        {'name': 'Germination', 'startDay': 0, 'endDay': 7, 'emoji': '🌱'},



        {'name': 'Vegetative', 'startDay': 8, 'endDay': 45, 'emoji': '🍃'},



        {'name': 'Flowering', 'startDay': 46, 'endDay': 65, 'emoji': '🌸'},



        {'name': 'Pod Fill', 'startDay': 66, 'endDay': 85, 'emoji': '🫘'},



        {'name': 'Maturity', 'startDay': 86, 'endDay': 95, 'emoji': '🟤'},



        {'name': 'Harvest Ready', 'startDay': 96, 'endDay': 100, 'emoji': '🏆'},



      ],



      'fertilizerDays': [15, 40],



      'irrigationIntervalDays': 7,



      'pestWatchDays': [30, 60],



    },



    'Sugarcane': {



      'emoji': '🎋', 'durationDays': 365,



      'stages': [



        {'name': 'Germination', 'startDay': 0, 'endDay': 30, 'emoji': '🌱'},



        {'name': 'Tillering', 'startDay': 31, 'endDay': 90, 'emoji': '🌿'},



        {'name': 'Grand Growth', 'startDay': 91, 'endDay': 270, 'emoji': '🎋'},



        {'name': 'Maturation', 'startDay': 271, 'endDay': 330, 'emoji': '🟡'},



        {'name': 'Harvest Ready', 'startDay': 331, 'endDay': 365, 'emoji': '🏆'},



      ],



      'fertilizerDays': [30, 90, 150, 210],



      'irrigationIntervalDays': 10,



      'pestWatchDays': [60, 120, 200],



    },



  };







  static List<String> get cropNames => crops.keys.toList();



  static Map<String, dynamic>? getCrop(String name) => crops[name];







  static Map<String, dynamic> getCurrentStage(String cropName, int ageInDays) {



    final crop = crops[cropName];



    if (crop == null) return {'name': 'Unknown', 'emoji': '🌱', 'startDay': 0, 'endDay': 30};



    final stages = crop['stages'] as List;



    for (final stage in stages.reversed) {



      if (ageInDays >= (stage['startDay'] as int)) return Map<String, dynamic>.from(stage as Map);



    }



    return Map<String, dynamic>.from(stages.first as Map);



  }







  static int? nextFertilizerDay(String cropName, int ageInDays) {



    final days = List<int>.from((crops[cropName]?['fertilizerDays'] as List?) ?? []);



    for (final d in days) { if (d > ageInDays) return d; }



    return null;



  }







  static int? nextPestWatchDay(String cropName, int ageInDays) {



    final days = List<int>.from((crops[cropName]?['pestWatchDays'] as List?) ?? []);



    for (final d in days) { if (d > ageInDays) return d; }



    return null;



  }







  static int daysToHarvest(String cropName, int ageInDays) {



    final total = (crops[cropName]?['durationDays'] as int?) ?? 120;



    return (total - ageInDays).clamp(0, total);



  }







  static int irrigationInterval(String cropName) =>



      (crops[cropName]?['irrigationIntervalDays'] as int?) ?? 5;







  static bool isFlowering(String cropName, int ageInDays) =>



      (getCurrentStage(cropName, ageInDays)['name'] as String)



          .toLowerCase()



          .contains('flower');



}



