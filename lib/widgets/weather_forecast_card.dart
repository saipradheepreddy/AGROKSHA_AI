/// ─────────────────────────────────────────────────────────────────────────────€
/// AGROKSHA AI — Weather Forecast Card Widget
/// Premium weather display with current conditions + 7-day forecast carousel
/// ─────────────────────────────────────────────────────────────────────────────€
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../utils/app_provider.dart';
import '../services/voice_service.dart';
class WeatherForecastCard extends StatelessWidget {
  final WeatherModel weather;
  final List<WeatherDay> forecast;
  final VoidCallback onRefresh;
  const WeatherForecastCard({
    super.key,
    required this.weather,
    required this.forecast,
    required this.onRefresh,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.skyGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1565C0).withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header: location + refresh ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on_rounded, color: Colors.white70, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    weather.locationName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.volume_up_rounded, color: Colors.white),
                    onPressed: () {
                      final provider = context.read<AppProvider>();
                      final voice = VoiceService();
                      final msg = voice.buildWeatherGreeting(weather, provider.language);
                      voice.speak(msg, language: provider.language, speed: provider.voiceSpeed);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(Icons.refresh_rounded, color: Colors.white),
                    onPressed: onRefresh,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          // ── Main temperature + condition ──
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weather.conditionIcon,
                    style: const TextStyle(fontSize: 44),
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: '${weather.temperature.toStringAsFixed(1)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
                      const TextSpan(
                        text: '°C',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    weather.condition,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Feels like ${weather.apparentTemperature.toInt()}°',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.55),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Stats column
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _StatRow(emoji: '💧', value: '${weather.humidity.toInt()}%', label: 'Humidity'),
                  const SizedBox(height: 12),
                  _StatRow(emoji: '🌧️', value: '${weather.rainChance.toInt()}%', label: 'Rain'),
                  const SizedBox(height: 12),
                  _StatRow(emoji: '🌬️', value: '${weather.windSpeed.toInt()} km/h', label: 'Wind'),
                  const SizedBox(height: 12),
                  _StatRow(emoji: '🌅', value: weather.sunrise, label: 'Sunrise'),
                  const SizedBox(height: 12),
                  _StatRow(emoji: '🌇', value: weather.sunset, label: 'Sunset'),
                ],
              ),
            ],
          ),
          // ── 🌧️ WILL IT RAIN? Banner ──────────────────────────────────────────
          Builder(builder: (ctx) {
            // Find first rainy day in forecast
            String? rainMsg;
            Color rainColor = const Color(0xFF1565C0);
            String rainIcon = '☀️';
            final todayRain = weather.rainChance;
            if (todayRain >= 60) {
              rainMsg = 'Heavy rain expected TODAY — avoid spraying & outdoor work';
              rainColor = const Color(0xFF0D47A1);
              rainIcon = '⛈️ ';
            } else if (todayRain >= 40) {
              rainMsg = 'Rain likely TODAY (${todayRain.toInt()}%) — plan field work for morning';
              rainColor = const Color(0xFF1565C0);
              rainIcon = '🌧️ ';
            } else if (todayRain >= 20) {
              rainMsg = 'Light rain chance today (${todayRain.toInt()}%) — safe to spray';
              rainColor = const Color(0xFF1976D2);
              rainIcon = '🌦️ ';
            } else {
              // Check forecast for next rainy day
              for (int i = 0; i < forecast.length; i++) {
                final day = forecast[i];
                if (day.emoji.contains('🌧️') || day.emoji.contains('⛈️') || day.emoji.contains('🌦️')) {
                  rainMsg = 'Rain expected on ${day.dayLabel} — safe to spray until then';
                  rainColor = const Color(0xFF1565C0);
                  rainIcon = '🌧️ ';
                  break;
                }
              }
              rainMsg ??= '☀️  No rain this week — ensure irrigation for crops';
              rainIcon = '☀️ ';
              rainColor = const Color(0xFFE65100);
            }
            return Container(
              margin: const EdgeInsets.only(top: 14, bottom: 4),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
              ),
              child: Row(children: [
                Text(rainIcon, style: const TextStyle(fontSize: 22)),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('WILL IT RAIN?', style: TextStyle(color: Colors.white70, fontSize: 9,
                      fontWeight: FontWeight.w800, letterSpacing: 1.0)),
                  const SizedBox(height: 2),
                  Text(rainMsg, style: const TextStyle(color: Colors.white, fontSize: 12,
                      fontWeight: FontWeight.w700, height: 1.3)),
                ])),
              ]),
            );
          }),
          // ── 7-day Forecast carousel ──
          if (forecast.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(color: Colors.white24, height: 1),
            ),
            const Text(
              '7-Day Forecast',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: forecast.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) => ForecastDayTile(day: forecast[index], forecastIndex: index),
              ),
            ),
          ],
        ],
      ),
    )
        .animate()
        .fadeIn(delay: 200.ms, duration: 500.ms)
        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic);
  }
}
/// Right-aligned stat row
class _StatRow extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;
  const _StatRow({
    required this.emoji,
    required this.value,
    required this.label,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.white60, fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }
}
/// Single day tile for the forecast carousel
class ForecastDayTile extends StatelessWidget {
  final WeatherDay day;
  final int forecastIndex;
  const ForecastDayTile({super.key, required this.day, this.forecastIndex = -1});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            forecastIndex == 0 ? 'Today' : (forecastIndex == 1 ? 'Tomorrow' : day.dayLabel),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          Text(day.emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 6),
          Text(
            '${day.maxTemp.toInt()}°/${day.minTemp.toInt()}°',
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
