import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LocationPermissionDialog extends StatelessWidget {
  final VoidCallback onAllow;
  final VoidCallback onDeny;

  const LocationPermissionDialog({
    Key? key,
    required this.onAllow,
    required this.onDeny,
  }) : super(key: key);

  static Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => LocationPermissionDialog(
        onAllow: () => Navigator.of(ctx).pop(true),
        onDeny: () => Navigator.of(ctx).pop(false),
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: const [
          Icon(Icons.location_on, color: AppColors.primary),
          SizedBox(width: 8),
          Text('Location Access', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      content: const Text(
        'AGROKSHA AI needs your location to provide accurate local weather forecasts, '
        'nearby market prices (e-NAM), and specific crop risk alerts for your Mandal/District. '
        'Your location data is strictly used for farming insights and never shared with third parties.',
        style: TextStyle(height: 1.5),
      ),
      actions: [
        TextButton(
          onPressed: onDeny,
          child: const Text('Not Now', style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          onPressed: onAllow,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Allow Location'),
        ),
      ],
    );
  }
}
