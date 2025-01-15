import 'dart:convert';
import 'package:http/http.dart' as http;

/// Service class to handle weather data fetching from Open-Meteo API
class WeatherService {
  // Konya's geographical coordinates
  static const String _KONYA_LAT = '37.8714';
  static const String _KONYA_LON = '32.4846';
  static const String _BASE_URL = 'api.open-meteo.com';

  /// Fetches current weather data for Konya
  /// Returns a [WeatherData] object containing temperature and weather condition
  /// Throws an exception if the API request fails
  Future<WeatherData> getCurrentWeather() async {
    try {
      // Construct API URL with parameters
      final uri = Uri.https(_BASE_URL, '/v1/forecast', {
        'latitude': _KONYA_LAT,
        'longitude': _KONYA_LON,
        'current':
            'temperature_2m,weather_code', // Request temperature and weather code
      });

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherData.fromJson(data);
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get weather data: $e');
    }
  }
}

/// Data model for weather information
class WeatherData {
  final double temperature;
  final int? weatherCode;

  WeatherData({
    required this.temperature,
    this.weatherCode,
  });

  /// Creates a WeatherData instance from JSON response
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: json['current']['temperature_2m']?.toDouble() ?? 0.0,
      weatherCode: json['current']['weather_code'],
    );
  }

  /// Converts WMO weather codes to human-readable conditions
  /// Based on Open-Meteo API documentation: https://open-meteo.com/en/docs
  String get condition {
    if (weatherCode == null) return 'Unknown';

    // WMO Weather interpretation codes
    if (weatherCode! < 10) return 'Clear'; // 0-9: Clear sky
    if (weatherCode! < 20) return 'Partly Cloudy'; // 10-19: Partly cloudy
    if (weatherCode! < 30) return 'Cloudy'; // 20-29: Cloudy
    if (weatherCode! < 50) return 'Foggy'; // 30-49: Fog
    if (weatherCode! < 70) return 'Rainy'; // 50-69: Rain
    if (weatherCode! < 80) return 'Snowy'; // 70-79: Snow
    if (weatherCode! < 90) return 'Thunderstorm'; // 80-89: Rain showers
    return 'Unknown';
  }
}
