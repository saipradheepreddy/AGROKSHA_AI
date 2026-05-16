import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class SupabaseAuthService {
  static final SupabaseClient _supabase = Supabase.instance.client;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Expose auth state stream
  static Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  // Get current user
  static User? get currentUser => _supabase.auth.currentUser;

  // ── Email/Password ─────────────────────────────────────────────────────

  static Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _supabase.auth.signUp(
        email: email,
        password: password,
      );
    } on AuthException catch (e) {
      throw e.message;
    }
  }

  static Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException catch (e) {
      throw e.message;
    }
  }

  // ── Google Sign-In ─────────────────────────────────────────────────────

  static Future<bool> signInWithGoogle() async {
    try {
      debugPrint("AuthService: Starting Google Sign In (Supabase OAuth)...");
      
      // For mobile native Google Sign-In with Supabase:
      // 1. Get ID Token from GoogleSignIn
      // 2. Sign in to Supabase with ID Token
      
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return false;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw 'No ID Token found.';
      }

      await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      return true;
    } on AuthException catch (e) {
      throw e.message;
    } catch (e) {
      debugPrint("AuthService: Unexpected Google Sign In Error: $e");
      throw "Google Sign-In failed. Please try again.";
    }
  }

  static Future<AuthResponse> signInAnonymously() async {
    try {
      return await _supabase.auth.signInAnonymously();
    } on AuthException catch (e) {
      throw e.message;
    }
  }

  // ── Password Reset ──────────────────────────────────────────────────────

  static Future<void> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw e.message;
    }
  }

  // ── Logout ─────────────────────────────────────────────────────────────

  static Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await _supabase.auth.signOut();
      debugPrint("AuthService: Logged out from Supabase.");
    } catch (e) {
      debugPrint("AuthService: Logout Error: $e");
    }
  }
}
