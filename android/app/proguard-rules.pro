# Flutter ProGuard Rules for AGROKSHA AI
# Keeps all Flutter/Dart runtime classes intact while enabling R8 code shrinking

# ── Critical: Suppress missing Play Core classes (Flutter deferred components) ──
-dontwarn com.google.android.play.core.**
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.splitcompat.**

-keep class io.flutter.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }

# ── Google Play Core (needed for AAB dynamic delivery) ────────────────────────
-keep class com.google.android.play.** { *; }

# ── Kotlin ────────────────────────────────────────────────────────────────────
-keep class kotlin.** { *; }
-keep class kotlinx.** { *; }
-dontwarn kotlin.**

# ── OkHttp / http package ─────────────────────────────────────────────────────
-keep class okhttp3.** { *; }
-dontwarn okhttp3.**
-dontwarn okio.**

# ── Geolocator ────────────────────────────────────────────────────────────────
-keep class com.baseflow.geolocator.** { *; }

# ── Flutter TTS ───────────────────────────────────────────────────────────────
-keep class com.tundralabs.fluttertts.** { *; }

# ── URL Launcher ──────────────────────────────────────────────────────────────
-keep class io.flutter.plugins.urllauncher.** { *; }

# ── Image Picker ──────────────────────────────────────────────────────────────
-keep class io.flutter.plugins.imagepicker.** { *; }

# ── WebView ───────────────────────────────────────────────────────────────────
-keep class com.google.android.** { *; }
-dontwarn com.google.android.maps.**

# ── QR Flutter ────────────────────────────────────────────────────────────────
-keep class net.glxn.** { *; }

# ── Share Plus ────────────────────────────────────────────────────────────────
-keep class dev.fluttercommunity.plus.share.** { *; }

# ── Google Fonts ──────────────────────────────────────────────────────────────
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

# ── General Android ───────────────────────────────────────────────────────────
-keep class androidx.** { *; }
-keep class android.** { *; }
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes SourceFile,LineNumberTable
-dontwarn javax.**
-dontwarn org.slf4j.**
