
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_provider.dart';
import '../theme/app_theme.dart';
import '../data/translations.dart';

class AgrokshaSangamScreen extends StatefulWidget {
  const AgrokshaSangamScreen({super.key});

  @override
  State<AgrokshaSangamScreen> createState() => _AgrokshaSangamScreenState();
}

class _AgrokshaSangamScreenState extends State<AgrokshaSangamScreen> {
  @override
  Widget build(BuildContext context) {
    final lang = context.watch<AppProvider>().language;
    final isTe = lang == AppLanguage.telugu;

    return Scaffold(
      appBar: AppBar(
        title: Text(isTe ? '🤝 అగోక్ష సంఘం' : '🤝 Agroksha Sangam'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.groups_rounded, size: 80, color: AppColors.primary.withValues(alpha: 0.2)),
            const SizedBox(height: 24),
            Text(isTe ? 'అగోక్ష సంఘం' : 'Agroksha Sangam', 
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                isTe ? 'రైతుల సంఘం మరియు చర్చలు త్వరలో రానున్నాయి.' : 'Farmer Community & Discussions coming soon.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
