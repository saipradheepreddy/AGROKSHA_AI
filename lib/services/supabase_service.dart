import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:agrisense_ai/models/models.dart';
import 'package:flutter/foundation.dart';

class SupabaseService {
  static final SupabaseClient _supabase = Supabase.instance.client;

  /// Syncs the user profile to Supabase.
  static Future<void> syncUserProfile(UserModel user) async {
    try {
      if (user.id.isEmpty) return; // Wait until a valid ID is generated locally
      
      final data = {
        'id': user.id,
        'name': user.name,
        'email': user.email,
        'mobile': user.mobile,
        'aadhaar': user.aadhaar,
        'farmSize': user.farmSize,
        'irrigationType': user.irrigationType,
        'soilType': user.soilType,
        'gender': user.gender,
        'dob': user.dob,
        'state': user.state,
        'district': user.district,
        'mandal': user.mandal,
        'village': user.village,
        'experienceYears': user.experienceYears,
        'role': user.role,
        'sessionToken': user.sessionToken,
        'lastUpdated': DateTime.now().toIso8601String(),
        'cropHistoryList': user.cropHistoryList.map((ch) => ch.toJson()).toList(),
      };

      await _supabase.from('farmers').upsert(data);
      debugPrint('Successfully synced farmer profile to Supabase: ${user.id}');
    } catch (e) {
      debugPrint('Supabase Sync Error: $e');
    }
  }

  /// Fetches the user profile from Supabase.
  static Future<UserModel?> fetchUserProfile(String userId) async {
    try {
      final response = await _supabase
          .from('farmers')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (response != null) {
        return UserModel.fromJson(response);
      }
    } catch (e) {
      debugPrint('Supabase Fetch Error: $e');
    }
    return null;
  }

  /// Deletes the user profile from Supabase
  static Future<void> deleteUserProfile(String userId) async {
    try {
      await _supabase.from('farmers').delete().eq('id', userId);
      debugPrint('Successfully deleted user profile from Supabase: $userId');
    } catch (e) {
      debugPrint('Supabase Delete Error: $e');
    }
  }
}
