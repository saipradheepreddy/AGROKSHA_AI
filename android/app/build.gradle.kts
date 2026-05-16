plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.agrisense.agrisense_ai"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.teamsara.agroksha"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")

            // R8 disabled — Flutter plugin reflection breaks with aggressive minification
            // Size savings come from --split-per-abi flag instead (60MB → 22MB)
            isMinifyEnabled = false
            isShrinkResources = false
        }
        debug {
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }

    // ── Split APKs by CPU architecture for Play Store ─────────────────────────
    // Each device downloads only the slice it needs (saves 40-50% download size)
    splits {
        abi {
            isEnable = true
            reset()
            include("arm64-v8a", "armeabi-v7a", "x86_64")
            isUniversalApk = true  // Also build a universal APK for sideloading
        }
    }

    // ── Packaging options ─────────────────────────────────────────────────────
    packaging {
        resources {
            // Remove duplicate files that bloat the APK
            excludes += setOf(
                "META-INF/DEPENDENCIES",
                "META-INF/LICENSE",
                "META-INF/LICENSE.txt",
                "META-INF/NOTICE",
                "META-INF/NOTICE.txt",
                "META-INF/*.kotlin_module",
                "**/kotlin/**",
                "**/*.txt",
                "**/*.md"
            )
        }
        jniLibs {
            // Strip debug symbols from native libs (reduces size)
            useLegacyPackaging = false
        }
    }
}

flutter {
    source = "../.."
}
