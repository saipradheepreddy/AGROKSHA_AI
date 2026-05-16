/// ─────────────────────────────────────────────────────────────────────────────



/// AGROKSHA AI — Weather Service



/// Uses Open-Meteo free API (no API key required)



/// Replace lat/lon with user's saved district coordinates



/// ─────────────────────────────────────────────────────────────────────────────







import 'dart:convert';



import 'package:http/http.dart' as http;



import '../models/models.dart';







class WeatherService {



  WeatherService._();







  static const String _baseUrl = 'https://api.open-meteo.com/v1/forecast';







  /// Fetch current weather + 7-day daily forecast



  static Future<WeatherResult> fetchWeather({



    required double lat,



    required double lon,



    required String locationName,



  }) async {



    final uri = Uri.parse(_baseUrl).replace(queryParameters: {



      'latitude': lat.toString(),



      'longitude': lon.toString(),



      'current': [



        'temperature_2m',



        'apparent_temperature',



        'relative_humidity_2m',



        'precipitation_probability',



        'wind_speed_10m',



        'weather_code',



      ].join(','),



      'daily': [



        'weather_code',



        'temperature_2m_max',



        'temperature_2m_min',



        'precipitation_probability_max',



        'sunrise',



        'sunset',



      ].join(','),



      'timezone': 'Asia/Kolkata',



      'forecast_days': '7',



    });







    final response = await http.get(uri).timeout(const Duration(seconds: 15));







    if (response.statusCode != 200) {



      throw Exception('Weather API returned ${response.statusCode}');



    }







    final json = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;



    return WeatherResult.fromJson(json, locationName);



  }







  /// Map WMO weather code to human-readable condition + emoji



  static ({String condition, String emoji}) describeCode(int code) {



    if (code == 0) return (condition: 'Clear Sky', emoji: '☀️');



    if (code <= 2) return (condition: 'Partly Cloudy', emoji: '⛅');



    if (code == 3) return (condition: 'Overcast', emoji: '☁️');



    if (code <= 49) return (condition: 'Foggy', emoji: '🌫️');



    if (code <= 59) return (condition: 'Drizzle', emoji: '🌦️');



    if (code <= 69) return (condition: 'Rain', emoji: '🌧️');



    if (code <= 79) return (condition: 'Snow', emoji: '❄️');



    if (code <= 82) return (condition: 'Showers', emoji: '🌦️');



    if (code <= 84) return (condition: 'Heavy Showers', emoji: '⛈️');



    if (code <= 99) return (condition: 'Thunderstorm', emoji: '⛈️');



    return (condition: 'Unknown', emoji: '🌡️');



  }







  /// Format time string (ISO) to HH:MM



  static String formatTime(String isoTime) {



    try {



      final dt = DateTime.parse(isoTime);



      final h = dt.hour.toString().padLeft(2, '0');



      final m = dt.minute.toString().padLeft(2, '0');



      return '$h:$m';



    } catch (_) {



      return '--:--';



    }



  }







  /// Short day label from date string (YYYY-MM-DD)



  static String shortDay(String dateStr) {



    try {



      final dt = DateTime.parse(dateStr);



      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];



      return days[dt.weekday - 1];



    } catch (_) {



      return '---';



    }



  }



}







/// Parsed weather result containing current + 7-day forecast



class WeatherResult {



  final WeatherModel current;



  final List<WeatherDay> forecast;







  const WeatherResult({required this.current, required this.forecast});







  factory WeatherResult.fromJson(Map<String, dynamic> json, String locationName) {



    final cur = json['current'] as Map<String, dynamic>;



    final daily = json['daily'] as Map<String, dynamic>;







    final code = (cur['weather_code'] as num).toInt();



    final desc = WeatherService.describeCode(code);







    // Sunrise / Sunset from day 0



    final sunriseList = daily['sunrise'] as List<dynamic>;



    final sunsetList = daily['sunset'] as List<dynamic>;







    final current = WeatherModel(



      temperature: (cur['temperature_2m'] as num).toDouble(),



      apparentTemperature: (cur['apparent_temperature'] as num).toDouble(),



      humidity: (cur['relative_humidity_2m'] as num).toDouble(),



      rainChance: (cur['precipitation_probability'] as num).toDouble(),



      windSpeed: (cur['wind_speed_10m'] as num).toDouble(),



      condition: desc.condition,



      conditionIcon: desc.emoji,



      locationName: locationName,



      sunrise: WeatherService.formatTime(sunriseList[0] as String),



      sunset: WeatherService.formatTime(sunsetList[0] as String),



    );







    final dates = daily['time'] as List<dynamic>;



    final codes = daily['weather_code'] as List<dynamic>;



    final maxTemps = daily['temperature_2m_max'] as List<dynamic>;



    final minTemps = daily['temperature_2m_min'] as List<dynamic>;



    final rainProbs = daily['precipitation_probability_max'] as List<dynamic>;







    final forecast = List.generate(dates.length, (i) {



      final dayCode = (codes[i] as num).toInt();



      final dayDesc = WeatherService.describeCode(dayCode);



      return WeatherDay(



        date: dates[i] as String,



        dayLabel: WeatherService.shortDay(dates[i] as String),



        emoji: dayDesc.emoji,



        condition: dayDesc.condition,



        maxTemp: (maxTemps[i] as num).toDouble(),



        minTemp: (minTemps[i] as num).toDouble(),



        rainChance: (rainProbs[i] as num? ?? 0).toDouble(),



      );



    });







    return WeatherResult(current: current, forecast: forecast);



  }



}



